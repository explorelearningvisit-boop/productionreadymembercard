# Antigravity Handoff — BAD GYM (2026-11-15)

## Read first
1. `CURRENT_DESIGN_SPEC.md` is the active UI/UX authority.
2. The latest user-approved reference is the red/crimson + gold + white BAD GYM dashboard image supplied on 2026-11-15.
3. Royal Purple / Neon Violet is obsolete. Do not reintroduce it.
4. Member card must be crimson/red as a whole, including payment/expiry and membership progress; gold progress fill; green Active and gold Plan badges. Vertical rail stays burgundy/red.

## Current Git state
- Member profile red treatment commit: `25268481b78f46c704bc4473e175ab61d897731c`.
- Design authority created: `CURRENT_DESIGN_SPEC.md`.
- AI handoff docs and `AI_SYNC_STATE.json` updated to remove stale purple/5555 assumptions.
- CI run for profile card commit: https://github.com/explorelearningvisit-boop/productionreadymembercard/actions/runs/43708801687
- Earlier cloud build run #9 succeeded: Flutter formatting step, analyze, tests, release APK build and artifact upload. APK was 55.5 MB.
- Earlier Tailnet QA did NOT run. Logs explicitly report: "Tailscale or ADB keys not set in repository secrets. Skipping live device testing." No device screenshot was captured in that run.

## Required next actions
1. Pull latest `main`.
2. Inspect `member_profile_card.dart` visually and improve red card treatment without changing the reference's content hierarchy.
3. Run `dart format`, `flutter analyze`, `flutter test`, `flutter build apk --release`.
4. Review `CURRENT_DESIGN_SPEC.md`, and update `assets/README.md` only after checking asset alpha/dimensions/usage. Do not blindly regenerate all PNGs.
5. Fix CI device setup and validate with actual phone only after secrets are safely configured.
6. Do not claim a physical device install or screenshot until a current workflow run contains fresh screenshot/logcat artifacts.

## Critical credential security
A base64-encoded ADB private key was pasted into the ChatGPT conversation. Treat that key as compromised. Do NOT reuse it, commit it, print it in logs, or paste it into another chat. Generate a fresh dedicated ADB host key on the trusted laptop, authorize its public key on the connected phone (accept the Android "Allow USB debugging" prompt), and store the private key only as the encrypted GitHub Actions secret `DEVICE_ADB_PRIVATE_KEY_B64`. Rotate/revoke the old debugging authorization on the phone after the new key is confirmed.

The current workflow log proves the ADB/Tailscale secret check returned false. Configure the required GitHub Actions secrets in repository Settings > Secrets and variables > Actions:
- `DEVICE_ADB_PRIVATE_KEY_B64` (fresh dedicated key, base64 encoded)
- Either `TS_OAUTH_CLIENT_ID` plus `TS_AUDIENCE` and the corresponding OAuth secret as required by the Tailscale GitHub Action, OR `TAILSCALE_AUTHKEY`.
- `ANDROID_DEVICE_PORTS_JSON` mapping each Android tailnet hostname to its CURRENT Wireless Debugging TCP connect port.

Never expose any private key, OAuth secret, auth key or token in source files or chat. Confirm actual secret names against the workflow before setup. Tailscale IP alone is not enough: Android Wireless Debugging port is dynamic, and ADB authorization is separate from Tailscale connectivity. Do not assume port 5555. Inventory all peers, but only attempt APK install on online Android devices with a valid port and authorized ADB host key.

## Expected device QA evidence
For every successful Android device:
- install latest release APK
- launch `com.badgym.bad_gym/.MainActivity`
- capture fresh screenshot and last 3000 logcat lines
- upload artifacts with hostname, Android version, model, and result
- report offline/unconfigured/unauthorized devices separately

## AI-to-AI handoff
After Antigravity completes a task, append timestamp, changed files, commit SHA, analyze/test/build result, and actual device result to `AI_SHARED_COMMUNICATION_HUB.md`. Keep `AI_SYNC_STATE.json` current. The latest user instruction and `CURRENT_DESIGN_SPEC.md` override stale historical notes.
