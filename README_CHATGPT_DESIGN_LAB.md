# BAD GYM — ChatGPT Design Lab

Independent visual implementation branch: `chatgpt/design-lab-yellow-festive`.

## Isolation
- Built from the current `main` baseline; all work is isolated to this branch.
- Android applicationId is `com.badgym.designlab`, so the evaluation APK installs alongside the production `com.badgym.bad_gym` app.
- No production database, user data, signing identity, or main-branch source is changed.
- Use a separate Git worktree/clone for this branch if Antigravity is editing the same repository locally.

## Design direction
Yellow festive / warm ivory surfaces, gold borders, emerald success, semantic red/amber/purple states, compact member profile, sponsor banner, four horizontal intelligence tabs, narrow contextual vertical rail, and a bounded attendance workspace.

## Build
```bash
flutter pub get
dart format --output=none lib test
flutter analyze --no-fatal-infos
flutter test --reporter expanded
flutter build apk --release
```

APK: `build/app/outputs/flutter-apk/app-release.apk`

Package: `com.badgym.designlab` (separate install; does not replace production).

## Network / Tailscale
Reuse only the existing documented local-agent and Tailscale setup. Never copy secrets, ADB private keys, auth keys, pairing codes or endpoint assumptions into this branch. Physical device QA requires a live authorized ADB handshake. See `docs/ANTIGRAVITY_FULL_RUN_HANDOFF.md` and `docs/NETWORK_ARCHITECTURE.md`.

## Current limitations
This is an independent UI prototype. The member values and sponsor campaign are sample presentation data; connect them to the app's domain/data layer only after visual approval. The profile portrait is a placeholder icon until an approved/licensed member image asset is supplied. QR is a visual placeholder in this first pass.
