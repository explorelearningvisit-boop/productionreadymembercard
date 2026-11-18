# BAD GYM — Member Intelligence

## Clean-slate rebuild

The previous crimson/metallic-gold dashboard implementation and its derived portrait asset have been removed from the active source tree. The Flutter app is intentionally reduced to a neutral shell while the new UI is rebuilt from the user's latest approved reference.

## Design authority

- Master: the user's final approved **first/red** dashboard image from 17 November 2026.
- The second and third concepts were also liked; the fourth pale concept was explicitly rejected.
- Target: mobile-first Android layout at 360dp width.
- Member card, vertical rail, and horizontal menu must use one consistent visual identity.
- Information workspaces may use the approved light white/lavender/yellow/green surfaces from the latest reference.
- Use only the matching recent approved asset/theme pack. Static transparent PNGs are for decorative/illustrative artwork; dynamic text, charts, calendar states, controls, progress and QR elements must remain native Flutter widgets.
- Do not restore the retired `1000320298.png` crimson/metallic-gold reference, its derived portrait, or any retired screenshot/material pack.
- Do not substitute older purple/glass/neumorphic concepts for the approved first/red master.

## Build

```sh
flutter pub get
flutter analyze
flutter test
flutter build apk --release
```

## CI

GitHub Actions workflow: `.github/workflows/android-build.yml`.

A successful CI build is not the same as physical-device installation, launch, or visual acceptance.
