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
| **Status** | Production Ready • 0 Analyze Warnings • 100% Tests Passing • Verified on Hardware |

---

## 📱 Hardware & Deployment Profile (Lifetime Memory)

All AI agents must observe this dual-channel auto-fallback deployment sequence:

```
[Start Task] 
      │
      ├──▶ Channel A: Wired USB (Serial: zxdada69gunb7ls4)
      │     └─ If present: Run `adb -s zxdada69gunb7ls4 tcpip 5555` to keep wireless open.
      │
      └──▶ Channel B: Tailscale Mesh VPN (IP: 100.123.18.54:5555)
            └─ If wired disconnected: Run `adb connect 100.123.18.54:5555`.
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
  - Verified dual-channel device connectivity: Channel A wired (`zxdada69gunb7ls4`) and Channel B Tailscale wireless mesh (`100.123.18.54:5555`).
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
