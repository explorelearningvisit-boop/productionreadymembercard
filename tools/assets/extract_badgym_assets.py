#!/usr/bin/env python3
"""Rebuild approved BAD GYM transparent PNGs from reviewed crop coordinates.

The manifest is the source of truth for semantic filenames, source bounding
boxes and 2x output dimensions. The tool never guesses sprite-cell geometry.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
from PIL import Image


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, required=True,
                        help="Original transparent RGBA asset sheet")
    parser.add_argument("--manifest", type=Path, required=True,
                        help="Reviewed ASSET_MANIFEST.json with source_bbox/output_px")
    parser.add_argument("--out", type=Path, default=Path("assets/images/individual"))
    args = parser.parse_args()

    manifest = json.loads(args.manifest.read_text(encoding="utf-8"))
    source = Image.open(args.source).convert("RGBA")
    expected = manifest.get("source_size")
    if expected and list(source.size) != expected:
        raise SystemExit(f"Source size mismatch: expected {expected}, got {source.size}")

    args.out.mkdir(parents=True, exist_ok=True)
    results = []
    for item in manifest["assets"]:
        name = item["name"]
        box = tuple(item["source_bbox"])
        output_size = tuple(item["output_px"])
        if len(box) != 4 or box[0] < 0 or box[1] < 0 or box[2] > source.width or box[3] > source.height:
            raise SystemExit(f"Invalid crop bounds for {name}: {box}")
        if box[2] <= box[0] or box[3] <= box[1]:
            raise SystemExit(f"Empty crop bounds for {name}: {box}")

        crop = source.crop(box)
        if crop.getchannel("A").getbbox() is None:
            raise SystemExit(f"Crop {name} contains no visible pixels")
        if crop.size != output_size:
            crop = crop.resize(output_size, Image.Resampling.LANCZOS)

        destination = args.out / f"{name}.png"
        crop.save(destination, format="PNG", optimize=True)
        check = Image.open(destination)
        if check.mode != "RGBA":
            raise SystemExit(f"{destination} lost RGBA mode")
        alpha_min, alpha_max = check.getchannel("A").getextrema()
        if alpha_max == 0:
            raise SystemExit(f"{destination} is fully transparent")
        results.append({
            "name": name,
            "file": destination.name,
            "source_bbox": list(box),
            "output_px": list(check.size),
            "mode": check.mode,
            "alpha_extrema": [alpha_min, alpha_max],
            "sha256": sha256(destination),
            "bytes": destination.stat().st_size,
        })

    output_manifest = {
        "source": args.source.name,
        "source_size": list(source.size),
        "method": "reviewed object bounds; source alpha retained; Lanczos resize only",
        "asset_count": len(results),
        "assets": results,
    }
    (args.out / "ASSET_MANIFEST.json").write_text(
        json.dumps(output_manifest, indent=2) + "\n", encoding="utf-8")
    print(f"PASS: {len(results)} RGBA PNG assets written to {args.out}")
    print("PASS: crop bounds, output dimensions, alpha channel and SHA-256 recorded")


if __name__ == "__main__":
    main()
