#!/usr/bin/env python3
"""Extract individual BAD GYM PNG assets from the two approved atlas images.

Pack 01 is RGBA and should be preferred for artwork with clean transparency.
Pack 02 has a baked checkerboard; its alpha reconstruction is conservative and
is intended for foreground cutouts only. Review generated previews before use.
"""
from __future__ import annotations
import argparse
from pathlib import Path
from PIL import Image
import numpy as np

PACK1 = {
    "brand_logo": (120, 330, 450, 415),
    "athlete_hero": (0, 0, 300, 330),
    "dumbbell": (595, 0, 835, 150),
    "kettlebell": (830, 0, 975, 150),
    "shaker": (970, 0, 1085, 150),
    "steel_bottle": (1080, 0, 1155, 150),
    "towel": (1140, 0, 1335, 150),
    "weight_plate": (1330, 0, 1536, 150),
    "gym_interior": (1130, 110, 1536, 315),
    "plant_a": (0, 875, 125, 1024),
    "plant_b": (125, 875, 255, 1024),
    "plant_c": (255, 875, 390, 1024),
    "plant_d": (390, 875, 520, 1024),
    "plant_e": (520, 875, 640, 1024),
    "gold_badge": (290, 410, 430, 485),
    "green_badge": (125, 410, 285, 485),
    "purple_badge": (635, 410, 740, 485),
}
PACK2 = {
    "athlete_primary": (0, 0, 170, 150),
    "athlete_secondary": (165, 0, 315, 150),
    "athlete_female": (315, 0, 465, 150),
    "athlete_hoodie": (610, 0, 770, 150),
    "dumbbell_purple": (145, 150, 310, 280),
    "kettlebell_purple": (400, 150, 500, 280),
    "shaker_purple": (0, 280, 55, 415),
    "bottle_steel": (55, 280, 110, 415),
    "towel_rolled": (205, 280, 285, 415),
    "gym_interior_alt": (1200, 415, 1536, 540),
    "plant_left": (0, 415, 95, 540),
    "plant_center": (280, 415, 385, 540),
    "plant_right": (600, 415, 710, 540),
    "gym_floor": (0, 900, 1536, 1024),
}
ICON_NAMES = ["home","calendar","calendar_check","workout","wallet","card","qr_badge",
              "profile","members","crown","trophy","flame","trend","analytics",
              "history_list","grid","menu","notification","freeze","settings",
              "filter","search","add"]
ICON_CENTERS = list(range(37, 1493, 66))

def checkerboard_alpha(image: Image.Image) -> Image.Image:
    rgb = np.asarray(image.convert("RGB"), dtype=np.int16)
    # The checkerboard colors are near-neutral. Restrict removal to low
    # saturation pixels close to the observed tile palette, preserving vivid art.
    mx, mn = rgb.max(2), rgb.min(2)
    saturation = mx - mn
    palette = np.array([[215,215,217],[225,224,229],[242,241,249],[235,235,239]])
    distance = np.sqrt(((rgb[...,None,:] - palette[None,None,:,:])**2).sum(3)).min(2)
    alpha = np.where((distance < 22) & (saturation < 35), 0, 255).astype(np.uint8)
    rgba = np.dstack([rgb.astype(np.uint8), alpha])
    return Image.fromarray(rgba, "RGBA")

def save_crops(image: Image.Image, manifest: dict, out: Path):
    for name, box in manifest.items():
        crop = image.crop(box)
        crop.save(out / f"{name}.png", optimize=True)
    return len(manifest)

def main():
    p = argparse.ArgumentParser()
    p.add_argument("--pack1", type=Path, required=True, help="RGBA asset atlas")
    p.add_argument("--pack2", type=Path, required=True, help="checkerboard RGB atlas")
    p.add_argument("--out", type=Path, default=Path("assets/images/extracted"))
    args = p.parse_args()
    args.out.mkdir(parents=True, exist_ok=True)
    p1 = Image.open(args.pack1).convert("RGBA")
    p2 = checkerboard_alpha(Image.open(args.pack2))
    count = save_crops(p1, PACK1, args.out)
    count += save_crops(p2, PACK2, args.out)
    for name, x in zip(ICON_NAMES, ICON_CENTERS):
        p2.crop((x-30, 812, x+30, 882)).save(args.out / f"icon_{name}.png", optimize=True)
        count += 1
    print(f"Extracted {count} transparent PNG assets into {args.out}")
    print("Review the crops, especially checkerboard-derived edges, before release.")

if __name__ == "__main__":
    main()
