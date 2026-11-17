# ARJUN Flutter App

ARJUN is a Hindi-first workforce and services marketplace for customers, workers, field managers and suppliers.

## Run
```sh
flutter pub get
flutter run
```

## Current scope
- Flutter Material 3 mobile app; responsive, scrollable layouts for compact screens.
- Role-mode switcher: Customer, Worker, Field Manager, Supplier.
- Customer dashboard, skill categories, demo job feed and job-posting form.
- Worker browse/interest flow, activity summary, profile and Hindi/English toggle.
- Lightweight native widgets; no large image or animation dependencies.

## Honest release status
This commit is a functional **front-end MVP scaffold**, not a production marketplace release. Jobs are in-memory demo data and reset when the process restarts. Authentication, KYC, persistent backend, server-side role permissions, geolocation, dispatch, messaging, real payments/payouts, supplier inventory, push notifications, dispute operations, legal/privacy policies and production monitoring are not yet integrated. No real money is collected or held.

## Build
The GitHub Actions workflow creates Android/iOS platform folders on ephemeral runners, runs formatting, analysis and tests, and builds an Android release APK. The QA APK is not Play Store production-signed. A protected production keystore and reviewed payment/KYC integrations are required before public launch.

## Low-end device design
Uses standard Material widgets, compact data models, lazy/scrollable lists, no heavy visual packages, and avoids fixed-height screen compositions. Final performance and accessibility must still be validated on actual low-RAM devices and small screens.
