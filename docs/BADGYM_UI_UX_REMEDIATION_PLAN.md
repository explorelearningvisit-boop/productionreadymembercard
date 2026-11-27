# BAD GYM — UI/UX and production remediation

## Owner constraints

- The uploaded 691 × 1536 screenshot is the visual reference for the default Gold member view.
- Primary viewport: 360 dp wide and 600–700 dp usable height; regression widths include 320 dp and 390 dp.
- Keep member data more prominent than advertising. Ads retain campaign colours and must not compete with payment status or KPI values.
- Gold is metallic gold/amber, Silver is steel/silver, Diamond is ice-blue and Spark is emerald. This latest plan-tier instruction supersedes older purple-shell and Emerald-only drafts.
- Keep Tailscale pending. Do not add Firebase or invent backend credentials.

## Implemented in the current UI branch

- [x] Distinct Gold, Silver, Diamond and Spark member palettes.
- [x] Four KPI modules share state with the six-item contextual rail.
- [x] Increased rail icon/label, KPI and payment typography; removed the decorative portrait backplate.
- [x] Product assets stay inside their campaign/member surfaces and preserve their aspect ratio.
- [x] Whey campaign opens an honest preview sheet rather than pretending a purchase is live.
- [x] This batch fixes a compile/analyzer error in the payment card's palette references.
- [x] This batch adds module/detail fade-slide transitions, pointer hover/focus feedback, touch press response and reduced-motion handling.
- [x] This batch adds finite, restrained 3D perspective tilt for product artwork; no continuous bottle spin.
- [x] Freeze and check-in actions are labelled as local previews rather than server transactions.
- [x] This batch expands regression coverage for campaign preview actions, hover behaviour and reduced motion.

## Validation evidence

- Baseline commit 2c048b010aaee3593df20240a38e75216407fcff triggered Android Build #654.
- flutter pub get and Dart formatting passed on that baseline.
- flutter analyze failed at lib/screens/member_dashboard_screen.dart:751 because a const LinearGradient referenced non-constant, out-of-scope palette values. Widget tests and APK build were skipped.
- The correction and new tests in this batch require a fresh CI run; no passing result is claimed until GitHub Actions reports it.

## Still required before production

1. Run and pass formatter, analyzer, all widget tests and ARM64 APK verification on the new commit.
2. Capture the exact APK on the target Xiaomi 11i (or same-density Android device), then create an overlay/pixel-difference report against the owner screenshot. CI widget tests cannot certify pixel-perfect device rendering.
3. Replace MemberSample.demo with authenticated, gym-scoped repository data. The current repository has no live backend connection.
4. Implement and test server-authoritative attendance/check-in, membership freeze, payment, workout and body-history actions. Local previews are not production transactions.
5. Connect campaign/product destinations and consent-aware analytics only after real provider configuration is supplied.
6. Configure a private production upload keystore through protected CI secrets. The current release-mode APK uses the Android debug key and is QA-only.
7. Validate auth expiry, network failures, offline cache, loading/empty/error states, accessibility and real-device performance.

## Release decision

Keep PR #12 open and Draft. Do not merge or publish while any production gate above is open. A successful ARM64 QA APK is not a Play Store production release.
