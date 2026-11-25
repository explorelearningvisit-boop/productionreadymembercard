# BAD GYM — Member Intelligence Card

A Flutter Android app reproducing the supplied Purple Neon Member Intelligence dashboard reference.

## What the app shows
- Member name, ID, age and membership plan/status
- Check-in action and current check-in state
- Membership days and progress
- Attendance, workout duration, body weight and payment due
- Attendance analytics, promotional panels and monthly attendance calendar
- Six-item vertical navigation rail (Attend, Insights, Cal, History, Trend, Goals)
- A clear demo-data notice until a real gym API is connected

All displayed member values remain sample data until a real gym API is connected.

## Build and QA
The GitHub Actions workflow runs:
`flutter pub get`, Dart formatting, `flutter analyze`, widget tests and an ARM64 release APK build.

The APK is signed with the Android development key for sideload QA. It is not a Play Store production-signed release. Configure a private upload keystore before store distribution.

## CI artifact
Open the latest successful run:
https://github.com/explorelearningvisit-boop/productionreadymembercard/actions
