# SpriteForge — Android Image Studio

A mobile-first image editing and batch-processing app, not limited to sprite sheets.

## Features
- Import multiple local images from Android gallery (PNG/JPG/WebP decoder support).
- On-device subject/background cutout using MIT-licensed `native_cutout` and Google ML Kit Subject Segmentation. No paid image API or API key. The ML Kit model downloads on first use through Google Play services; initial internet connection required.
- Manual erase and restore brushes with undo.
- Magic-wand connected-color erase with adjustable tolerance.
- Free rectangular crop and transparent-edge trim.
- Real-ESRGAN x4 TFLite AI upscaling, with 2x output mode by half-resolution input and x4 mode; tiled inference and alpha-channel preservation.
- Batch background removal and ZIP export.
- Uniform-grid sprite-sheet splitting plus connected-component detection for already-transparent sprite sheets.

## Open-source components and credits
See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md). Main integrations include `native_cutout` for on-device cutout and adapted `GhostScale` TFLite Real-ESRGAN inference for AI upscaling. The editor also uses `image`, `archive`, `tflite_core`, `image_picker`, `share_plus`, and `path_provider`.

## Known limitations
- Automatic segmentation is subject/foreground segmentation; results depend on image content and Android Google Play services. It is not universal semantic object removal.
- Manual erase clears alpha; restore paints pixels back from the current edit baseline.
- Magic wand removes a connected region matching the tapped color within tolerance.
- Transparent sprite auto-detection works on images whose sprites are already separated by transparent gaps. Grid splitting remains available for regular sheets.
- AI upscale performance depends on phone RAM, GPU driver and TFLite compatibility; CPU fallback is attempted if GPU delegate initialization fails.
- AI upscaler model is included in the APK by the GitHub Actions download step. Initial model download happens during CI, not from the phone.

## Build
GitHub Actions generates Android platform files, downloads the open model, resolves Flutter dependencies, formats/analyzes/tests the project, builds a release APK and uploads it as a workflow artifact.
