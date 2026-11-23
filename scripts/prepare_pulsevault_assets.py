#!/usr/bin/env python3
"""Convert the only opaque PulseVault product image into a real alpha cutout."""
from collections import deque
from pathlib import Path
from PIL import Image, ImageFilter
import hashlib, json

ROOT = Path("assets/material_pack/pulsevault")
SOURCE = ROOT / "08_purple_shaker_bottle_full_canvas.png"
TARGET = ROOT / "08_purple_shaker_bottle_cutout.png"
README = ROOT / "README.md"

if TARGET.exists() and not SOURCE.exists():
    with Image.open(TARGET) as im:
        alpha = im.getchannel("A")
        if alpha.getextrema()[0] == 0:
            print("Transparent shaker cutout already prepared; no changes.")
            raise SystemExit(0)
    raise SystemExit("Target exists but has no transparent pixels; refusing overwrite.")
if not SOURCE.exists():
    raise SystemExit(f"Expected source image missing: {SOURCE}")

image = Image.open(SOURCE).convert("RGB")
width, height = image.size
pixels = image.tobytes()
total = width * height
background = bytearray(total)
visited = bytearray(total)
queue = deque()

def is_background(i):
    r, g, b = pixels[i*3:i*3+3]
    return min(r, g, b) > 185 and (max(r, g, b) - min(r, g, b)) < 42

def seed(i):
    if not visited[i] and is_background(i):
        visited[i] = 1
        queue.append(i)

for x in range(width):
    seed(x)
    seed((height-1)*width+x)
for y in range(height):
    seed(y*width)
    seed(y*width+width-1)

while queue:
    i = queue.popleft()
    background[i] = 255
    x, y = i % width, i // width
    for dy in (-1, 0, 1):
        ny = y + dy
        if ny < 0 or ny >= height:
            continue
        row = ny * width
        for dx in (-1, 0, 1):
            if dx == 0 and dy == 0:
                continue
            nx = x + dx
            if 0 <= nx < width:
                seed(row + nx)

bg = Image.frombytes("L", (width, height), bytes(background)).filter(ImageFilter.MaxFilter(3))
alpha = Image.eval(bg, lambda value: 255 - value).filter(ImageFilter.GaussianBlur(0.65))
bbox = alpha.getbbox()
if not bbox:
    raise SystemExit("Background removal produced an empty subject mask.")
rgba = image.convert("RGBA")
rgba.putalpha(alpha)
rgba = rgba.crop(bbox)
rgba.save(TARGET, format="PNG", optimize=True)

with Image.open(TARGET) as check:
    check_alpha = check.getchannel("A")
    if check_alpha.getextrema()[0] != 0:
        raise SystemExit("Transparency validation failed: no fully transparent pixels.")
    if check_alpha.getextrema()[1] != 255:
        raise SystemExit("Transparency validation failed: opaque subject missing.")
    metadata = {
        "source": SOURCE.as_posix(),
        "output": TARGET.as_posix(),
        "original_size": [width, height],
        "cropped_size": list(check.size),
        "transparent_percent": round(sum(1 for v in check_alpha.getdata() if v == 0) * 100 / (check.width*check.height), 2),
        "sha256": hashlib.sha256(TARGET.read_bytes()).hexdigest(),
    }

SOURCE.unlink()
if README.exists():
    content = README.read_text(encoding="utf-8")
    content = content.replace(
        "`08_purple_shaker_bottle_full_canvas.png` is a full-canvas opaque image (not an isolated transparent cutout); keep it as reference-only.",
        "`08_purple_shaker_bottle_cutout.png` is the checkerboard-background-removed transparent shaker cutout, cropped to its subject bounds."
    )
    README.write_text(content, encoding="utf-8")
print(json.dumps(metadata, indent=2))
