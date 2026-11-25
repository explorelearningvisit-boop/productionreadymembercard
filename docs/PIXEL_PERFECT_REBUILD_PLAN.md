# BAD GYM — Minimal card delivery plan

## Product boundary
One Android screen. One member record. One check-in action. The current scope is defined in `BADGYM_FINAL_APPROVED_DASHBOARD_MASTER_PROMPT.md`.

## Essential UI
- Member identity and plan/status
- Check-in state/action
- Membership progress
- Attendance, workout, body weight and amount due
- Demo-data notice

## Explicit removals
No offers, ads, product artwork, QR, charts, calendar, secondary analytics panels, navigation rail, custom fonts, animation framework or extra runtime packages.

## Verification gates
1. `flutter pub get`
2. `dart format --output=none --set-exit-if-changed lib test`
3. `flutter analyze`
4. Widget tests for card data, check-in state, repeat mount/dispose and 320/360/390 dp.
5. ARM64 release QA APK build and APK signature verification.
6. Real-device installation and launch must be reported separately; do not claim it without evidence.

## Optimization
Ship only the ARM64 release APK for the owner's Android phone. Do not upload universal debug APKs as the normal deliverable. Keep only Android boilerplate and the source needed for this single screen.
