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
- Nine true-alpha WebP derivatives are generated into PulseVault/optimized. The asset-generation workflow commits verified binary outputs; Android CI regenerates and audits before asset bundling.
- Current implementation commits: timer/toggle ba8d4c7e36902d5f3f7447046fd942d15b718cde; ads/assets/tests ef65e9ed67ab4c8c4492052c16ea4d0615458348.
- New APK and image-diff evidence are pending CI; do not reuse Build #720 APK as the latest version.

## Resume checklist
1. Verify GitHub asset workflow generated and committed PulseVault/optimized.
2. Inspect optimized alpha/dimension audit.
3. Inspect current Android CI format/analyzer/widget/ARM64/signature/artifact.
4. Then capture 320/360/390dp and compare with screenshot overlay/diff.
5. Record exact build+commit here before claiming completion.

## Previous baseline
Build #717 on 1c3ca6cf06e2035d39122a40909b8335e5da9e65 passed format, analyzer, widget tests, ARM64 build, signature and artifact upload. Firebase Test Lab/App Distribution skipped due unavailable credentials. This is pre-Emerald baseline.
