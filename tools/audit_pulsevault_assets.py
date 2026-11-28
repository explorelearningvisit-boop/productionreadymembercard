#!/usr/bin/env python3
"""Audit PulseVault image dimensions, alpha channel, subject bounds and file size.

This script is read-only: it never modifies source assets.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path
from typing import Any

try:
    from PIL import Image
except ImportError as exc:  # pragma: no cover - exercised in GitHub Actions
    raise SystemExit(
        "Pillow is required. Run: python -m pip install Pillow"
    ) from exc


ROLE_HINTS = {
    "01_member_bodybuilder.webp": "member portrait / transparent hero cut-out",
    "03_whey_protein_tub.webp": "whey offer / product cut-out",
    "04_purple_shaker.webp": "freeze bottle candidate / replace if purple conflicts",
    "05_blinkit_grocery_bag.webp": "partner offer illustration / demo only unless licensed",
    "06_creatine_tub.webp": "workout KPI product cut-out",
    "08_gold_profile_badge_panel.webp": "profile badge backplate / consider native Flutter surface",
    "10_gold_photo_backplate.webp": "portrait backplate / decorative panel candidate",
    "15_purple_progress_bar.webp": "retire from progress UI; use native emerald Flutter progress",
    "21_gold_plan_badge_background.webp": "Gold Plan badge candidate / compare with native gradient",
    "22_green_active_badge_background.webp": "Active badge candidate / compare with native Flutter pill",
    "23_freeze_snowflake_graphic.webp": "Freeze icon / verify readability and alpha",
    "25_calendar_graphic.webp": "calendar icon / likely native Icon replacement",
    "27_dumbbell_promo_graphic.webp": "recovery/workout campaign art",
    "28_protinex_tub.webp": "attendance KPI product cut-out",
    "29_sbi_payment_card_graphic.webp": "payment KPI illustration",
    "fat_loss_support_tub.png": "body KPI product cut-out",
}

TARGET_SLOTS = {
    "01_member_bodybuilder.webp": (84, 88),
    "03_whey_protein_tub.webp": (76, 52),
    "04_purple_shaker.webp": (46, 48),
    "05_blinkit_grocery_bag.webp": (44, 34),
    "06_creatine_tub.webp": (60, 54),
    "23_freeze_snowflake_graphic.webp": (18, 18),
    "27_dumbbell_promo_graphic.webp": (66, 42),
    "28_protinex_tub.webp": (60, 54),
    "29_sbi_payment_card_graphic.webp": (64, 48),
    "fat_loss_support_tub.png": (60, 54),
}


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def inspect_image(path: Path, root: Path) -> dict[str, Any]:
    with Image.open(path) as image:
        width, height = image.size
        fmt = image.format or path.suffix.lstrip(".").upper()
        mode = image.mode
        has_alpha_channel = "A" in image.getbands() or "transparency" in image.info

        if has_alpha_channel:
            alpha = image.convert("RGBA").getchannel("A")
            alpha_min, alpha_max = alpha.getextrema()
            alpha_bbox = alpha.getbbox()
            histogram = alpha.histogram()
            transparent_count = histogram[0]
            translucent_count = sum(histogram[1:255])
            opaque_count = histogram[255]
            if alpha_bbox is None:
                alpha_state = "fully-transparent"
                margins = None
                edge_touch = False
            else:
                left, top, right, bottom = alpha_bbox
                margins = {
                    "left_pct": round(left / width * 100, 2),
                    "top_pct": round(top / height * 100, 2),
                    "right_pct": round((width - right) / width * 100, 2),
                    "bottom_pct": round((height - bottom) / height * 100, 2),
                }
                edge_touch = left == 0 or top == 0 or right == width or bottom == height
                alpha_state = (
                    "true-alpha"
                    if transparent_count > 0 and alpha_max > 0
                    else "alpha-channel-fully-opaque"
                )
        else:
            alpha_min = alpha_max = None
            alpha_bbox = None
            margins = None
            edge_touch = False
            transparent_count = translucent_count = 0
            opaque_count = width * height
            alpha_state = "no-alpha-channel"

    relative = path.relative_to(root).as_posix()
    size_bytes = path.stat().st_size
    ratio = round(width / height, 4) if height else None
    slot = TARGET_SLOTS.get(path.name)
    display_slot = f"{slot[0]}×{slot[1]}dp" if slot else "role-dependent; verify in layout"
    export_px = f"{slot[0] * 3}×{slot[1] * 3}px" if slot else "derive after measured slot"
    subject_bbox = (
        [alpha_bbox[0], alpha_bbox[1], alpha_bbox[2], alpha_bbox[3]]
        if alpha_bbox else None
    )
    warnings: list[str] = []
    if alpha_state == "no-alpha-channel":
        warnings.append("No alpha channel; use only as a deliberate full-card/backplate, not a cut-out.")
    elif alpha_state == "alpha-channel-fully-opaque":
        warnings.append("Alpha channel exists but contains no transparent pixels.")
    if edge_touch:
        warnings.append("Visible subject touches one or more canvas edges; inspect for clipped silhouette.")
    if alpha_state == "fully-transparent":
        warnings.append("No visible subject pixels.")
    if path.name.startswith("04_purple") or "purple_progress" in path.name:
        warnings.append("Palette conflict candidate under Emerald/Pearl visual master.")
    return {
        "file": relative,
        "format": fmt,
        "mode": mode,
        "width_px": width,
        "height_px": height,
        "aspect_ratio": ratio,
        "size_bytes": size_bytes,
        "sha256": sha256_file(path),
        "alpha_state": alpha_state,
        "alpha_min": alpha_min,
        "alpha_max": alpha_max,
        "transparent_pixels_pct": round(transparent_count / (width * height) * 100, 2),
        "translucent_pixels_pct": round(translucent_count / (width * height) * 100, 2),
        "alpha_subject_bbox_xyxy": subject_bbox,
        "transparent_margins": margins,
        "subject_touches_canvas_edge": edge_touch,
        "suggested_slot": display_slot,
        "suggested_new_export": export_px,
        "role_hint": ROLE_HINTS.get(path.name, "inspect role manually"),
        "warnings": warnings,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--json-out", type=Path, required=True)
    parser.add_argument("--markdown-out", type=Path, required=True)
    args = parser.parse_args()

    root = args.root.resolve()
    manifest_path = args.manifest.resolve()
    if not root.is_dir():
        parser.error(f"asset root does not exist: {root}")
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    names = [item["name"] for item in manifest.get("files", [])]
    if not names:
        names = sorted(p.name for p in root.iterdir() if p.suffix.lower() in {".webp", ".png", ".jpg", ".jpeg"})

    results: list[dict[str, Any]] = []
    missing: list[str] = []
    for name in names:
        path = root / name
        if not path.is_file():
            missing.append(name)
            continue
        try:
            results.append(inspect_image(path, root))
        except Exception as exc:  # keep auditing other files if one is malformed
            results.append({"file": name, "error": f"{type(exc).__name__}: {exc}"})

    report = {
        "audit_version": 1,
        "asset_root": str(root),
        "manifest_file_count": len(names),
        "audited_file_count": len(results),
        "missing_files": missing,
        "visual_master": "Emerald Pearl",
        "files": results,
    }
    args.json_out.parent.mkdir(parents=True, exist_ok=True)
    args.markdown_out.parent.mkdir(parents=True, exist_ok=True)
    args.json_out.write_text(json.dumps(report, indent=2), encoding="utf-8")

    lines = [
        "# PulseVault asset audit",
        "",
        f"- Manifest entries: {len(names)}",
        f"- Audited files: {len(results)}",
        f"- Missing files: {len(missing)}",
        "- Source files are not modified by this audit.",
        "",
        "| File | Size | Format | Dimensions | Ratio | Alpha | Transparent % | Subject touches edge | Target slot | Role |",
        "|---|---:|---|---:|---:|---|---:|---|---|---|",
    ]
    for item in results:
        if "error" in item:
            lines.append(f"| {item['file']} | — | — | — | — | ERROR | — | — | — | {item['error']} |")
            continue
        lines.append(
            f"| {item['file']} | {item['size_bytes']:,} B | {item['format']} | "
            f"{item['width_px']}×{item['height_px']} | {item['aspect_ratio']} | "
            f"{item['alpha_state']} | {item['transparent_pixels_pct']}% | "
            f"{item['subject_touches_canvas_edge']} | {item['suggested_slot']} / {item['suggested_new_export']} | "
            f"{item['role_hint']} |"
        )
    if missing:
        lines += ["", "## Missing manifest entries", *[f"- {name}" for name in missing]]
    warnings = [(item["file"], warning) for item in results for warning in item.get("warnings", [])]
    if warnings:
        lines += ["", "## Review flags"]
        lines.extend(f"- **{name}:** {warning}" for name, warning in warnings)
    lines += [
        "",
        "## Interpretation rules",
        "- A transparent image is not automatically a good crop; inspect subject bounds and silhouette.",
        "- Opaque images may be valid full-panel backgrounds/backplates, but should not be placed in isolated cut-out slots.",
        "- Compare the suggested export size with the actual measured Flutter slot before generating or resizing.",
        "- Purple assets are palette-conflict candidates; do not delete until an Emerald/Pearl replacement is validated.",
    ]
    args.markdown_out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"Audited {len(results)} files; {len(missing)} missing. Reports: {args.json_out}, {args.markdown_out}")
    return 0 if not missing else 1


if __name__ == "__main__":
    raise SystemExit(main())
