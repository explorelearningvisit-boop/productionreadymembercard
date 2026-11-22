# BAD GYM — Member Intelligence

Independent branch: `grok/purple-neon-member-dashboard`

Base: `feature/grok-member-intelligence-flutter` (`890df8e`). This branch does not modify `main`, the shared base, or `rebuild/purple-neon-member-dashboard`.

## What this is
Android-ready Flutter dashboard for the approved purple neon member card.

Visual authority is the supplied dashboard screenshot, asset sheet, and theme sheet:

- Lavender gym shell, BAD GYM wordmark, check-in / freeze / alerts strip
- Ashwani Kumar Singh hero, Gold plan, active status, payment QR, 22/30 day bar
- Big Billion Sale banner
- Left rail (Home, Attend, Workout, Pay, Offers, History) with metric tiles
- Attendance Intelligence: 81% ring, present / absent / holiday / payment, streak footer
- Attend calendar, workout split, payment, offers, and check-in history

Portrait: `assets/images/member_portrait.png`, cropped from the approved dashboard reference. Text, charts, calendar, progress, and QR are native Flutter widgets. Profile numbers are sample UI data. No billing or attendance API is connected.

## Verify
```sh
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build apk --release
```

Release APK (debug-signed until a release keystore is supplied): `build/app/outputs/flutter-apk/app-release.apk`.

CI: `.github/workflows/android-build.yml` on this branch.
