# SpriteForge

Android-first, on-device sprite-sheet batch processor.

## Current MVP
- Import PNG/JPG/WebP from Android gallery.
- Split a sprite sheet using configurable uniform rows and columns.
- Remove a flat background sampled from each cell's top-left pixel, with adjustable color tolerance.
- Trim transparent margins.
- Scale sprites 1x/2x/4x using nearest-neighbor interpolation (useful for pixel art).
- Preview output and share a ZIP containing individual transparent PNGs.

## Important limitations
This MVP does **not** include AI subject segmentation, irregular object detection, or AI super-resolution. Flat-color removal can erase subject pixels that match the sampled background. Use the tolerance control carefully. Future versions can add a bundled on-device segmentation/upscaling model without paid API calls, subject to model size and phone performance.

## Build
The repository GitHub Actions workflow generates the Android project scaffold, resolves Flutter dependencies, runs formatting/analyzer/tests, builds a release APK, and uploads it as an artifact.
