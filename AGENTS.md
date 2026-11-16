# BAD GYM — Repository Rules for Every AI Agent

> **MANDATORY FIRST READ:** `docs/AI_CONTEXT_BOOTSTRAP.md`. It is the entry point for every fresh ChatGPT, Antigravity, Claude, IDE agent, or human contributor. Then read `AI_SYNC_STATE.json`, `CURRENT_DESIGN_SPEC.md`, `ANTIGRAVITY_TASK.md`, and the latest entries in `AI_SHARED_COMMUNICATION_HUB.md`.

## Canonical project identity
- Repository: https://github.com/explorelearningvisit-boop/productionreadymembercard
- Branch: `main` (check remote state before editing; do not assume local checkout is current).
- App: Flutter/Dart, Android + iOS target; Android package `com.badgym.bad_gym`; launcher `com.badgym.bad_gym/.MainActivity`.
- Primary local path historically used: `C:\Users\User\AndroidStudioProjects\productionreadymembercard` (verify on the actual machine).
- `badnewgym` is obsolete. Never edit it.
- GitHub is the shared durable source of truth. Do not rely on chat memory.

## Required session protocol
1. Fetch latest `main`; inspect `git status` and recent commits before any edits.
2. Read the mandatory context documents above and inspect the actual source files relevant to the task.
3. Read latest CI run and artifacts before assuming build/device state.
4. Record the user's new requirement in `docs/DECISION_LOG.md` before/with implementation when it changes architecture, product behaviour, design, security, or workflow.
5. Make the smallest coherent change. Preserve unrelated Antigravity/ChatGPT work; never overwrite uninspected changes.
6. Run `dart format`, `flutter analyze`, `flutter test`, and the appropriate build. Report exact outcomes.
7. Update `AI_SYNC_STATE.json` and append a timestamped entry to `AI_SHARED_COMMUNICATION_HUB.md` with files, commit, tests, CI run, device QA, blockers, and next action.
8. Commit/push to the agreed branch. Do not claim a push, build, install, screenshot, or pixel verification unless the corresponding tool/run artifact proves it.
9. If another agent has made newer commits, inspect and reconcile them before writing. Never force-push or blindly reset.

## Authority and conflict resolution
1. Latest explicit user instruction in the current task.
2. Latest dated accepted decision in `docs/DECISION_LOG.md`.
3. `CURRENT_DESIGN_SPEC.md` for visual authority.
4. `AI_SYNC_STATE.json` for current machine-readable status.
5. `ANTIGRAVITY_TASK.md` and `AI_SHARED_COMMUNICATION_HUB.md` for handoff/history.
6. Older prose, screenshots, historical notes, and stale prompts are not authority if superseded.
When two docs conflict, do not silently choose: resolve against dated user decision and update the stale document in the same change.

## Product/UI invariants
- Mobile-first compact Member Intelligence experience. Preserve the existing approved card structure and real device constraints; do not invent a new layout unless asked.
- Four horizontal intelligence tabs, in order: Attendance, Workout, Payment, Body.
- Keep the member identity/payment/expiry context clear. Attendance is the default tab unless the user changes it.
- The current visual authority is only the latest approved image/spec recorded in `CURRENT_DESIGN_SPEC.md`; historical purple and other superseded concepts must not be revived without explicit approval.
- Do not add redundant labels, duplicate menus, Smart Insight or bottom summary strips that the user explicitly removed.
- Do not use static images for live data charts, progress bars, status indicators, or interactive controls. Render data-driven UI in Flutter.

## Device profile and debugging assumptions
- Primary test device: Xiaomi 11i 5G, model `21091116I`, Android 13 / MIUI, 1080×2400 physical pixels, approx. 2.75 device scale.
- Tailscale node identity/IP previously observed: `Xiaomi 11i` / `100.123.18.54`. Treat IP as an observed current value, not an eternal guarantee.
- USB ADB serial previously observed: `zxdada69gunb7ls4`; verify with `adb devices -l` at runtime.
- User has explicitly stated USB debugging, Wireless debugging, and MIUI security-related debugging settings are normally enabled and configured. Do not patronizingly repeat basic "turn debugging on" instructions. Diagnose actual evidence first. Android may disable Wireless Debugging after a phone power cycle; the user has acknowledged this specific reboot behaviour and will re-enable it when needed.
- Wireless Debugging connect port is dynamic. Latest user-provided endpoint at time of this document: `100.123.18.54:37337`. This is a transient observation only. Never hardcode it as a permanent port or assume 5555.
- Pairing port/code and ADB connect port are different. Never confuse them. Pairing identity is long-lived; connect port can change.

## Network operating environments (must all be supported)
The user's laptop and Xiaomi may use different and changing uplinks:
- Home: both on same Wi-Fi.
- Laptop on user's own phone hotspot; Xiaomi on mobile data or another network.
- Laptop on a third-party phone hotspot; Xiaomi on mobile data/Wi-Fi.
- User's phone hotspot shared to another phone, then laptop joins that phone's hotspot.
- Laptop on USB tethering from any phone.
- Laptop on Ethernet/wired LAN while Xiaomi uses Wi-Fi or cellular.
- Network transitions between Wi-Fi, mobile data, hotspots, USB tethering and Ethernet.
Do not assume same LAN, same subnet, same gateway, stable DHCP address, or mDNS visibility. mDNS is LAN-only and is not a cross-internet discovery mechanism.

## Intended network/device architecture
- Tailscale provides the stable private device identity/overlay path when both endpoints are online and ACLs permit. Prefer Tailscale DNS/peer identity over changing LAN IPs.
- ADB transport is a separate layer. Tailscale Online does not prove ADB TCP reachability, pairing, authorization, or an open port.
- Discover the current Wireless Debugging connect endpoint after reconnect/reboot; validate with an actual TCP/ADB handshake. Do not infer the port from the pairing screen.
- Prefer USB ADB when physically connected and authorized; otherwise use verified Wireless ADB over LAN or Tailscale.
- mDNS may be used only as an optional same-LAN discovery hint. It must not be required for remote/mobile-data/hotspot scenarios.
- Desired future improvement: replace static `ANDROID_DEVICE_PORTS_JSON` mapping with an authenticated device-side discovery/agent or explicit user-approved endpoint registration. This is an architecture target, **not yet implemented**. Until then the current workflow still expects the encrypted GitHub secret mapping.
- Never expose ADB publicly. Restrict Tailscale ACLs to the CI runner and approved device/port. No open router port-forwarding.
- Do not promise automatic reconnection while the phone is powered off or Wireless Debugging is disabled by Android after reboot. Recovery begins only after the phone is on, network/Tailscale is online, and Wireless Debugging is available.

## Security and secrets
- Never commit or print tokens, Tailscale auth keys, OAuth secrets, ADB private keys, pairing codes, keystores, passwords, or secret values.
- Secrets belong only in GitHub Actions encrypted secrets or a dedicated secret manager.
- A previously exposed Tailscale auth key and ADB private-key material are documented as compromised/exposed. Rotate/revoke them in their respective admin consoles before production use; do not reuse old material.
- Old documentation contained a literal credential and stale port claims. Those values must not be copied into prompts or used.
- Never automatically uninstall the user's app or wipe app data to fix signing/install issues. Ask first if destructive migration is required.

## Build and QA commands
```bash
flutter pub get
dart format --output=none lib test
flutter analyze --no-fatal-infos
flutter test --reporter expanded
flutter build apk --release
```
Current authoritative workflow: `.github/workflows/android-cloud-device.yml`. Read it before changing CI. Build/test success and physical-device QA success are separate statuses.

## Completion report format
- Changed files + commit SHA
- Tests/analysis/build with exact result
- Latest GitHub Actions run URL and status
- Device: Tailscale status, ADB status, install status, launch status, screenshot artifact status separately
- Known blockers and one next action
Never call it production-ready or pixel-perfect without current device evidence.


## Windows Local Agent
- The supported local execution agent lives in tools/badgym_local_agent/; setup is documented in docs/LOCAL_AGENT_SETUP.md.
- It is separate from Flutter app runtime and existing app design. Keep all local-agent code under tools/badgym_local_agent/.
- Default MCP mode is read/diagnostic. Writes are opt-in, limited to lib/, test/, pubspec.yaml and analysis_options.yaml, require explicit approval and expected SHA-256, and create a backup outside the repository.
- Never add arbitrary shell execution, generic deletion, secret-reading, public ADB ingress, automatic uninstall or app-data wipe tools.
- ChatGPT mobile does not currently support custom MCP connections. Do not claim the Windows agent is directly callable from the Android ChatGPT app; use supported ChatGPT web/workspace or a separate Responses API client via Secure MCP Tunnel.

## Continuous agent observation and recovery (mandatory)
- Every agent MUST read `docs/CONTINUOUS_AGENT_OBSERVABILITY.md` at session start.
- Use authorized connectors to inspect live runner/task state, changed files, logs, CI jobs and artifacts before claiming current activity. Record timestamps and run IDs.
- Diagnose from full logs, make minimal safe fixes, validate, and write back state + handoff. Never fabricate telemetry or claim second-by-second monitoring from snapshot-only tools.
- Persistent observation requires a separately running local observer/event consumer; GitHub Actions jobs and chat sessions are not perpetual processes. Implement and verify the watcher per the contract; until then label this capability NOT IMPLEMENTED.
- Keep telemetry read-only/redacted by default; writes require least privilege, expected hashes, backups and explicit approval. Bounded retries only; no overlapping device installs, no public ADB, no automatic uninstall/data wipe.


## User authorization — implementation autonomy (2026-11-16)
- User explicitly authorizes ChatGPT to make the engineering and architecture decisions needed to complete the laptop-free ChatGPT → GitHub Actions → Tailscale/cellular → Xiaomi device-control workflow. Do not repeatedly ask the user to approve ordinary engineering choices, code edits, commits, tests, workflow changes, diagnostics or safe retries.
- Proceed autonomously within available authenticated GitHub/tool permissions; inspect, implement, validate, monitor available run logs, and update durable handoff files.
- This standing authorization does NOT override Android OS permission prompts, Google Play/Android security boundaries, GitHub/Tailscale account authorization, secret provisioning, or irreversible/destructive operations. If an on-device permission must be granted by the user, explain the exact one-time prompt/action only when the implementation reaches that step. Never bypass OS security.
- Preserve the existing BAD GYM installation and all app data. No uninstall, data clear, signing bypass, public ADB ingress, or secret disclosure.
- Be explicit about actual capability: GitHub Actions are finite jobs; do not claim persistent monitoring, live ADB control, installation, or screenshots without fresh evidence.


## Latest user direction — compact workspace + in-app updates (2026-11-16)
- Mandatory read before UI/release work: docs/UI_COMPACT_WORKSPACE_SPEC.md and docs/IN_APP_UPDATE_ARCHITECTURE.md.
- Current tall scrollable dashboard and stacked attendance chart+calendar are rejected. Attendance > Calendar is the default; contextual rail switches one bounded widget at a time. Four quick tabs remain. Primary dashboard must not vertically scroll.
- Use compact warm-ivory + crimson/red + restrained gold; semantic green/red/amber/grey. Remove competing lavender/purple and peach gradients.
- In-app Update Center is accepted architecture, but not yet implemented. Compiled Flutter UI/logic changes require a new APK; no arbitrary Dart hot patch. Publish stable GitHub Releases (not expiring Actions artifacts), manifest, SHA-256 and changelog only after tests and protected signing. Installer is Android-approved and may require user confirmation.
- Signing continuity is a hard gate: current CI APK is QA/debug signed and existing installed app fingerprint is unverified. Never uninstall or clear data to force update.
- Append-only history: keep all prior records; update state/handoff after each task. Do not delete history.
