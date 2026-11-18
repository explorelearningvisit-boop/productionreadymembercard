# BAD GYM — Member Intelligence

Fresh Flutter implementation rebuilt from the user-approved glossy crimson / metallic gold / pearl-white reference.

## Design authority
- Approved reference: 691 × 1536 px screenshot uploaded by the user.
- Target layout: mobile-first, 360dp logical width.
- Visual language: ruby/crimson background, illuminated metallic-gold edges, pearl-white panels, bold high-contrast typography.
- Semantic colors: green = present, amber = late, red = absent, purple = holiday.
- Reference banners remain present: Amazon Great Indian Festival and Protein Burger.
- Calendar, QR, charts, typography and controls are native Flutter widgets; do not rasterize text or controls.

## Run
```sh
flutter create --platforms=android --org com.badgym .
flutter pub get
flutter analyze
flutter test
flutter build apk --release
```

## CI
GitHub Actions workflow: `.github/workflows/android-build.yml`.

## Important
This is the first clean implementation baseline. A successful CI build is not the same as device installation or pixel-perfect acceptance. Device screenshot comparison on the target Xiaomi handset remains a separate QA gate.
