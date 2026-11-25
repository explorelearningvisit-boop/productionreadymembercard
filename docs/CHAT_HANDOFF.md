# BAD GYM — Cross-chat handoff

Updated: 2026-11-25

## Repository
- https://github.com/explorelearningvisit-boop/productionreadymembercard
- Branch: `grok/purple-neon-member-dashboard`
- Current scope: `docs/BADGYM_FINAL_APPROVED_DASHBOARD_MASTER_PROMPT.md`

## Current product request
The owner rejected the oversized 170+ MB dashboard app and supplied a screenshot showing a Flutter framework runtime assertion:
`framework.dart: Failed assertion: line 2175 pos 12: _elements.contains(element)`.

Rebuild scope is now deliberately minimal: one member card, one check-in action and essential data only. Keep name/ID/age/gender, plan/status, membership progress, check-in state/time, attendance, workout, body weight and payment due. Label the values as demo data until the real API exists.

## Explicitly remove
Ads, promotions, shopping offers, QR, analytics rail, charts, calendar, product illustrations, custom fonts, animation systems, QR plugin and unrelated asset packs.

## Code/build requirements
- Flutter and Android boilerplate retained; preserve applicationId.
- No runtime third-party packages.
- No GlobalKeys, Hero transitions, overlays, modal sheets/routes, snackbars, nested scroll or animation controller in the simple card tree.
- Test at 320, 360 and 390 dp and repeat mount/dispose lifecycle.
- Release QA APK: ARM64 only, release mode, signed using development key for sideload. Not Play Store signing.
- Run format, analyze, widget tests, build and apksigner verification in CI.
- Confirm exact APK size and SHA-256 from the artifact.

## Latest previous build (before simplification)
Build #371, commit `e58175f23f9e07a8db3c458a1635a667e78233ee`, passed the then-current universal debug workflow. Its APK artifact was approximately 168 MiB and was not accepted by the owner; the screenshot demonstrates the runtime assertion on-device.

## Status after current simplification work
Update this section only after current CI has completed. Real-device install/launch remains unverified until there is direct evidence.

## Continuation
Read this handoff and the minimal master prompt first. Continue only the minimal card. Do not restore old dashboard modules or assets without explicit product request.
