# BAD GYM — ChatGPT-only, laptop-independent deployment

**Status:** Target architecture and current verified state. Phone-side agent and dynamic ADB discovery are not yet implemented.

## User's explicit operating decision
The user's laptop has been stolen and must not be part of future BAD GYM work. The user will issue voice/text instructions in the same ChatGPT conversation. ChatGPT should use authorized GitHub repository operations and GitHub Actions for coding, commits, cloud builds, logs and artifacts. Do not ask the user to open a laptop, run a laptop terminal, connect USB to a laptop, or install/run the Windows Local Agent.

## Device and data invariant
- Device: Xiaomi 11i 5G (21091116I), Android 13 / MIUI.
- BAD GYM package: com.badgym.bad_gym; main activity: com.badgym.bad_gym/.MainActivity.
- User confirms BAD GYM is currently installed.
- **Never uninstall the app, clear its data, or perform destructive migration automatically.** If Android reports a signing conflict, stop, preserve the existing app/data and report the exact error. Any migration must be explicitly approved.

## Desired deployment pipeline
1. User gives a command in ChatGPT.
2. ChatGPT reads latest main, project instructions and current CI evidence; makes requested minimal source changes through supported GitHub tools.
3. Commit/push to GitHub main.
4. GitHub Actions runs Flutter format/analyze/tests and Gradle APK build; uploads immutable APK artifact with checksum.
5. A cloud deployment runner joins the user's private Tailscale network using least-privilege, short-lived identity where possible.
6. Runner resolves the correct Xiaomi tailnet peer and obtains a fresh authenticated ADB endpoint/authorization.
7. Runner verifies TCP reachability and adb get-state before any device action.
8. Runner installs APK in place without uninstall/data wipe, launches BAD GYM, performs approved smoke checks, captures screenshot/logcat and uploads evidence.
9. ChatGPT inspects run/job/step logs and artifacts, diagnoses failures, applies bounded safe fixes and records a durable handoff.

## Critical technical boundary
Tailscale API/peer-online status is control-plane/network metadata. It does not itself execute Android commands and does not automatically expose ADB. The GitHub runner must be on the same authorized tailnet, the Android device must have a live ADB daemon/endpoint reachable over that path, and the runner must possess a valid paired ADB host identity. Tailscale Online != TCP reachable != ADB paired/authorized != install permission.

ADB actions such as install, launch, tap, swipe, scroll and screenshot are possible only after the runner has a verified ADB device state. Never claim these actions happened without fresh runner logs/artifacts.

## Current observed state (2026-11-16)
- Latest build run: https://github.com/explorelearningvisit-boop/productionreadymembercard/actions/runs/43838086739
- Commit: 668f7a5d895f402113aa2d0763b1ad6c19cd8f08
- Flutter checks, tests and release APK build: PASS.
- APK artifact ID: 14212365972.
- APK SHA-256: 2f16985b5bc8e3418e3e02aa35def866872a67c28ebf276f92535cc9f4551a1c.
- Device QA: FAIL at ADB connection; no new install/launch/screenshot verified.
- User's supplied Wireless Debugging screen shows toggle OFF and Android asks to connect to Wi-Fi to enable it. Previously observed Tailscale IP 100.123.18.54 and historical port 37337 are not proof of a currently open ADB endpoint. Never guess port 5555.

## Required implementation tasks
1. Inspect Android 13/MIUI-supported options for a phone-side authenticated deployment agent/heartbeat that can report device identity and current endpoint over cellular/Tailscale.
2. Determine Android's actual package-install authorization model. A normal app must not be assumed capable of silently installing arbitrary APKs; design an explicitly user-approved provisioning/update path if required.
3. Evaluate whether existing BAD GYM package can host a safe update-check/deployment component without changing application identity or losing data. Preserve signing continuity.
4. Authenticate endpoint registration and bind it to expected Xiaomi tailnet identity. Never send pairing codes, private keys or tokens to logs.
5. Keep ANDROID_DEVICE_PORTS_JSON as temporary manual fallback until dynamic discovery passes real end-to-end tests; then remove static dependency.
6. Add durable deployment queue, online/ADB-ready state machine, bounded retries, backoff, per-device/per-commit lock and deferred recovery.
7. Capture independent evidence for build, Tailscale join, peer discovery, TCP, ADB authorization, install, launch, smoke test, screenshot and logs.
8. Update AI_SYNC_STATE.json, AI_SHARED_COMMUNICATION_HUB.md, ANTIGRAVITY_TASK.md and docs/DECISION_LOG.md after each meaningful change.

## Non-goals / forbidden assumptions
- No laptop, local USB bridge, local terminal or Windows Local Agent dependency.
- No public ADB listener or router port forwarding.
- No assumption that Tailscale API is an ADB command API.
- No assumption that phone can be woken or controlled while powered off.
- No assumption that ordinary Android apps can silently self-install APKs.
- No automatic uninstall, app-data clearing, signature bypass or destructive migration.
- No claim of persistent/second-by-second monitoring unless a deployed observer returns fresh timestamped telemetry.

## Agent startup
Every AI agent must read docs/AI_CONTEXT_BOOTSTRAP.md, AGENTS.md, this file, AI_SYNC_STATE.json, CURRENT_DESIGN_SPEC.md, ANTIGRAVITY_TASK.md, docs/NETWORK_ARCHITECTURE.md, docs/DECISION_LOG.md, docs/CONTINUOUS_AGENT_OBSERVABILITY.md, AI_SHARED_COMMUNICATION_HUB.md and the current workflow before acting. GitHub main is the durable shared project memory.
