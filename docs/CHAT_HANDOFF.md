# BAD GYM — Cross-chat handoff

Updated: 2026-11-25

## Repository
- https://github.com/explorelearningvisit-boop/productionreadymembercard
- Branch: `grok/purple-neon-member-dashboard`

## Current visual authority
The owner's 2026-11-25 uploaded purple-neon screenshot and `docs/BADGYM_FINAL_APPROVED_DASHBOARD_MASTER_PROMPT.md`.
The new full compact dashboard scope supersedes the earlier minimal-card-only prompt.

## Reference assets
- Authoritative 14-image source pack: `reference_library/recovered_from_history/assets/material_pack/pulsevault/`
- 30-file mobile-optimized WebP pack: `reference_library/recovered_from_history/assets/material_pack/inbox/`
- Recovered historical files: `reference_library/recovered_from_history/`
- Reference-only screenshots must never be used as runtime backgrounds.
- Only selected optimized WebP cutouts are registered in pubspec.

## Current UI
One compact fixed card: check-in/freeze, member identity, payment/promo, membership progress, four metrics, attendance analytics and mini calendar. No app-level top/bottom menu or left/right rail.

## Hard constraints
- 360 dp primary; verify 320/390 dp.
- No vertical/horizontal scrolling, clipping or overflow.
- Fit into bounded host dashboard area.
- Flutter SDK only; no extra runtime packages.
- Keep app ID: com.badgym.bad_gym_member_intelligence.
- Demo data label until API exists.
- QA APK ARM64 release; don't claim real-device verification without evidence.

## Last known history
The earlier minimal version was 15 MB on build #389, but the owner's new reference request now expands the dashboard. Rebuild and report the actual new APK size; do not reuse the previous APK link.
