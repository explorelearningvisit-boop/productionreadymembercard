# SpriteForge — Android Image Studio

A mobile-first image editing and batch-processing app, not limited to sprite sheets.

## Features
- Import multiple local images from Android gallery (PNG/JPG/WebP decoder support).
- On-device subject/background cutout using MIT-licensed `native_cutout` and Google ML Kit Subject Segmentation. No paid image API or API key. The ML Kit model is downloaded on first use through Google Play services; initial internet connection required.
- Manual erase and restore brushes with undo.
- Magic-wand connected-color erase with adjustable tolerance.
- Free rectangular crop and transparent-edge trim.
- Real-ESRGAN x4 TFLite AI upscaling, with 2x output mode by half-res input and x4 mode; tiled inference and alpha-channel preservation. Model is downloaded by the GitHub Actions build from the upstream GhostScale repository and included in the APK.
- Batch background removal and ZIP export.
- Uniform-grid sprite-sheet splitting as an optional tool.

## Open-source components and credits
- `native_cutout` (MIT): on-device subject segmentation.
- `GhostScale` (MIT): Real-ESRGAN TFLite upscaler implementation and model packaging reference; service adapted for PNG alpha preservation.
- `image` (BSD-3-Clause): pixel operations, alpha editing, crop and resize.
- `archive` (MIT): ZIP export.
- `tflite_flutter`: TensorFlow Lite inference runtime.
- `image_picker`, `share_plus`, `path_provider`: Android import/export/share.
- `dgocker/asset-slicer` (MIT): object-selection and asset-editor workflow reference.
- `hm21/pro_image_editor` (BSD-3-Clause): crop/paint editor reference.
- `Laurtiv27/ondevice-inpaint-app-flutter` (MIT): inpainting workflow reference.
The listed editor projects are feature references; their code is not bundled wholesale. Individual licenses and model terms are recorded before integration.

## Known limitations
- Automatic segmentation is subject/foreground segmentation; results depend on image content and Android Google Play services. It is not universal semantic object removal.
- Manual erase clears alpha; restore paints pixels back from the current edit baseline.
- Magic wand removes a connected region matching the tapped color within tolerance.
- Sprite-sheet splitting currently uses a uniform grid; irregular object detection and AI inpainting are not yet integrated.
- AI upscale performance depends on phone RAM, GPU driver and TFLite compatibility; CPU fallback is attempted if GPU delegate initialization fails.

## Build
GitHub Actions generates Android platform files, downloads the open model, resolves Flutter dependencies, formats/analyzes/tests the project, builds a release APK and uploads it as a workflow artifact.
