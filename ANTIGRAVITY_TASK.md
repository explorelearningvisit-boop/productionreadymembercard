# Antigravity Handoff — BAD GYM (living handoff)

**Mandatory:** Read docs/AI_CONTEXT_BOOTSTRAP.md and AGENTS.md before any action. Then read AI_SYNC_STATE.json, CURRENT_DESIGN_SPEC.md, docs/NETWORK_ARCHITECTURE.md, docs/DECISION_LOG.md, this handoff and latest AI_SHARED_COMMUNICATION_HUB.md entries. Inspect latest main commits and current Actions run/artifacts.

## Current handoff — 2026-11-16
- Repository: explorelearningvisit-boop/productionreadymembercard, branch main.
- AI continuity documents have been added: docs/AI_CONTEXT_BOOTSTRAP.md, docs/NETWORK_ARCHITECTURE.md, docs/DECISION_LOG.md. AGENTS.md and CHATGPT_COCKPIT.md were rewritten as mandatory agent protocols; README links to context docs; AI_SYNC_STATE.json and AI_SHARED_COMMUNICATION_HUB.md updated.
- Network topologies required: home Wi-Fi, own hotspot, third-party hotspot, hotspot shared onward through another phone, USB tethering, Ethernet, cellular, and transitions. Never assume same LAN/mDNS/fixed DHCP IP/fixed ADB port.
- Xiaomi 11i 5G (21091116I), Android 13/MIUI. Last observed Tailscale IP 100.123.18.54, USB serial zxdada69gunb7ls4. User last reported Wireless Debugging connect port 37337; transient only. Android may disable Wireless Debugging after power-off; user re-enables it. User is an experienced developer; do not repeat generic debug-toggle instructions without evidence.
- Dynamic ADB endpoint discovery is documented but NOT implemented. Current workflow still consumes ANDROID_DEVICE_PORTS_JSON and DEVICE_ADB_PRIVATE_KEY_B64. Do not claim port auto-discovery yet.
- Security: previous Tailscale auth key and ADB private key material were exposed; rotate/revoke them. Never put secret values in docs/chat/commits.
- Required next implementation: design/build authenticated Android endpoint discovery or device agent, validate ADB over Tailscale across supported topologies, remove static port secret only after end-to-end tests. Maintain manual endpoint fallback until then.

## Existing CI/device QA lessons (historical; verify current run)
- Tailscale join, peer-online, ADB transport, ADB authorization, APK signature, MIUI install authorization, launch, and screenshot are separate failure stages.
- Earlier runs showed Tailscale join succeeded; other runs showed offline peers or ADB endpoint failures. Inspect latest run artifacts rather than repeating old diagnoses.
- Never auto-uninstall or wipe user data. Do not claim fresh screenshot/install without artifacts.

## Before editing
1. Fetch latest main and inspect recent commits and all touched files.
2. Read current workflow .github/workflows/android-cloud-device.yml and docs/ANDROID_CLOUD_DEVICE_QA.md.
3. Preserve ChatGPT or other agent changes; batch coherent commits.
4. Update AI_SYNC_STATE.json and append AI_SHARED_COMMUNICATION_HUB.md after work.
5. Run relevant tests/build and report exact results.

## Active next steps
- [ ] Verify current secret names/configuration without printing values; rotate exposed credentials via admin UI.
- [ ] Implement authenticated current-endpoint discovery for Xiaomi Wireless Debugging.
- [ ] Handle network changes and stale ADB socket reconnect.
- [ ] Validate home Wi-Fi, independent hotspot/cellular, third-party hotspot, USB tethering and Ethernet scenarios.
- [ ] Keep APK build available when device is offline; report device QA separately.


## 2026-11-16 — ChatGPT Windows Local Agent integration
- Added optional Windows stdio MCP server under tools/badgym_local_agent/ with bounded ADB/Tailscale/Flutter operations, direct screenshot image results, guarded source writes and approved in-place APK installation.
- Read docs/LOCAL_AGENT_SETUP.md before local installation or tunnel onboarding.
- USB ADB first; Wireless ADB requires live Tailscale peer + current Android Wireless Debugging connect port + successful adb get-state. No static port assumption.
- Local writes disabled by default and restricted to lib/, test/, pubspec.yaml and analysis_options.yaml with expected-hash checks and external backups.
- This repository commit does not install software on the user's Windows laptop, provision an OpenAI tunnel, connect the phone, or prove physical QA. These require the Windows host and live phone to be online.


## Local Agent merge status — 2026-11-16
- PR #3 merged to main: 2835954f4315b6348b6f800cb721b1113569f719.
- Python Local Agent validation passed on PR head (compileall, 6 unit tests, Ruff); main-branch rerun and Flutter build rerun were queued at the time of this handoff.
- CI install safety fixed: signature mismatch now preserves installed app/data; no unattended uninstall.
- Windows laptop installation, OpenAI Secure MCP Tunnel provisioning, live USB/Wireless ADB, and fresh Xiaomi screenshot remain unverified and require the Windows host/phone to be online.


## Mandatory continuous-observation requirement (2026-11-16)
Before starting, read `docs/CONTINUOUS_AGENT_OBSERVABILITY.md` and follow `AGENTS.md` + `docs/AI_CONTEXT_BOOTSTRAP.md`. User requires all collaborating agents to inspect timestamped active task/run telemetry, changed files and logs through supported authenticated tools, diagnose failures, apply minimal safe fixes, validate and write durable handoffs. Do not claim live/per-second observation unless an actual persistent watcher is running and returning fresh events. The persistent observer + GitHub event ingestion + bounded recovery implementation is tracked in issue #5: https://github.com/explorelearningvisit-boop/productionreadymembercard/issues/5. Coordinate deferred Xiaomi install work with issue #2. Current implementation status: contract documented; watcher NOT YET IMPLEMENTED.


## 2026-11-16 — ACTIVE: laptop-free ChatGPT ↔ Xiaomi command channel (Issue #6)
- Laptop is stolen/unavailable: do not require local USB, Windows Local Agent, local terminal or laptop runner.
- User sends voice/text commands in ChatGPT. Target is ChatGPT/GitHub Actions → private Tailscale/cellular transport → Xiaomi 11i → timestamped command result/evidence.
- Audit Android 13/MIUI feasibility first. Direct ADB is available only if a device-side ADB daemon is enabled, reachable and paired. Tailscale API is not an ADB executor.
- If Wireless Debugging is unavailable on cellular, evaluate an authenticated phone-side companion service with outbound connection, command allowlist, foreground heartbeat, explicit user-approved AccessibilityService for gestures, MediaProjection consent for screenshots and PackageInstaller user-confirmed update. Do not promise silent install.
- Preserve currently installed BAD GYM package/data and signing continuity. No uninstall, pm clear, data wipe or signature bypass.
- Current GitHub Actions already installs adb and joins tailnet but requires static ANDROID_DEVICE_PORTS_JSON; latest device QA failed at ADB connectivity. User screenshot shows Wireless Debugging OFF.
- Implementation specification and acceptance tests: https://github.com/explorelearningvisit-boop/productionreadymembercard/issues/6
- Acceptance: with laptop absent and Xiaomi on Jio cellular, ChatGPT-originated harmless test command reaches phone and returns fresh timestamped evidence; then consented update-in-place and screenshot/log verification.


## Latest user direction — compact workspace + in-app updates (2026-11-16)
- Mandatory read before UI/release work: docs/UI_COMPACT_WORKSPACE_SPEC.md and docs/IN_APP_UPDATE_ARCHITECTURE.md.
- Current tall scrollable dashboard and stacked attendance chart+calendar are rejected. Attendance > Calendar is the default; contextual rail switches one bounded widget at a time. Four quick tabs remain. Primary dashboard must not vertically scroll.
- Use compact warm-ivory + crimson/red + restrained gold; semantic green/red/amber/grey. Remove competing lavender/purple and peach gradients.
- In-app Update Center is accepted architecture, but not yet implemented. Compiled Flutter UI/logic changes require a new APK; no arbitrary Dart hot patch. Publish stable GitHub Releases (not expiring Actions artifacts), manifest, SHA-256 and changelog only after tests and protected signing. Installer is Android-approved and may require user confirmation.
- Signing continuity is a hard gate: current CI APK is QA/debug signed and existing installed app fingerprint is unverified. Never uninstall or clear data to force update.
- Append-only history: keep all prior records; update state/handoff after each task. Do not delete history.

## Next implementation sequence
1. Refactor MemberCheckInScreen into bounded no-scroll workspace with Attendance Calendar default and contextual rail widget replacement.
2. Add widget tests for viewport height, rail switching and default calendar.
3. Establish protected release signing continuity before any user-facing update installer.
4. Implement stable GitHub Release manifest + verified download + Android PackageInstaller flow and tests.
5. Update version/changelog and publish immutable releases only after CI passes.


## 2026-11-16 — ACTIVE: compact fixed-viewport dashboard + in-app updater
- ChatGPT has begun real Flutter/native implementation; do not treat the specs as docs-only anymore.
- Read docs/UI_COMPACT_WORKSPACE_SPEC.md and docs/IN_APP_UPDATE_ARCHITECTURE.md before edits.
- `lib/presentation/member_checkin_screen.dart` now uses LayoutBuilder and a bounded workspace instead of root vertical scrolling. It compresses the member context, keeps four quick tabs, and swaps one contextual widget in place. Attendance defaults to Calendar; rail views include Trend, History and Insights. Workout, Payment and Body have focused destinations.
- `lib/core/services/update_center_service.dart` checks GitHub latest stable release, requires HTTPS GitHub APK asset + SHA-256 digest + explicit versionCode in release notes, and calls the native installer.
- Android Kotlin MainActivity downloads APK into app-private cache, verifies SHA-256, stages via PackageInstaller, and lets Android show confirmation. Never bypass MIUI/Android confirmation.
- Stable release workflow `.github/workflows/publish-android-release.yml` requires protected release keystore secrets. Do not publish default debug-signed builds as stable. No release is ready until protected signing key custody is provisioned and signing continuity is verified.
- pubspec version: 0.2.0+2.
- CI run 43876682039 was cancelled by rapid follow-on commits before tests. Inspect newest main run; repair all formatter/analyzer/test/Gradle failures. No build or physical device verification is claimed yet.
- Do not restore root scrolling, mixed lavender palette, oversized hero, stacked chart+calendar+insight. Do not delete history or uninstall/clear user data.

## 2026-11-16 — ACTIVE: Antigravity Windows full-run + Xiaomi physical QA
- New mandatory runbook: `docs/ANTIGRAVITY_FULL_RUN_HANDOFF.md` (commit 6ba7f483). This is the canonical copy/paste plan for Windows PowerShell preflight, latest-main sync, full Flutter format/analyze/test/release build, USB-first ADB, Tailscale/Wireless Debugging fallback, existing-app launch, screenshot/logcat, safe signature gate, and GitHub evidence write-back.
- Antigravity must use its own integrated terminal for PowerShell/Flutter commands. Existing Local Agent MCP does not expose arbitrary shell or `flutter run`; its bounded tools cover health, ADB/Tailscale inventory, connect, screenshot, logcat, launch, allowlisted analyze/test/build and guarded install.
- Do not run `flutter run` or install a locally built APK until the local signing certificate is confirmed to match the installed app. Preserve app/data. No uninstall or clear-data workaround.
- Full-run evidence must be committed under `qa/local-runs/<timestamp>/`, and `AI_SYNC_STATE.json`, `AI_SHARED_COMMUNICATION_HUB.md`, and this handoff updated with commit/run/screenshot/report links.
- Current cloud APK 0.2.0+2 build is green, but cloud Xiaomi QA was blocked because the tailnet peer showed Offline=false? Correction: peer's Online field was false. Antigravity must query live state before any connection attempt.
- Next action: on the powered-on Windows laptop, open the existing repository in Antigravity, paste the master task from `docs/ANTIGRAVITY_FULL_RUN_HANDOFF.md`, and let it perform the documented full run. It must push its evidence report to GitHub for ChatGPT to read.

## 2026-11-16 — COMPLETED: Antigravity Windows Full Run, 3D Flame/Trophy Badges & Physical Xiaomi 11i Verification
- **Status**: COMPLETE & VERIFIED.
- **3D Assets**:
  - Replaced legacy low-res flame clip art with 1024x1024 ultra-HD glossy 3D flame badge (`assets/badges/streak_flame.png`) and golden trophy cup (`assets/badges/best_trophy.png`) on clean transparent alpha backgrounds.
  - Sourced and synchronized to user's raw assets folder `C:\Users\User\Downloads\BAD_GYM_Individual_Visual_Assets_v3\BAD_GYM_Individual_Assets\`.
- **UI Updates**:
  - Embedded 3D flame and trophy into `AttendanceMetricsRow` and `MemberCheckInScreen` Insights panel and footer.
  - Linked athlete portrait avatar (`assets/hero/hero_athlete.png`) with golden circular trim into member profile card.
  - Formatted streak numbers with bold crimson italic styling (`#990000`).
- **Validation**:
  - Static analysis: strict 0 issues (`flutter analyze --no-fatal-infos`).
  - Unit/widget test suite: **11/11 tests pass** (`flutter test`).
  - Release APK: built cleanly (`flutter build apk --release`, 59.6 MB).
  - Keystore signing continuity: validated SHA-256 `dcff9efa8cb91c9169b62b87d16e63a881ba78f78b4e4a53625a28de616a3c55`.
- **Physical Device Deployment**:
  - Target: Xiaomi 11i 5G (`zxdada69gunb7ls4` via USB & `100.123.18.54:5555` via TCP/IP).
  - In-place streamed install succeeded without data loss or app uninstallation.
  - Live on-device screenshot captured to `docs/screenshots/bad_gym_live.png`.


## 2026-11-16 — COMPLETED: Antigravity Local USB Fast-Deploy & Pixel-Perfect Physical Verification
- **Status**: COMPLETE & VERIFIED ON HARDWARE.
- **Protocol Enforced**: Antigravity is the local execution agent. Fast local builds and USB in-place streamed installs (`adb -s zxdada69gunb7ls4 install -r`) execute without triggering intermediate GitHub Actions runs.
- **Physical Verification Evidence**: `docs/screenshots/bad_gym_live_screen.png` captured live on Xiaomi 11i 5G (`21091116I`) running Android 13/MIUI.
- **Matching Reference Design**: Matches `media_1794676950728_33461b16.jpg` across all 6 sections (Laurel wreath header bar, Check-In Success banner, Member Profile pass, Quick Stats with active red gradient Attendance card, two-column 372px fixed-height intelligence section with dark rail and Attendance Intelligence card with 3D flame/trophy badges and solid colored pill calendar matrix with day 16 concentric ring, and bottom nutrition burger banner).
- **Test Validation**: 10/10 Flutter tests passing, analyzer 0 issues.
- **App Data**: 100% preserved. No uninstall, no data clear.


## 2026-11-19 — KaamVerse marketplace UX implementation handoff
- Active scope: `apps/arjun_flutter/` on branch `rebuild/kaamverse-platform` only. Do not edit unrelated branches.
- User approved KaamVerse labour marketplace: both individual + business customers; hourly + daily + project hiring; Customer, Worker, Contractor/Team, Field Manager and Admin journeys.
- Current visual authority for this branch: KaamVerse collage approved by user in 2026-11-19 conversation, blended with existing ARJUN marketplace flows where clearer. Root BAD GYM history is not applicable to this app folder.
- First implementation slice: Customer Home is committed in source. Check current branch head and Actions before further edits.
- Transparent asset rule: decorative raster art must be individual PNGs with actual alpha; no checkerboard-baked images or flattened screen collages. Native Flutter icons/text/charts remain native.
- Current limitation: ChatGPT can inspect GitHub snapshots and Actions runs; it cannot claim continuous second-by-second monitoring or physical phone QA without fresh evidence. Firebase/backend is explicitly out of scope for this UX phase.
- Next: verify current Customer Home build/test run; fix any concrete failures; then implement Customer service discovery screen and add widget tests.


## 2026-11-19 — Customer Home CI result
- Run 44470297648 succeeded at code commit 05856aa836606b223a5b4d004df51a45c3ff3f94.
- Format, analyze, tests, debug APK, release QA APK and artifact upload all passed.
- Combined artifact 14503539255 was downloaded and inspected; ZIP contains app-debug.apk and app-release.apk. SHA-256 hashes are recorded in AI_SYNC_STATE.json.
- Phone QA was skipped; do not claim physical device install or screenshot.
- Next: Customer Service Discovery and Filters screen, following the approved component-by-component process.
