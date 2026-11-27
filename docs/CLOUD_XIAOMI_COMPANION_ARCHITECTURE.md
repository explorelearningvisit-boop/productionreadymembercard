# BAD GYM Cloud-first Xiaomi QA Architecture

Status: GitHub APK artifact workflow and opt-in Tailscale/ADB test lane are implemented in the workflow. A standalone Android Companion app is not implemented.

## Target topology
- GitHub PR/branch is the source of truth.
- GitHub-hosted Actions runners execute Flutter formatting, analysis, tests and ARM64 APK build.
- APK is uploaded as a GitHub Actions artifact; no Firebase service is required.
- Optional manual workflow dispatch connects an ephemeral GitHub runner to the owner's Tailscale network.
- The runner uses ADB over the private tailnet to install, launch, capture a screenshot and collect bounded device diagnostics from the explicitly authorized Xiaomi.
- Visual QA compares the actual Xiaomi screenshot to the approved reference before changing another component.

## Physical device access
- Tailscale runner node is ephemeral and tagged `tag:ci`.
- OAuth client credentials are GitHub Actions secrets, never source files.
- Tailscale ACL/grants must permit `tag:ci` to reach only the Xiaomi on TCP 5555.
- Xiaomi must be signed into the same tailnet and have ADB debugging explicitly enabled and authorized.
- ADB TCP mode is opt-in and must not be exposed on public internet or router ports.
- Workflow only invokes fixed ADB commands for install, launch, screenshot, logcat tail and display diagnostics. No arbitrary shell input.
- The remote lane is manual-dispatch only; normal PR build never tries to connect to the phone.

## Security contract
- No public ADB, router port forwarding or broad tailnet permissions.
- Keep Android ADB authorization enabled; disable TCP debugging when not testing.
- No arbitrary shell, broad file browsing, package uninstall, SMS, contacts, microphone, camera or gallery harvesting.
- No silent background screen recording. Screenshot is captured only as part of an explicitly dispatched QA run.
- Never store signing keystores or admin secrets in APK/source.

## Phases
### Phase 1 — GitHub APK delivery (implemented)
Format Dart, run analyzer/tests, build ARM64 release APK, verify signature/checksum and upload artifact for 30 days.

### Phase 2 — Tailscale Xiaomi QA lane (workflow implemented; user provisioning required)
Connect an ephemeral `tag:ci` runner, connect to the authorized Xiaomi ADB endpoint, install/launch BAD GYM, capture screenshot and upload bounded diagnostics. Requires Tailscale OAuth secrets, `TS_DEVICE_IP` variable, narrow ACL and one-time Xiaomi ADB setup.

### Phase 3 — Standalone Companion (not implemented)
If later needed, add a native Android companion with explicit pairing, consent controls, screenshot capture and visible disconnect/revoke. It is not required for the current ADB-based test workflow.

## Acceptance criteria
- APK build and artifact download succeed without Firebase.
- Physical-device lane is skipped unless manually requested and configured.
- Tailscale runner is ephemeral and restricted to Xiaomi ADB port.
- Xiaomi ADB connection is authenticated; no public port exposure.
- Workflow installs/launches app and returns screenshot plus bounded diagnostics.
- No claim of device verification until a real successful run returns the Xiaomi screenshot.
