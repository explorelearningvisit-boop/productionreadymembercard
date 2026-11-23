#!/usr/bin/env python3
"""Audit only the 14 authoritative dashboard cutouts in PulseVault."""
from __future__ import annotations
import hashlib, json, math
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

ROOT = Path("assets/material_pack/inbox/PulseVault")
OUT = Path("build/asset-audit/pulsevault")
OUT.mkdir(parents=True, exist_ok=True)
files = sorted(p for p in ROOT.iterdir() if p.is_file() and p.suffix.lower() == ".png")
items = []
for path in files:
    raw = path.read_bytes()
    with Image.open(path) as im:
        im.load()
        rgba = im.convert("RGBA")
        alpha = rgba.getchannel("A")
        hist = alpha.histogram()
        total = im.width * im.height
        bbox = alpha.getbbox()
        items.append({
            "source": path.as_posix(),
            "suggested_role": None,
            "suggested_filename": None,
            "width": im.width, "height": im.height,
            "aspect_ratio": round(im.width / im.height, 5),
            "format": im.format, "mode": im.mode,
            "bytes": len(raw),
            "sha256": hashlib.sha256(raw).hexdigest(),
            "transparent_percent": round(hist[0] * 100 / total, 3),
            "partial_alpha_percent": round(sum(hist[1:255]) * 100 / total, 3),
            "opaque_percent": round(hist[255] * 100 / total, 3),
            "nontransparent_bbox": list(bbox) if bbox else None,
        })

font = ImageFont.load_default()
thumb_w, thumb_h, label_h, cols = 250, 250, 54, 4
rows = max(1, math.ceil(len(items) / cols))
sheet = Image.new("RGB", (cols * (thumb_w + 18) + 18, rows * (thumb_h + label_h + 18) + 18), "#eeeaf4")
draw = ImageDraw.Draw(sheet)
for i, item in enumerate(items):
    x = 18 + (i % cols) * (thumb_w + 18)
    y = 18 + (i // cols) * (thumb_h + label_h + 18)
    draw.rounded_rectangle((x, y, x+thumb_w, y+thumb_h+label_h), radius=10, fill="white", outline="#b99bd8", width=2)
    with Image.open(item["source"]) as im:
        rgba = im.convert("RGBA")
        rgba.thumbnail((thumb_w-16, thumb_h-16), Image.Resampling.LANCZOS)
        bg = Image.new("RGBA", (thumb_w, thumb_h), "#ffffff")
        pattern = Image.new("RGBA", (thumb_w, thumb_h), (0,0,0,0))
        pd = ImageDraw.Draw(pattern)
        tile = 12
        for yy in range(0, thumb_h, tile):
            for xx in range(0, thumb_w, tile):
                if (xx//tile + yy//tile) % 2:
                    pd.rectangle((xx, yy, xx+tile-1, yy+tile-1), fill="#dedbe3")
        bg = Image.alpha_composite(bg, pattern)
        bg.alpha_composite(rgba, ((thumb_w-rgba.width)//2, (thumb_h-rgba.height)//2))
        sheet.paste(bg.convert("RGB"), (x, y))
    draw.text((x+7, y+thumb_h+5), item["source"].split("/")[-1][:34], fill="#21152e", font=font)
    draw.text((x+7, y+thumb_h+22), f'{item["width"]}x{item["height"]} | alpha {item["transparent_percent"]}%', fill="#665776", font=font)
sheet.save(OUT / "pulsevault-14-contact-sheet.jpg", quality=92, optimize=True)
report = {"scope": ROOT.as_posix(), "expected_images": 14, "image_count": len(items), "items": items}
(OUT / "pulsevault-14-audit.json").write_text(json.dumps(report, indent=2), encoding="utf-8")
if len(items) != 14:
    raise SystemExit(f"Expected exactly 14 PulseVault PNGs, found {len(items)}")
print(f"Audited exactly {len(items)} authoritative PulseVault PNGs")
print(OUT / "pulsevault-14-contact-sheet.jpg")
