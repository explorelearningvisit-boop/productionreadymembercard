# Resource manifest

This file is the stack-aware reusable dependency and asset index. Keep package versions in each consuming app's lockfile.

## Flutter starter dependencies
```yaml
dependencies:
  flutter_animate: ^4.5.2
  lottie: ^3.3.1
  flutter_svg: ^2.2.1
  phosphor_flutter: ^2.1.0
  rive: ^0.14.4
```
Before adding: verify latest compatible versions on pub.dev and run `flutter pub get`, analysis and tests. Do not add all dependencies automatically.

## Web starter dependencies
```bash
npm install lucide-react motion
```
Install GSAP only when timeline/scroll choreography is required. Follow the current GSAP licensing terms for plugins.

## Icon source selection
- UI outline icons: Lucide.
- Multi-weight editorial/product icons: Phosphor.
- Android/Material convention: Material Symbols.
- Brand logos: Simple Icons (check each brand trademark/use guidance).
- Never use emoji as a substitute for a required production icon.
- Keep vector originals (SVG) in master source; export raster PNG only when target renderer requires it.

## Animation selection
- Small UI transitions: flutter_animate / Motion.
- Stateful interactive illustration: Rive.
- Designer-authored motion asset: Lottie / dotLottie.
- Complex web timeline/scroll choreography: GSAP.
- Respect reduced-motion and low-end device performance.

## Vendoring policy
The toolkit branch stores skills, references, source URLs and integration recipes. Large package ecosystems are not copied wholesale into every app: use package managers and lockfiles. For reusable binary assets, vendor only a curated, license-checked subset under `assets/shared/` with source URL, license, source SHA/version, dimensions and modification notes.
