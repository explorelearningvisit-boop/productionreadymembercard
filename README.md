# BAD GYM — Member Intelligence

Cross-platform Flutter application for the **BAD GYM Member Intelligence** check-in card experience. Android and iOS share one production-ready Flutter UI codebase.

## Current Scope & Visual Implementation
This repository is dedicated to the production-quality, pixel-perfect **BAD GYM Member Intelligence** card:
- **Top Header Bar**: Rounded dark menu button, 3D orange dumbbell logo, BAD GYM typography, notification bell with unread badge, and live date pill (`Thu, 16 Oct 2026`).
- **Member Profile Card**: Warm chocolate/charcoal gradient card with real portrait avatar, gold halo ring, `BG215` identity, `Active` + `Gold Plan` badges, `8 Days Left` coral action, and `22 / 30 Days (73.3% Used)` lime-to-emerald progress bar.
- **Left Vertical Navigation Rail**: Rounded dark rail with 8 navigation items (`Overview`, active coral `Attendance`, `Workout`, `Body`, `Payment`, divider, `Goals`, `Reports`, and `Offers` with notification dot).
- **Quick Stats Row**: 4 interactive stat cards (`Attendance 81%`, `Workout 58 min`, `Payment Paid`, `Body 69.5 kg`).
- **Attendance Intelligence Card**:
  - Donut chart with 81% progress arc and centered breakdown.
  - Color-coded legend (Present 23, Late 2, Absent 2, Holiday 4).
  - Streak badges (6 Days Current Streak flame, 14 Days Best Streak trophy).
  - Monthly calendar with day status indicators and glowing green double ring for Today (16th).
  - Attendance Trend spline curve with 0–100% Y-axis, 1–31 X-axis, peak/trough callout pills, and Max/Avg/Min stats.
- **Promotional Banner**: Muscle Building Program banner with gold member exclusive badge and CTA.

## Verified Live Device Screenshots
- **Primary Board View**: [`docs/screenshots/verified_pixel_perfect_attendance.png`](docs/screenshots/verified_pixel_perfect_attendance.png)
- **Scrolled Banner View**: [`docs/screenshots/verified_pixel_perfect_scroll.png`](docs/screenshots/verified_pixel_perfect_scroll.png)

## Requirements
- Flutter stable (>= 3.5.0) / Dart compatible with `pubspec.yaml`
- Android Studio + Android SDK (API 33+) or connected physical Android device
- macOS + Xcode for iOS builds

## Run on Windows / Android
Clone this repository, then:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run
```

While iterating, press `r` in the Flutter terminal for hot reload.

## Build Artifacts
```powershell
flutter build apk --debug
flutter build appbundle --release
```

## Project Layout
- `lib/core/models`: Data models for member profile, calendar days, and trend points.
- `lib/core/theme`: Theme tokens, colors, and typography (Poppins & Inter).
- `lib/presentation/widgets`: Modular, pixel-perfect UI widgets.
- `lib/presentation/member_checkin_screen.dart`: Main screen assembling the complete board.
- `assets/images`: High-resolution graphics and 3D icons.
- `assets/fonts`: Poppins (Regular, Medium, SemiBold, Bold, ExtraBold) and Inter fonts.
- `test`: Widget and policy test suites (all passing).
