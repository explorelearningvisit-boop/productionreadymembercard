# Antigravity Task — Member Intelligence Mobile Rebuild

## Project identity
- Project: BAD GYM Member Intelligence Android app
- Repository: `explorelearningvisit-boop/productionreadymembercard`
- Working branch: `chatgpt/member-intelligence-mobile-rebuild`
- Base branch: `main`
- Package: inspect `applicationId` from `android/app/build.gradle` before any install.
- Project root: this repository root (Flutter project). Do not mix files or APKs from another app/project.

## Design source of truth
Use the user's latest uploaded Xiaomi screenshot as the only layout reference for this task (image size 1024 × 1536 px, including Android status and navigation bars). Reproduce its content hierarchy and adapt to the actual device logical viewport using MediaQuery/LayoutBuilder; do not hard-code screenshot pixels as dp.

Visual language: ice-blue / pale cyan glass surface, cool blue borders and soft shadows, navy typography, rounded translucent panels, subtle water/ice highlights, emerald present/active, amber late/gold, red absent/due, grey holiday/off. Keep legibility and contrast. Use the existing supplied image assets where they match. Do not invent new modules or add multiple themes.

Screen composition to preserve/refine:
1. Compact BAD GYM header with brand mark and notification/action controls.
2. One integrated member identity/check-in card with portrait, member ID, age/gender, plan/status and QR.
3. Compact payment due + membership expiry/progress information (remove duplicate cards/rows).
4. Four compact KPI tiles: Attendance, Workout, Payment, Body.
5. Largest bounded workspace: compact left contextual rail, month/calendar view, attendance summary/legend.
6. Small bottom AI insight strip only if it fits without forcing vertical scrolling.

The user's latest screenshot supersedes older screenshots and old red/ivory or other design descriptions. Do not restore old red theme, dark rail, large hero banner, tall scrollable layout or duplicated payment/progress cards unless the latest screenshot itself requires them.

## Required engineering work
1. Read `AGENTS.md`, `docs/AI_CONTEXT_BOOTSTRAP.md`, `docs/CONTINUOUS_AGENT_OBSERVABILITY.md`, `docs/UI_COMPACT_WORKSPACE_SPEC.md`, `docs/ANTIGRAVITY_FULL_RUN_HANDOFF.md`, `AI_SYNC_STATE.json`, and latest `AI_SHARED_COMMUNICATION_HUB.md` entries.
2. Inspect current branch, recent commits, current workflow and latest CI/device artifacts before editing.
3. Work only on `chatgpt/member-intelligence-mobile-rebuild`; never push this task to `main`.
4. Fix compile/analyzer/test failures first. Keep app entrypoint and widget/state architecture coherent; do not paste a screen's methods into a StatelessWidget without state ownership.
5. Refactor the screen to a bounded, responsive mobile layout. Avoid root vertical scrolling on the main dashboard; prevent RenderFlex overflow at compact heights.
6. Keep each Flutter project isolated. This repository is the Member Intelligence project. For another app, use a separate sibling workspace folder/repository and its own package ID, workflow artifact prefix and APK output path. Never overwrite or reuse another project's APK.
7. Keep dependencies minimal. Add an animation/graphics package only when it solves a concrete requirement and document why. Prefer Flutter's built-in implicit animations for simple transitions.
8. Add/update widget tests for default screen, viewport sizing, rail navigation and overflow.
9. Run:
   - `flutter pub get`
   - `dart format --output=none lib test`
   - `flutter analyze --no-fatal-infos`
   - `flutter test --reporter expanded`
   - `flutter build apk --release`
10. Save this project's APK only under `build/app/outputs/flutter-apk/`; upload with artifact name prefix `bad-gym-member-intelligence-`. Never call it production-signed unless protected signing identity is verified.
11. Xiaomi 11i device QA is a separate gate: inspect Tailscale peer and current ADB state, preserve installed app/data, check package/signing compatibility before install, launch, capture fresh screenshot and logcat. Never uninstall, clear data or bypass Android confirmation.
12. Write timestamped evidence under `qa/local-runs/<timestamp>/`, update `AI_SYNC_STATE.json`, append (never overwrite history in) `AI_SHARED_COMMUNICATION_HUB.md`, and update this handoff with exact commit, workflow run, analysis/test/build/device outcomes.

## Completion report (mandatory)
Report exact branch + commit, changed files, analyzer/test/build results, workflow run URL, APK artifact name, and device install/launch/screenshot statuses separately. Do not say "pixel-perfect", "installed", or "production-ready" without fresh corresponding evidence.


## ChatGPT implementation status — 2026-11-17
- The user explicitly directed ChatGPT to implement the complete Flutter UI independently of Antigravity. Antigravity's local laptop work is independent; do not block this cloud branch on local outputs.
- Original reference image is available in this conversation at `/mnt/data/1000320035.jpg`, 1024 × 1536 px. It has been reopened and inspected; do not ask the user to upload it again unless they supply a newer reference.
- New screen implementation: `lib/presentation/reference_member_dashboard.dart`; app entry point switched in `lib/main.dart`. It implements ice-blue glass header, integrated member/check-in/QR card, festival promo, four KPI tiles, compact contextual rail, attendance calendar with summary donut/legend, and bottom AI Insights strip. The dashboard uses a bounded non-scroll layout.
- Sample member fixture name updated to match the source screenshot: Ashwani Kumar Sharma Vishwakarma.
- Added `qr_flutter` to render a real member QR code in the card.
- Widget tests rewritten for reference sections, 360dp compact viewport, tab/rail changes, and notification interaction. CI result pending for latest commit; inspect fresh run before claiming tests/build passed.
- Do not install an APK or claim hardware match until a current successful build artifact and fresh Xiaomi screenshot are available. Preserve existing app data and signing continuity.
