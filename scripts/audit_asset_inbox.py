#!/usr/bin/env python3
"""Create a visual and technical audit of every image in the BAD GYM inbox."""
from __future__ import annotations
import hashlib, json, math
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

ROOT = Path("assets/material_pack/inbox")
OUT = Path("build/asset-audit")
OUT.mkdir(parents=True, exist_ok=True)
EXTS = {".png", ".webp", ".jpg", ".jpeg"}
items = []
for path in sorted(ROOT.rglob("*")):
    if not path.is_file() or path.suffix.lower() not in EXTS:
        continue
    try:
        raw = path.read_bytes()
        with Image.open(path) as im:
            im.load()
            rgba = im.convert("RGBA")
            alpha = rgba.getchannel("A")
            hist = alpha.histogram()
            total = im.width * im.height
            bbox = alpha.getbbox()
            items.append({
                "path": path.as_posix(), "filename": path.name,
                "format": im.format, "mode": im.mode,
                "width": im.width, "height": im.height,
                "aspect_ratio": round(im.width / im.height, 5),
                "bytes": len(raw),
                "sha256": hashlib.sha256(raw).hexdigest(),
                "alpha_min": min(i for i, n in enumerate(hist) if n),
                "alpha_max": max(i for i, n in enumerate(hist) if n),
                "transparent_percent": round(hist[0] * 100 / total, 3),
                "partial_alpha_percent": round(sum(hist[1:255]) * 100 / total, 3),
                "opaque_percent": round(hist[255] * 100 / total, 3),
                "nontransparent_bbox": list(bbox) if bbox else None,
            })
    except Exception as exc:
        items.append({"path": path.as_posix(), "error": str(exc)})

# Checkerboard contact sheet. Every thumbnail preserves the original aspect ratio.
font = ImageFont.load_default()
thumb_w, thumb_h, label_h = 210, 190, 42
cols = 5
rows = max(1, math.ceil(len(items) / cols))
sheet = Image.new("RGB", (cols * (thumb_w + 18) + 18, rows * (thumb_h + label_h + 18) + 18), "#eeeaf4")
draw = ImageDraw.Draw(sheet)
for i, item in enumerate(items):
    x = 18 + (i % cols) * (thumb_w + 18)
    y = 18 + (i // cols) * (thumb_h + label_h + 18)
    draw.rounded_rectangle((x, y, x + thumb_w, y + thumb_h + label_h), radius=10, fill="white", outline="#c9b7df", width=2)
    if "error" not in item:
        p = Path(item["path"])
        with Image.open(p) as im:
            rgba = im.convert("RGBA")
            rgba.thumbnail((thumb_w - 12, thumb_h - 12), Image.Resampling.LANCZOS)
            # Checkerboard background for transparent edges.
            bg = Image.new("RGBA", (thumb_w, thumb_h), "#ffffff")
            tile = 12
            pattern = Image.new("RGBA", (thumb_w, thumb_h), (0,0,0,0))
            pd = ImageDraw.Draw(pattern)
            for yy in range(0, thumb_h, tile):
                for xx in range(0, thumb_w, tile):
                    if (xx // tile + yy // tile) % 2:
                        pd.rectangle((xx, yy, xx+tile-1, yy+tile-1), fill="#dedbe3")
            bg = Image.alpha_composite(bg, pattern)
            bg.alpha_composite(rgba, ((thumb_w-rgba.width)//2, (thumb_h-rgba.height)//2))
            sheet.paste(bg.convert("RGB"), (x, y))
        name = item["filename"]
        dim = f'{item["width"]}x{item["height"]} | {item["format"]} | alpha {item["transparent_percent"]}%'
        draw.text((x + 7, y + thumb_h + 5), name[:31], fill="#21152e", font=font)
        draw.text((x + 7, y + thumb_h + 20), dim[:37], fill="#665776", font=font)
    else:
        draw.text((x + 7, y + 10), item["path"][:30], fill="#a00", font=font)
        draw.text((x + 7, y + 28), item["error"][:45], fill="#a00", font=font)

sheet.save(OUT / "inbox-contact-sheet.jpg", quality=90, optimize=True)
report = {
    "repository_path": ROOT.as_posix(),
    "image_count": len(items),
    "successful": sum("error" not in x for x in items),
    "errors": [x for x in items if "error" in x],
    "items": items,
}
(OUT / "asset-audit.json").write_text(json.dumps(report, indent=2), encoding="utf-8")
print(f"Audited {report['successful']}/{len(items)} images")
print(f"Contact sheet: {OUT / 'inbox-contact-sheet.jpg'}")
print(f"Metadata: {OUT / 'asset-audit.json'}")
