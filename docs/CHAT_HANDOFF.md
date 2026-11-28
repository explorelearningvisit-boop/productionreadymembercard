# BAD GYM — Cross-chat implementation handoff

Updated: 2026-11-28  
Repository: https://github.com/explorelearningvisit-boop/productionreadymembercard  
Working branch: grok/purple-neon-member-dashboard

## Resume every new chat/agent
1. Read AGENTS.md and DESIGN.md.
2. Read docs/BADGYM_EMERALD_PEARL_VISUAL_MASTER_SPEC_2026-11-28.md.
3. Read docs/IMPLEMENTATION_PROGRESS.md.
4. Read assets/design_system/emerald_pearl_theme.json and PulseVault README/manifest.
5. Verify live branch HEAD, latest commit diff and latest Actions run before editing.
6. Continue at first incomplete stage. Do not ask owner to repeat recorded requirements.

## Visual master
Emerald + Pearl approved 2026-11-28 replaces Purple Neon/Lilac Glass. Reference 841×1870px, ratio 0.4497; logical 360×800dp with real system bars/SafeArea. Emerald frame + pearl workspace; Gold badge; ice Freeze; mint/lavender/sky KPI roles; semantic status colors.

## Repository map
- Full spec/prompt: docs/BADGYM_EMERALD_PEARL_VISUAL_MASTER_SPEC_2026-11-28.md
- Resume ledger: docs/IMPLEMENTATION_PROGRESS.md
- Theme pack: assets/design_system/emerald_pearl_theme.json
- Theme: lib/theme/member_theme.dart
- Screen: lib/screens/member_dashboard_screen.dart
- Analytics: lib/widgets/attendance_panel.dart and module_dashboard_views.dart
- Primitives: lib/widgets/dashboard_primitives.dart
- Art: assets/material_pack/inbox/PulseVault/
- Tests: test/widget_test.dart

## Hard constraints
Preserve app ID com.badgym.bad_gym_member_intelligence. Flutter/Dart only. 360dp primary; verify 320/360/390dp and 560–800dp usable heights. No scroll/clipping/overflow at reference. Transparent art has real alpha and BoxFit.contain. Sample data remains Demo; no fake LIVE/partner claims. CI is not physical-device verification. Never print credentials or change signing secrets.

## Skills
Unslop is design audit workflow. Animmaster, Skiper and Vengeance are reference patterns; port to Flutter. Respect license/free/premium and attribution when copying source. No web runtime.

## Current feature checkpoint
- Main app auto-rotates Attendance → Workout → Payment → Body every three seconds. The progress strip below the KPI row fills left-to-right; no number.
- Center arrow collapses/expands the lower content. Collapse mode is a single simplified snapshot, expand mode restores the rail and detail panel.
- Manual card/menu taps remain available; reduced-motion and background app state suspend automatic cycling.
- Compact vertical row budgets target about 20dp saved net. Sponsored artwork uses finite entrance motion and slightly larger placements.
- Mandatory owner asset rule: read docs/ASSET_ORIGINALITY_AND_QUALITY_POLICY.md. Earlier derivative pack was repetitive copies, not unique artwork. The optimized folder was absent from live Git tree. The derivative generator and auto-commit workflow are withdrawn. Flutter will reference original PulseVault assets directly where suitable.
- Current implementation commits: timer/toggle ba8d4c7e36902d5f3f7447046fd942d15b718cde; ads/assets/tests ef65e9ed67ab4c8c4492052c16ea4d0615458348.
- Latest successful QA APK is Build #733 (artifact ID 15266626403; SHA-256 `f48548f08cf3e39867796bb0949ecb5cfa6bf29ea64858b2e1ee9e8f38be9b19`; 19,189,331 bytes). CI passed format/analyzer/widget tests/ARM64/signature/upload. Firebase Test Lab/App Distribution skipped for missing credentials. Physical device and screenshot diff remain pending.

## Resume checklist
1. Read docs/ASSET_ORIGINALITY_AND_QUALITY_POLICY.md before any art work; do not recreate the withdrawn derivative generator/optimized pack.
2. Install Build #733 QA APK on the actual Xiaomi 11i/owner target device and record launch/overflow behavior.
3. Capture the four dashboard states (Attendance, Workout, Payment, Body) at the 360dp target and run aligned screenshot overlay/diff against approved references.
4. Capture 320/390dp and actual short-height scenarios; fix only measured component-level gaps.
5. Record device model/OS/API/viewport, captures, exact commit and CI run before claiming pixel-perfect.

## Previous baseline
Build #717 on 1c3ca6cf06e2035d39122a40909b8335e5da9e65 passed format, analyzer, widget tests, ARM64 build, signature and artifact upload. Firebase Test Lab/App Distribution skipped due unavailable credentials. This is pre-Emerald baseline.


## Owner-mandated permanent project rule
No duplicate/near-duplicate asset packs. Never convert existing PulseVault artwork into small WebP copies and present it as unique art. New detailed images target an 8K-quality 7,680px-long-edge master; record actual native resolution and any genuine super-resolution method. Verify real alpha, subject bbox, margins, silhouette edges, crop and 100% detail over light/dark backgrounds. Store approved master and a downsampled 3× runtime derivative separately with parent SHA. No visual gap means no generation. Every new agent must read the policy and AGENTS.md.


## Latest verified build — 2026-11-28
- Commit: `f413dc9c34fe2976e91e46ada5d61f099f865d2a`.
- Build #733: SUCCESS — https://github.com/explorelearningvisit-boop/productionreadymembercard/actions/runs/46152936686
- Format, analyzer, widget suite, coverage upload, ARM64 APK, signature check and artifact upload all pass.
- APK artifact: `bad-gym-member-card-arm64-release`, ID `15266626403`, 19,189,331 bytes; SHA-256 `f48548f08cf3e39867796bb0949ecb5cfa6bf29ea64858b2e1ee9e8f38be9b19`.
- Verified native ARM64 libraries `libapp.so` and `libflutter.so` present.
- Test Lab/App Distribution skipped because Google/Firebase secrets are not configured.
- CI now has responsive tests for 320×560, 320×640, 360×600, 360×700, 390×720 and 800×600, plus 3-second rotation/progress/toggle and reduced-motion tests.
- Still not pixel-perfect certified: no physical Xiaomi 11i capture or aligned visual diff has been done in this checkpoint.
