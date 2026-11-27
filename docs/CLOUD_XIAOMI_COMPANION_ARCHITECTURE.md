# BAD GYM Cloud-first Xiaomi Companion Architecture

Status: architecture and cloud QA contract. This is not yet a working remote-control app.

## Target topology
- GitHub PR is the source of truth.
- GitHub Actions hosted runners execute Flutter format, analyze, tests and ARM64 APK build.
- Firebase Test Lab runs repeatable virtual/physical Android smoke tests.
- Firebase App Distribution or GitHub artifacts deliver APKs.
- An opt-in BAD GYM Companion on Xiaomi pairs with a private command broker.
- The companion returns screenshots, display metrics, app state and bounded diagnostics.
- Visual QA compares actual device screenshots to the approved reference before changing another component.

## Existing verified capabilities
- Existing PR branch has Flutter CI and ARM64 build.
- Existing android-build workflow already contains optional Firebase Test Lab Robo lanes and Firebase App Distribution steps, gated by repository secrets.
- Historical Tailscale/ADB workflow uses a static ANDROID_DEVICE_PORTS_JSON map and paired ADB host key. It is not dynamic endpoint discovery.
- Previous Windows Local Agent is optional, not the target architecture.

## Security model — mandatory
- Pairing requires an explicit user action and a short-lived, single-use pairing code/QR.
- Bind device identity to Firebase Authentication UID and a server-issued device record. Never trust client-supplied device ID alone.
- Cloud commands are authorized by backend after checking authenticated owner and device ownership.
- Allow-listed commands only: device_info, capture_screenshot, launch_bad_gym, tap, swipe, read_logcat_tail. No arbitrary shell, broad file browsing, package uninstall, SMS, contacts, microphone, camera or gallery harvesting.
- Every command has unique ID, expiry, bounded arguments and audit record. Reject replayed/expired commands.
- Screenshot capture uses Android MediaProjection consent. User must approve a foreground capture session; no silent or persistent capture.
- Tap/swipe uses AccessibilityService only after explicit user enablement in Android Settings, with visible disclosure and stop control.
- Companion never silently installs APKs. Open Android's package installer and require user confirmation.
- Do not expose ADB to public internet or open router ports. Tailscale is optional transport, not a substitute for device authorization.
- Never store service-account keys, signing keystores or admin secrets in APK/source.

## Phases
### Phase 1 — Cloud build and test
Configure GCP_SERVICE_ACCOUNT_JSON, GCP_PROJECT_ID, FIREBASE_APP_ID and FIREBASE_TOKEN as GitHub Actions secrets. Enable Firebase Test Lab API, grant minimum IAM roles, register Android package com.badgym.bad_gym_member_intelligence and create tester group bad-gym-qa. Firebase lanes skip until configured; GitHub artifact remains fallback.

### Phase 2 — Companion app
Add explicit pairing screen, device diagnostics, consent controls, capture-session controls and stop/revoke. Implement MediaProjection foreground service and narrowly scoped AccessibilityService. No broad storage permission. Screenshots remain app-private until an approved command uploads them.

### Phase 3 — Secure command broker
Use Firebase Auth + Firestore/Realtime Database + callable Cloud Functions. Pairing code is random, single-use, expires in 5 minutes and is rate-limited. Backend stores owner UID, installation ID, capabilities and last-seen time. Commands use immutable envelopes with ID, device ID, type, bounded args, createdAt and expiresAt. Only trusted backend can enqueue. Results contain command ID/status/time and bounded metadata. Screenshot bytes go to private Firebase Storage with short-lived access. Provide immediate revoke.

### Phase 4 — Closed-loop visual QA
Small component change -> CI -> Firebase Test Lab smoke -> deliver APK -> user-approved install/open -> companion capture -> reference diff -> inspect logs -> fix only evidenced mismatch -> repeat. Never claim pixel-perfect without actual Xiaomi screenshot and recorded visual diff.

## Current blockers
- No Firebase project config (google-services.json) exists in current branch.
- Firebase connector is not connected.
- GitHub Firebase lanes are optional and skip without credentials.
- Physical Xiaomi control requires companion installation, explicit permissions, pairing and backend provisioning. Cloud build alone does not provide phone control.

## Acceptance criteria
- Cloud build succeeds without local computer.
- Firebase Test Lab artifacts include launch result and screenshot.
- Xiaomi companion pairs with one-time code and reports online status.
- Screenshot only during user-approved MediaProjection session.
- Tap/swipe only after explicit Accessibility opt-in and allow-list validation.
- Revocation stops commands; expired/replayed commands are rejected.
- Screenshot delivered privately and visual diff retained with PR.
- No public ADB, arbitrary shell, silent install or broad personal-data access.
