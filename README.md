# BAD GYM — Member Intelligence

## Current implementation
This Flutter screen is rebuilt from the user's uploaded 19 November 2026 reference image. The reference is the visual authority for this implementation.

- Mobile-first layout with a ice-cyan / aqua translucent glass shell with vivid emerald and neon-green accents.
- Check-in and Freeze Member header.
- Member hero, plan and active status.
- Payment and expiry strip, membership progress.
- Promotional banner and four quick metric tiles.
- Attendance Intelligence with vertical rail, horizontal section menu, attendance summary, month selector, calendar and insight tiles.
- Portrait extracted from the uploaded reference and stored as a transparent PNG at `assets/images/member_portrait.png`.

The displayed Ashwani profile and metrics are reference/sample presentation data only. No backend connection is implied.

## Build and verify
```sh
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter build apk --release
```

CI: `.github/workflows/android-build.yml`.
