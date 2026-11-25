# BAD GYM — Member Intelligence

Independent branch: `grok/purple-neon-member-dashboard`

Base: `feature/grok-member-intelligence-flutter` (`890df8e`). This branch does not modify `main`, the shared base, or `rebuild/purple-neon-member-dashboard`.

## Current release status

This repository currently contains a **dashboard prototype**, not a production-connected gym management service.

- Member profile, plan, attendance, payment, and dashboard figures are sample UI data.
- Billing and attendance APIs are not connected.
- The CI APK is a QA artifact. It is not a Google Play upload artifact.
- Release builds no longer fall back to Android's debug signing key. Without a private upload keystore, Gradle produces an unsigned release build which must not be uploaded to Google Play.

## Dashboard scope

Visual direction is the supplied dashboard screenshot, asset sheet, and theme sheet:

- Lavender gym shell, BAD GYM wordmark, check-in / freeze / alerts strip
- Member hero, Gold plan, active status, payment QR, membership progress
- Big Billion Sale banner
- Navigation rail and metric tiles
- Attendance Intelligence, calendar, workout, payment, offers, and check-in history

## Local verification

```sh
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build apk --release
```

## Configure a real Android upload keystore

Create a private `android/key.properties` file (already excluded by `.gitignore`) with these entries:

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=YOUR_KEY_ALIAS
storeFile=/absolute/path/to/your-upload-keystore.jks
```

Keep the keystore and this properties file out of Git. Back up the keystore securely. Do not send private signing credentials in chat or commit them. A signed Play release additionally requires a versioned Android App Bundle (`flutter build appbundle --release`) and verification of the signing certificate.

## CI

Workflow: `.github/workflows/android-build.yml`. Its APK artifact is for QA only; it does not prove Play signing, backend integration, security, or device compatibility.
