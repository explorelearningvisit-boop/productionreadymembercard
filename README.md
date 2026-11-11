# BAD GYM — Member Intelligence

Cross-platform Flutter application for the BAD GYM Member Intelligence experience. Android and iOS share one Flutter UI codebase.

## Current scope
This repository is dedicated to the first production-quality Member Intelligence card and its four domains: Attendance, Workout, Payment and Body. The UI is built around the supplied purple/neon-lime 3D visual references. Backend and API work are intentionally deferred until visual approval.

## Requirements
- Flutter stable / Dart compatible with `flutter_app/pubspec.yaml`
- Android Studio + Android SDK + Android emulator or physical Android phone
- macOS + Xcode for iOS builds and signed iOS releases

## Run on Windows / Android
Clone this repository, then:

```powershell
cd flutter_app
flutter doctor -v
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter run
```

Start an Android emulator in Android Studio Device Manager or connect a phone with USB debugging enabled. Run `flutter devices` to select the correct device. While the app is running, press `r` in the Flutter terminal for hot reload; this avoids a new APK build for most Dart UI changes.

## Build artifacts
```powershell
cd flutter_app
flutter build apk --debug
flutter build appbundle --release
```

iOS simulator/release builds require macOS and Xcode:

```bash
cd flutter_app
flutter build ios --simulator --no-codesign
```

Never commit signing credentials, production secrets or real member data.

## Project layout
- `flutter_app/lib/core`: shared domain and authorization presentation policy.
- `flutter_app/lib/features`: Attendance, Workout, Payment and Body feature-first layers.
- `flutter_app/test`: widget and domain policy tests.
- `docs`: visual reference, migration notes and implementation status.
- `.github/workflows`: Flutter CI and Android/iOS build checks.

## Data and safety
All current visible member information is demo data. No real authentication, payment collection or production backend is connected. Owner/member UI permission rules are not a substitute for backend authorization. No body-fat or skeletal-muscle values are inferred from weight/height.
