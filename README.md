# BAD GYM — Member Intelligence Card

A lightweight Flutter Android app for one gym member's check-in and essential membership information.

## What the app shows
- Member name, ID, age and membership plan/status
- Check-in action and current check-in state
- Membership days and progress
- Attendance, workout duration, body weight and payment due
- A clear demo-data notice until a real gym API is connected

No advertisements, shopping offers, QR scanner, calendar, analytics rail, charts, custom artwork, custom fonts or animation system are included.

## Build and QA
The GitHub Actions workflow runs:
`flutter pub get`, Dart formatting, `flutter analyze`, widget tests and an ARM64 release APK build.

The APK is signed with the Android development key for sideload QA. It is not a Play Store production-signed release. Configure a private upload keystore before store distribution.

## CI artifact
Open the latest successful run:
https://github.com/explorelearningvisit-boop/productionreadymembercard/actions
