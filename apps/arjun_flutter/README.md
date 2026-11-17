# ARJUN Flutter App

ARJUN is a Hindi-first workforce, services and building-material marketplace.

## Run locally
```sh
flutter pub get
flutter run
```

## Demo authentication
Debug builds show a one-tap synthetic tester identity:
- `tester@arjun.demo`
- `+91 90000 00000`

This identity is not verified and must never be used for customer data or real transactions. The gate checks `kDebugMode`; release builds cannot activate this demo login using a Dart define. Release login intentionally remains blocked until real authentication is configured.

## Implemented in this branch
- Flutter Material 3 mobile app with Hindi-first base theme.
- Role modes: customer, worker, field manager, supplier and admin/operations.
- Dedicated manager, supplier and admin dashboard layouts.
- Customer job composer with camera/gallery image selection and upload attempt to Firebase Storage.
- Local job cache using SharedPreferences, to retain locally created job listings between app sessions on the same device.
- Clearly labelled sponsored supplier/service UI placements.
- Operations preview modules: job lifecycle, attendance, inspection, supplier inventory, payments, notifications and support/disputes.
- GitHub Actions checks for formatting, static analysis, widget tests, Android QA APK and iOS simulator build.
- Separate debug APK artifact for one-tap demo walkthrough; release-mode QA APK remains unsigned.

## Not yet production-connected
This is not yet a production marketplace. Current UI/sample workflows do not create shared server records. The local cache is device-only. Firebase app configuration, Firebase Auth, Firestore job repository, deployed security rules, verified storage upload, server-side role claims, KYC vendor, live location/maps, real QR/OTP attendance, messaging/calling, push notifications, payment gateway and settlement reconciliation, supplier live stock/order fulfillment, ad campaign billing/reporting, staffed dispute operations, privacy/legal pages and production monitoring still require integration and validation.

The image upload code calls Firebase Storage, but this branch does not include a Firebase project configuration. A selected image therefore cannot be treated as successfully uploaded until Firebase is initialized and the deployed Storage rules permit the authenticated request.

## Release gate
Do not distribute a public production APK until all of the following are true:
1. Firebase project/app IDs and platform configuration are supplied securely and initialized.
2. Production phone authentication and server-issued sessions are tested; demo login is absent from release.
3. Backend schema, role authorization and least-privilege database/storage rules are deployed and tested.
4. Job posting, matching, acceptance, attendance, progress, cancellation and disputes persist on the server.
5. Payment provider onboarding, signed webhooks, refunds, payouts and reconciliation pass sandbox and production verification.
6. KYC/privacy/consent/retention, grievance and safety operations are reviewed for the actual launch jurisdictions.
7. Production signing key is configured outside source control; Play App Signing and release track are prepared.
8. CI, automated tests, crash reporting, backups, monitoring and real-device smoke tests pass.
9. The marketplace has operational support coverage, supplier verification and transparent fee/cancellation policies.

## Build outputs
GitHub Actions publishes:
- A release-mode unsigned QA APK (not Play Store signed).
- A debug-only demo APK (for internal walkthroughs only; not public distribution).
- An unsigned iOS simulator build for compilation validation only.

No build or device installation is considered successful until the corresponding workflow run and artifact are available and verified.
