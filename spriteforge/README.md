# SpriteForge — Android Image Studio

A mobile-first image editing and batch-processing app, not limited to sprite sheets.

## Features in this branch
- Import multiple local images (PNG/JPG/WebP supported by the Android picker and decoder).
- On-device automatic subject/background removal through MIT-licensed `native_cutout` and Google ML Kit Subject Segmentation. No image API key or paid API. The ML Kit model downloads on first use through Google Play services; internet is needed for the initial download.
- Manual erase and restore brushes with undo.
- Free rectangular crop and transparent-edge trim.
- High-quality cubic resize at 1x/2x/4x (interpolation resize, not neural AI super-resolution).
- Batch background removal and ZIP export.
- Uniform-grid sprite-sheet splitting as an optional tool.

## Open-source components and feature references
- `native_cutout` (MIT): on-device subject segmentation.
- `image` (BSD-3-Clause): pixel operations, alpha editing, crop and resize.
- `archive` (MIT): ZIP export.
- `image_picker`, `share_plus`, `path_provider`: Android import/export/share.
- `dgocker/asset-slicer` (MIT): object-selection and asset-editor workflow reference.
- `hm21/pro_image_editor` (BSD-3-Clause): crop/paint editor reference.
- `Laurtiv27/ondevice-inpaint-app-flutter` (MIT): inpainting workflow reference.
- `GhostScale` (MIT): offline Real-ESRGAN upscaler reference.
These projects are not blindly copied or bundled; their licenses and platform constraints are respected.

## Known limitations
- Automatic segmentation is subject/foreground segmentation; results depend on image content and Android Google Play services. It is not universal semantic object removal.
- Manual erase clears alpha; restore paints pixels back from the current edit baseline.
- Current resize uses cubic interpolation. True Real-ESRGAN neural super-resolution is not yet integrated.
- Sprite-sheet splitting currently uses a uniform grid; irregular object detection is not yet integrated.

## Build
GitHub Actions generates Android platform files, resolves Flutter dependencies, formats/analyzes/tests the project, builds a release APK and uploads it as a workflow artifact.
