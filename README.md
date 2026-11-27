# BAD GYM — Member Intelligence Card

BAD GYM is a Flutter Android member-dashboard prototype focused on a compact, phone-first member intelligence view.

## Current UI

- Member identity, plan/status, membership progress and payment summary
- Check-in and plan-freeze preview interactions
- Four primary KPI modules: Attendance, Workout, Payment and Body
- A contextual six-destination rail whose content follows the selected KPI module
- Attendance analytics, monthly calendar, member product artwork and campaign preview surfaces
- Plan-adaptive member shell: Gold (metallic amber), Silver (steel), Diamond (ice blue) and Spark (emerald)
- Campaign artwork and ad surfaces retain their own campaign colours, independent of plan tier
- Finite entrance motion, subtle perspective depth on product artwork, hover feedback for pointer devices, pressed feedback for touch, and reduced-motion support

## Data and integration status

**This repository currently runs on local sample data. It is not connected to a live gym backend.** The demo member, attendance totals, workout metrics, payment balance, goals and campaign content are not fetched from a server.

The check-in toggle is a local preview only. The Freeze and Whey actions open explanatory preview sheets; they do not submit a membership request or make a purchase. No payment gateway, ad network, push-notification service, persistent offline store, authentication provider or production analytics provider is configured in this app.

Do not use the current sample values for real member decisions.

## Build and QA

The GitHub Actions workflow resolves Flutter dependencies, formats Dart sources in the CI checkout, runs flutter analyze, widget tests and builds an ARM64 release-mode QA APK. The release APK is signed with the Android development/debug key for sideload QA. It is **not** signed with a private Play App Signing upload key and is not a Play Store production release.

## Remaining production gates

1. Connect an authenticated, gym-scoped API and replace MemberSample.demo with repository-backed member records.
2. Implement server-authoritative check-in, freeze requests, payment status and audit history with retries, idempotency and authorization tests.
3. Configure secure production signing through protected CI secrets; never commit signing keys or passwords.
4. Configure privacy-compliant analytics, push notifications and campaign/ad destinations only when the relevant providers and consent flows exist.
5. Validate offline, loading, empty, error and expired-session states against the real backend.
6. Install the exact release artifact on the target Xiaomi device and compare a fresh capture with the owner reference. Widget/CI success is not proof of pixel-perfect device rendering.

## CI

[Open BAD GYM GitHub Actions](https://github.com/explorelearningvisit-boop/productionreadymembercard/actions)
