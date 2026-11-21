# Individual BAD GYM assets

The reviewed asset source is `1000320938.png` (1536 × 1024 RGBA). Each individual image is a manually bounded object crop with source alpha retained. Existing approved PNG outputs were upscaled 2× using Lanczos and have semantic snake_case names.

## Current checked asset pack
- `badgym_verified_png_assets/` contains the reviewed 32 PNG assets and `ASSET_MANIFEST.json`.
- Every listed PNG is RGBA with a non-empty alpha channel.
- Source crop coordinates, output dimensions, and SHA-256 values are recorded in the manifest.
- Contact-sheet review confirms the portrait, logo, gym interior, dumbbell, kettlebell, shaker, steel bottle, towel, weight stack, plants, badges and icons are individually separated.

## Reproducible extraction
Run:
```bash
python tools/assets/extract_badgym_assets.py \
  --source 1000320938.png \
  --manifest ASSET_MANIFEST.json \
  --out assets/images/individual
```

The script validates source dimensions and crop bounds, preserves RGBA, applies only the manifest-specified Lanczos resize, and writes a fresh output manifest with byte sizes and SHA-256 checksums.

## Integration status
The individual PNG source pack is verified in the working environment, but it has not yet been committed as the app's runtime asset directory or wired to Flutter widgets. The current dashboard still uses the two sprite atlases. Do not report runtime PNG integration as complete until the files are in the repository, the widgets reference them, and CI/device visual QA pass.
