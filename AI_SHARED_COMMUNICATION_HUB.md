# 🤖 BAD GYM — AI Shared Communication Hub & Inter-Agent Protocol

> **Purpose**: This file is the primary shared communication channel and source of truth across all AI systems (Antigravity, ChatGPT, Claude, and automated agents) and human collaborators working on the **BAD GYM** project.
> 
> **Rule for All AI Agents**: Whenever you inspect, modify, test, or push code, you **MUST** read this file first and append your session notes, decisions, device tests, and commit references to the [Inter-Agent Message Board](#-inter-agent-message-board). Always commit and push this file to GitHub along with your changes.

---

## 📌 Project Identity & Repository Status

| Attribute | Value |
| :--- | :--- |
| **Sole Production Repository** | `https://github.com/explorelearningvisit-boop/productionreadymembercard.git` |
| **Local Path** | `C:\Users\User\AndroidStudioProjects\productionreadymembercard` |
| **Active Primary Branch** | `main` |
| **Mirrored Feature Branch** | `setup/flutter-member-intelligence` |
| **Application ID** | `com.badgym.bad_gym` |
| **Main Activity** | `com.badgym.bad_gym/.MainActivity` |
| **Current Target Flutter SDK** | Flutter `>=3.5.0 <4.0.0` (Dart 3.5+) |
| **Status** | Current CI build/test status must be checked in latest workflow; hardware verification is pending unless a fresh artifact proves it. |

---

## 📱 Hardware & Deployment Profile (Lifetime Memory)

All AI agents must observe this dual-channel auto-fallback deployment sequence:

```
[Start Task] 
      │
      ├──▶ Channel A: Wired USB (Serial: zxdada69gunb7ls4)
      │     └─ If present: Run `adb -s zxdada69gunb7ls4 tcpip 5555` to keep wireless open.
      │
      └──▶ Channel B: Tailscale Mesh VPN (IP: 100.123.18.54:<current-wireless-debugging-port>)
            └─ If wired disconnected: Run `adb connect 100.123.18.54:<current-wireless-debugging-port>`.
```

- **Device Hardware**: Xiaomi 11i 5G (`21091116I`) running Android 13 (MIUI).
- **Physical Screen**: 1080 × 2400 pixels (~440 dpi, scale factor `2.75x`).
- **Wake & Keyguard Dismiss Command**:
  ```powershell
  adb -s <target> shell input keyevent 224
  adb -s <target> shell wm dismiss-keyguard
  adb -s <target> shell am start -n com.badgym.bad_gym/.MainActivity
  ```
- **Live Screencap Command**:
  ```powershell
  adb -s <target> shell screencap -p /sdcard/bad_gym_live.png
  adb -s <target> pull /sdcard/bad_gym_live.png docs/screenshots/bad_gym_live.png
  ```

---

## 🎨 UI/UX Design System Specification (Royal Purple VIP Dashboard)

The UI matches the user's fixed, pixel-perfect design across 3 core layers:

### 1. Top Header Bar (`lib/presentation/widgets/top_header_bar.dart`)
- **Container**: Royal purple gradient (`#380B61` → `#160032`) with neon violet hairline border (`#B066FE`, 1.5dp, box-shadow aura).
- **Left**: Ashwani Kumar Singh circular avatar with neon purple ring.
- **Center Capsule**: Dark glass pill (`#130125`) with:
  - `✔ Checked In` neon green capsule (`#22C55E` → `#16A34A`).
  - Vertical translucent hairline divider (`Color(0x33FFFFFF)`).
  - `06:42 PM` (bold white, 14.5sp) over `Fri, 16 Oct 2026` with calendar icon.
- **Right**: Notification bell with red badge (`3`), vertical 3-dots menu button (`⋮`).

### 2. VIP Member Profile Pass Card (`lib/presentation/widgets/member_profile_card.dart`)
- **Athlete Portrait**: High-res cutout (`assets/images/vip_athlete_hi.png`) integrated smoothly in top-left without harsh boxed boundaries.
- **Center Check-In**: `✔ Checked In` neon pill, large bold time `06:42 PM`, `Fri, 16 Oct 2026`, and `Main Gym Floor` with location pin.
- **Divider**: Thin vertical translucent line.
- **Right Payment**: `Payment` with wallet icon and 3-dots, `✔ Paid` green pill, bold amount `₹1,200`, `Next Due: 24 Oct 2026`, and 3D purple protein shaker bottle (`assets/images/vip_shaker_hi.png`).
- **Nested Dark Glass Container**:
  - `Ashwani Kumar Singh` (13.5sp bold white), `✔ Active` green pill, `👑 Gold Plan` amber/gold pill.
  - `BG215 | 28 Years | ♂ Male`.
  - Membership progress: `Membership: 22 / 30 Days (73.3% Used)`. Full-width track with neon lime-green gradient fill (`#22C55E` → `#4ADE80`).
  - Floating pearl card: `⏰ 8 Days Left` (red `#EF4444`, bold) over `Expires on: 24 Oct 2026`.

### 3. Full-Width Quick Stats Row (`lib/presentation/widgets/quick_stats_row.dart`)
- Spans full width above the rail and card:
  - `Attendance 81%`: Active tab in deep royal purple with neon violet glowing border.
  - `Workout 58 min`: Pearl white with purple dumbbell icon.
  - `Payment Paid`: Pearl white with gold wallet icon and bold green `Paid`.
  - `Body 69.5 kg`: Pearl white with cyan icon and bold `69.5 kg`.

### 4. Vertical Navigation Rail (`lib/presentation/widgets/vertical_navigation_rail.dart`)
- 66dp wide royal purple rail:
  - `Intelligence` (Active glowing violet capsule with bar chart icon).
  - `Calendar`, `History`, `Trend`, `Streak`, `Analysis`.
  - Translucent divider line (`#3B1563`).
  - `Goals`, `Reports`, `Offers`, `More`.

### 5. Attendance Intelligence Card (`lib/presentation/widgets/attendance_intelligence_card.dart`)
- White pearl card with:
  - Purple icon badge + `Attendance Intelligence` + `ⓘ` info icon + `Oct 2026 ▼` dropdown.
  - Donut Chart: Neon lime-green arc (81%), `81%`, `25 / 31`, `Days`.
  - Legend: `● Present 23`, `● Late 2`, `● Absent 2`, `● Holiday 4`.
  - Streaks: `🔥 Current Streak 5 Days`, `🏆 Best Streak 14 Days`.
  - Calendar Grid: `< October 2026 >`, Mon–Sun with active day `16` featuring glowing concentric double-ring.
  - Floating circular dark action button (`↓`).

---

## 💬 Inter-Agent Message Board

> **Instructions for AI Collaborators (ChatGPT, Claude, Antigravity, etc.)**:
> Please append your messages below using the following format:
> ```markdown
> ### [YYYY-MM-DD HH:MM UTC] <Agent Name / Model>
> - **Action**: What was inspected, built, or modified.
> - **Verification**: Test, build, or device results.
> - **Git Commit**: SHA and message.
> - **Next Recommendations**: Any instructions for the next agent or user.
> ```

### [2026-11-12 16:05 UTC] Antigravity
- **Action**:
  - Integrated dynamic intelligence switching across all 4 quick stat tabs:
    - `AttendanceIntelligenceCard`: interactive month picker, streak counters, donut chart, attendance calendar grid.
    - `WorkoutIntelligenceCard`: daily workout program (Chest & Arms, intensity high), exercise routine checklist with completion status, duration/calorie/sets metrics, "Log Next Set" action, and active rest timer pill (`01:30`).
    - `PaymentIntelligenceCard`: current plan status, monthly fee, next due countdown, billing invoice history (`TXN#BG-9921`), "Renew Plan Now", and PDF GST receipt download.
    - `BodyIntelligenceCard`: weight tracker (`69.5 kg`), body fat (`14.2%`), muscle mass (`34.8 kg`), circumferences (chest, arms, waist), and InBody 570 sync.
  - Implemented luxury modals matching the Royal Purple / Neon-Glow design system:
    - `RenewalSheet`: multi-tier membership renewal (Gold 1-mo, Platinum 3-mo with 15% discount), early bird notice, and one-tap UPI checkout button.
    - `NotificationSheet`: gym alerts and updates with category badges, 3 new notifications (streak, renewal, protein shake perk), and "Mark All as Read" action.
    - `MemberQrSheet`: VIP access pass modal with full-width barcode, NFC turnstile reader instructions, and gate access confirmation.
  - Fixed subtle horizontal RenderFlex overflows on narrower physical device widths across all sheets and cards.
  - Expanded widget test suite from 4 to 6 comprehensive tests covering tab switching, modal presentation, and interaction.
  - Verified dual-channel device connectivity: Channel A wired (`zxdada69gunb7ls4`) and Channel B Tailscale wireless mesh (`100.123.18.54:<current-wireless-debugging-port>`).
  - Captured live device screenshots for all newly added views into `docs/screenshots/`.
- **Verification**:
  - `flutter analyze`: **0 issues found** (strict clean).
  - `flutter test`: **6/6 tests passed** (100% test suite green).
  - Device Verification: Installed debug APK on connected Xiaomi 11i 5G (`21091116I`), verified interactive tab switching and modal sheets live, captured screenshots:
    - `docs/screenshots/bad_gym_dashboard.png` (Main Attendance Dashboard)
    - `docs/screenshots/bad_gym_workout.png` (Workout Intelligence Card)
    - `docs/screenshots/bad_gym_payment.png` (Payment Intelligence Card)
    - `docs/screenshots/bad_gym_body.png` (Body Intelligence Card)
    - `docs/screenshots/bad_gym_notifications.png` (Gym Alerts & Updates Sheet)
    - `docs/screenshots/bad_gym_qr_pass.png` (VIP Access Pass Modal)
    - `docs/screenshots/bad_gym_live.png` (Live Device Screen)
- **Git Commit**: `feat: complete interactive intelligence tabs, VIP modals, device verification, test suite`
- **Next Recommendations**:
  - All 4 quick stat intelligence cards and VIP sheets are fully operational and verified on hardware.
  - Next recommended step: implement offline persistence layer (e.g. SQLite / SharedPreferences or Hive) to save user-logged sets and weight entries between app restarts.

---

## 📋 Roadmap & Backlog

- [x] Initial fresh Flutter project structure & tokens
- [x] Royal Purple / Neon-Glow / Luxury Glass visual styling
- [x] Full-width Quick Stats 4-tab bar
- [x] Left Vertical Navigation Rail with glowing `Intelligence` pill
- [x] Attendance Intelligence Donut chart, legend, streaks, and interactive calendar
- [x] High-res asset pipeline for athlete & 3D shaker bottle
- [x] Zero-warning static analysis & unit test suite passing (6/6 tests)
- [x] Physical device live verification & dual-channel fallback protocol
- [x] GitHub remote sync (`main` & `setup/flutter-member-intelligence`)
- [x] Workout detail card & routine log checklist (when workout tab is selected)
- [x] Payment detail card & billing invoice history (when payment tab is selected)
- [x] Body intelligence card & measurements (when body tab is selected)
- [x] VIP Access Pass & gate turnstile barcode modal
- [x] Gym alerts & updates notification sheet
- [x] Membership renewal multi-tier modal with UPI checkout
- [ ] Offline local caching via SQLite / SharedPreferences


### [2026-11-16 UTC] ChatGPT — compact mobile layout revision
- **Action**: Confirmed `productionreadymembercard` is the sole production Flutter repository on `main`. Updated the member screen so the event/profile header and four quick-stat tabs use full width; placed the narrow crimson vertical rail beside only the selected intelligence canvas; added Payment as the fourth horizontal quick tab; removed Smart Insight and the bottom metric strip; removed the duplicate CHECK-IN/QR badge and gym-floor text while retaining the event date/time.
- **Verification**: GitHub Actions build/device workflow triggered by the latest code changes. Build, tests, APK installation and fresh screenshot remain pending until the current run completes. No claim of physical-device verification is made yet.
- **Git Commit**: See latest `main` commit after the grouped UI changes.
- **Next Recommendations**: Inspect the current workflow result and device screenshot; correct any layout/test issue before calling this release verified.


### [2026-11-16 UTC] ChatGPT — CI and device QA result
- **Action**: Fixed the duplicate Payment label test assertion and added a Payment-tab navigation assertion. Latest GitHub Actions run #45: https://github.com/explorelearningvisit-boop/productionreadymembercard/actions/runs/43801332361
- **Verification**: `dart format`, Flutter static analysis, Flutter widget tests and release APK build/upload all passed. Tailnet QA authenticated successfully, but the tailnet inventory marked every configured peer offline, including Xiaomi 11i (100.123.18.54). ADB was therefore not attempted; installation and fresh screenshot capture are unverified. The QA job uploaded its inventory artifact and failed its explicit "at least one Android device passed" gate.
- **Git Commit**: UI code and test changes are on `main`; latest test commit `3b3c65afe0799776d333d1e66df539a51201556a`.
- **Next Recommendations**: Connect Tailscale on Xiaomi 11i, keep the device online, enable Wireless Debugging, and ensure the current ADB TCP port is reflected in the encrypted `ANDROID_DEVICE_PORTS_JSON` secret. Rerun workflow to install and capture a fresh screenshot.


### [2026-11-16 UTC] ChatGPT — AI continuity + network-agnostic architecture handoff
- **Action**: Added mandatory new-session bootstrap, network architecture, and append-only decision log. Updated AGENTS.md and CHATGPT_COCKPIT.md to require every agent to read latest main, current state, design authority, decisions, workflow and handoff before editing; every agent must write changes/tests/CI/device status back.
- **Network requirement**: Laptop and Xiaomi can be on same Wi-Fi, different cellular networks, user's own hotspot, third-party hotspot, hotspot shared onward through another phone, USB tethering, Ethernet, or changing uplinks. No same-LAN/mDNS/DHCP/fixed-port assumptions. Tailscale is the preferred private overlay; ADB is a separate transport requiring current endpoint, paired host identity and successful get-state.
- **Device facts**: Xiaomi 11i 5G (21091116I), Android 13/MIUI; previously observed Tailscale IP 100.123.18.54 and USB serial zxdada69gunb7ls4; latest user-reported Wireless Debugging connect port 37337 is transient. User is an experienced developer; do not repeat generic debug-toggle instructions. Android may disable Wireless Debugging after power-off; user will re-enable it.
- **Verification status**: Documentation and context protocol added. Dynamic ADB discovery/Android agent is a documented target only, not implemented. Current workflow still uses encrypted ANDROID_DEVICE_PORTS_JSON. No fresh device install/screenshot is claimed by this documentation change.
- **Security**: Removed literal credential from cockpit guide. Previously exposed Tailscale auth key and ADB private key material require rotation/revocation; only secret names may appear in docs.
- **Next**: Implement and test authenticated endpoint discovery, network-change reconnect, and removal of static port secret dependency. Do not expose ADB publicly.


### [2026-11-16 UTC] ChatGPT — Deferred Xiaomi installation request
- **User request**: User is powering off Xiaomi 11i and wants BAD GYM installed when the device is powered on again; preserve the requirement in GitHub and keep observing/retrying failures until the install/test succeeds.
- **Action**: Created issue #2 (https://github.com/explorelearningvisit-boop/productionreadymembercard/issues/2), recorded the deferred install lifecycle in AI_SYNC_STATE.json and docs/DECISION_LOG.md.
- **Current truth**: Device status is `WAITING_FOR_DEVICE_POWER_ON` based on the user's report. No APK was installed in this attempt. A fully powered-off phone cannot be reached for installation. Current GitHub Actions skips offline peers and still requires ANDROID_DEVICE_PORTS_JSON; automatic queueing, dynamic endpoint discovery and bounded retry/resume are not implemented.
- **Safety**: Do not uninstall or wipe app data automatically. Validate Tailscale, current Wireless Debugging endpoint, ADB transport/authorization, install, launch and screenshot as separate stages. Persist failure artifacts and use bounded retries without overlapping runs.
- **Next**: Implement issue #2. Once the user powers the Xiaomi back on and enables its normal network/debug availability, trigger a fresh device QA run and verify install/launch/screenshot with current artifacts.


### [2026-11-16 UTC] ChatGPT — Windows Local Agent implementation
- **Action**: Added tools/badgym_local_agent/ as an independent Windows stdio MCP service inside the canonical productionreadymembercard repository, plus docs/LOCAL_AGENT_SETUP.md and a dedicated Python validation workflow. Exposed bounded device discovery, Tailscale peer metadata, explicit-port Wireless ADB connection, screenshot image return, logcat, display metrics, tap/swipe/navigation, app launch, allowlisted Flutter analyze/test/build, guarded source reads/writes, and approved in-place APK install.
- **Safety**: No arbitrary shell, generic delete, secret reader, public ADB, auto-uninstall or data wipe. Writes default off, restricted to app source/test and two config files, require expected SHA-256 + explicit approval, and back up outside the repo.
- **Network**: USB ADB first. Wireless requires a live Tailscale peer and current Android Wireless Debugging connect port; ADB get-state verifies authorization. No hardcoded IP/port or 5555 fallback. Screenshots return directly through MCP instead of GitHub relay.
- **Verification**: Implementation is in branch feat/badgym-windows-local-agent. Python validation workflow is added but has not yet completed. Windows installation, OpenAI tunnel provisioning, live phone connection and physical UI QA are NOT yet verified.
- **Product boundary**: OpenAI Secure MCP Tunnel is documented for supported OpenAI surfaces. Current ChatGPT custom MCP support is web-only; direct custom MCP access from the Android ChatGPT app is not available. Plan-level write access must be checked in the actual workspace; it is not assumed.
- **Next**: CI must pass; then install agent on Windows host, validate USB and Wireless ADB against Xiaomi, provision Secure MCP Tunnel through Platform credentials, and connect/test from a supported ChatGPT web workspace or Responses API client.


### [2026-11-16 UTC] ChatGPT — Local Agent merged to main
- **Action**: Merged PR #3 (Add BAD GYM Windows Local MCP Agent) into main. Merge commit: 2835954f4315b6348b6f800cb721b1113569f719. The PR also removed unattended CI uninstall/reinstall on APK signature mismatch; CI now preserves the installed app and user data and reports SIGNATURE_MISMATCH_PRESERVED_DATA.
- **Verification**: Windows Local Agent Validation run 43805541198 passed on the PR head: Python compileall, unit tests (6 tests), and Ruff. Main-branch validation rerun 43805608981 and Flutter/Android build run 43805608987 were queued at handoff update. Previous Flutter workflow 43801332361 passed analyze, tests and release APK build but failed physical-device QA because no configured Tailnet device was online.
- **Not yet done**: Agent has not been installed on the user's Windows laptop from this ChatGPT session; OpenAI Secure MCP Tunnel has not been provisioned; no current live ADB session or fresh Xiaomi screenshot is claimed. Custom MCP in ChatGPT is web-only, not callable directly from the Android ChatGPT app.
- **Next**: Run tools/badgym_local_agent/install-windows.ps1 on the Windows laptop, configure the stdio MCP client, verify USB ADB, then verify Wireless ADB using the current Tailscale peer and current Wireless Debugging connect port. Provision Secure MCP Tunnel separately through Platform settings and test from a supported web/workspace/API surface.


### [2026-11-16 UTC] ChatGPT — Unified member dashboard card revision
- **User request**: Make the entire Ashwani member dashboard one bordered card; rail only alongside Attendance Trend through Smart Insight and Streak/Best/Plan Days/Next Goal; keep Payment visible among four horizontal tabs; remove duplicate CHECK-IN action; lighten deep red/brown palette.
- **Action**: Updated `lib/presentation/member_checkin_screen.dart` to add a full outer member card and restore the Smart Insight + four-metric summary under Attendance. Updated vertical rail to light rose and 50dp width, softened check-in ribbon, and updated `CURRENT_DESIGN_SPEC.md`, `docs/DECISION_LOG.md`, `AI_SYNC_STATE.json`.
- **Code commits**: `80dcdaf4b67b45ec843eb8981017f67d4f27b6d0` (screen), `79f04b2971ab6d6e884fcd983f70a74fbf6673c7` (rail), `f37e595fdf0c2668986900c6182b027f828dfd96` (ribbon). Docs/state commits follow.
- **Verification**: GitHub file updates succeeded. Flutter format/analyze/tests/release APK build have not yet been run by this session. No fresh phone install or screenshot is verified.
- **Next**: Run CI on the latest main commit, inspect widget tests and APK artifact, then install in place on Xiaomi and capture a new screenshot. Do not claim physical verification before artifact evidence.
