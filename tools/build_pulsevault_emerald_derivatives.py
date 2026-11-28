#!/usr/bin/env python3
"""Create true-alpha, padded PulseVault derivatives from immutable source art."""
from __future__ import annotations
import argparse
import hashlib
import json
from pathlib import Path
import cv2
import numpy as np
from PIL import Image, ImageFilter

MAPPING = {
    "01_member_bodybuilder.webp": ("01_member_portrait_cutout.webp", (192, 192), "Profile portrait and check-in hero"),
    "03_whey_protein_tub.webp": ("03_whey_promo_cutout.webp", (144, 150), "Header whey promotion"),
    "04_purple_shaker.webp": ("04_freeze_shaker_cutout.webp", (114, 132), "Freeze bottle and recovery creative"),
    "05_blinkit_grocery_bag.webp": ("05_partner_offer_cutout.webp", (132, 102), "Illustrative campaign art; Demo only"),
    "06_creatine_tub.webp": ("06_creatine_product_cutout.webp", (180, 162), "Workout KPI"),
    "23_freeze_snowflake_graphic.webp": ("23_freeze_snowflake_cutout.webp", (69, 81), "Freeze snowflake"),
    "28_protinex_tub.webp": ("28_protinex_product_cutout.webp", (180, 162), "Attendance KPI"),
    "29_sbi_payment_card_graphic.webp": ("29_sbi_payment_card_cutout.webp", (192, 144), "Payment KPI sample artwork"),
    "fat_loss_support_tub.png": ("fat_loss_support_tub_cutout.webp", (180, 162), "Body KPI; GrabCut background removal"),
}
PADDING = 0.067

def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()

def subject_rgba(path: Path) -> Image.Image:
    with Image.open(path) as original:
        rgba = original.convert("RGBA")
    # Fat Loss has an alpha channel but an almost fully opaque green scene.
    # Segment the product instead of pretending the scene is transparent.
    if path.suffix.lower() == ".png" and rgba.getchannel("A").getextrema() == (255, 255):
        rgb = np.asarray(rgba.convert("RGB"))
        height, width = rgb.shape[:2]
        scale = min(384 / width, 256 / height, 1.0)
        small_width = max(1, int(width * scale))
        small_height = max(1, int(height * scale))
        small = cv2.resize(rgb, (small_width, small_height), interpolation=cv2.INTER_AREA)
        mask = np.zeros((small_height, small_width), np.uint8)
        bgd = np.zeros((1, 65), np.float64)
        fgd = np.zeros((1, 65), np.float64)
        rect = (
            max(2, int(small_width * 0.01)),
            max(2, int(small_height * 0.015)),
            max(1, int(small_width * 0.98)),
            max(1, int(small_height * 0.97)),
        )
        cv2.grabCut(small, mask, rect, bgd, fgd, 7, cv2.GC_INIT_WITH_RECT)
        alpha_small = np.where(
            (mask == cv2.GC_FGD) | (mask == cv2.GC_PR_FGD), 255, 0
        ).astype(np.uint8)
        count, labels, stats, _ = cv2.connectedComponentsWithStats(alpha_small, 8)
        if count > 1:
            largest = 1 + int(np.argmax(stats[1:, cv2.CC_STAT_AREA]))
            alpha_small = np.where(labels == largest, 255, 0).astype(np.uint8)
        alpha = cv2.resize(alpha_small, (width, height), interpolation=cv2.INTER_CUBIC)
        rgba.putalpha(
            Image.fromarray(np.clip(alpha, 0, 255).astype(np.uint8), "L")
            .filter(ImageFilter.GaussianBlur(0.7))
        )
    bbox = rgba.getchannel("A").getbbox()
    if bbox is None:
        raise ValueError(f"{path.name}: no visible alpha subject")
    return rgba.crop(bbox)

def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--out", type=Path, required=True)
    args = parser.parse_args()
    if not args.root.is_dir():
        raise SystemExit(f"Missing PulseVault root: {args.root}")
    args.out.mkdir(parents=True, exist_ok=True)
    records = []
    for source_name, (output_name, (target_width, target_height), role) in MAPPING.items():
        source_path = args.root / source_name
        if not source_path.is_file():
            raise FileNotFoundError(source_path)
        with Image.open(source_path) as original:
            source_dimensions = list(original.size)
        subject = subject_rgba(source_path)
        inset_x, inset_y = target_width * PADDING, target_height * PADDING
        scale = min(
            (target_width - 2 * inset_x) / subject.width,
            (target_height - 2 * inset_y) / subject.height,
        )
        new_width = max(1, round(subject.width * scale))
        new_height = max(1, round(subject.height * scale))
        subject = subject.resize((new_width, new_height), Image.Resampling.LANCZOS)
        canvas = Image.new("RGBA", (target_width, target_height), (0, 0, 0, 0))
        canvas.alpha_composite(
            subject, ((target_width - new_width) // 2, (target_height - new_height) // 2)
        )
        output_path = args.out / output_name
        canvas.save(output_path, "WEBP", quality=95, alpha_quality=100, method=6, exact=True)
        with Image.open(output_path) as checked:
            checked = checked.convert("RGBA")
            alpha = checked.getchannel("A")
            bbox = alpha.getbbox()
            extrema = list(alpha.getextrema())
            if checked.size != (target_width, target_height) or extrema != [0, 255] or bbox is None:
                raise ValueError(f"{output_name}: output failed alpha/dimension verification")
        left, top, right, bottom = bbox
        margins = {
            "left_pct": round(left / target_width * 100, 2),
            "top_pct": round(top / target_height * 100, 2),
            "right_pct": round((target_width - right) / target_width * 100, 2),
            "bottom_pct": round((target_height - bottom) / target_height * 100, 2),
        }
        if min(margins.values()) < 5:
            raise ValueError(f"{output_name}: transparent margin below 5%: {margins}")
        records.append({
            "name": output_name,
            "source": source_name,
            "source_dimensions_px": source_dimensions,
            "dimensions_px": [target_width, target_height],
            "format": "WebP",
            "alpha_channel": True,
            "alpha_extrema": extrema,
            "alpha_bbox_xyxy": list(bbox),
            "transparent_margins_pct": margins,
            "size_bytes": output_path.stat().st_size,
            "sha256": sha256(output_path),
            "box_fit": "contain",
            "role": role,
        })
    manifest = {
        "name": "BAD GYM Emerald Pearl PulseVault optimized artwork",
        "version": "1.2",
        "source_assets_overwritten": False,
        "runtime_folder": "assets/material_pack/inbox/PulseVault/optimized/",
        "logical_scale": "3x target slots",
        "padding_target_pct": 6.7,
        "files": records,
    }
    (args.out / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    print(f"Created {len(records)} real-alpha derivatives ({sum(r['size_bytes'] for r in records):,} bytes).")
    for record in records:
        print(f"{record['name']}: {record['dimensions_px']} alpha={record['alpha_extrema']} margins={record['transparent_margins_pct']}")

if __name__ == "__main__":
    main()
