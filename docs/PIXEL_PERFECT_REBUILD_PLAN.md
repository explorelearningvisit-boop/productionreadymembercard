# BAD GYM — Purple Neon Dashboard implementation plan

## Authority
Follow `BADGYM_FINAL_APPROVED_DASHBOARD_MASTER_PROMPT.md` and the owner's 2026-11-25 screenshot. This full compact dashboard request supersedes the earlier minimal-card-only scope.

## Components in order
1. Check-in / Freeze header row
2. Member identity and plan status
3. Payment due / whey promotion
4. Membership progress
5. Four compact metric tiles
6. Attendance analytics, partner promotion, ring + legend, streaks, recovery promotion and mini calendar
7. Six-item vertical navigation rail: Attend, Insights, Cal, History, Trend and Goals

## Exclusions
No additional app-level top/bottom menus, scroll views, multiple screens, backend/API, unrelated modules, third-party runtime packages, custom fonts or full-screen screenshot background. The six-item rail in the supplied reference is required.

## Layout QA
360 dp target; test 320 dp and 390 dp widths and compact heights. The card must scale to its bounded parent area, show all components at once and have no scroll, clipping or RenderFlex overflow.

## Asset policy
Source pack: `reference_library/recovered_from_history/assets/material_pack/pulsevault/` (14 original PNGs).
For runtime use, select only optimized transparent WebP files from the recovered material pack and register only those selected files in pubspec.yaml. Use BoxFit.contain.

## Verification
Format, analyze, widget tests, no-scroll/overflow checks, Android emulator launch, ARM64 release APK, signature and size report. Real-device install/launch remains a separate check.
