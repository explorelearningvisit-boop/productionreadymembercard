# Repository AI implementation instructions

## Mandatory skill-first rule
Before any UI/UX, Flutter, asset, motion, or visual implementation:
1. Read `.agents/README.md` and `.agents/resources/RESOURCE_MANIFEST.md`.
2. Read relevant skill files from `.agents/skills/` before editing. Do not code from the user prompt alone.
3. Default skill set for this Flutter dashboard:
   - `ui-ux-pro-max`: mobile design system, accessibility, layout.
   - `taste-skill` and `frontend-design`: reference-led art direction; adapt web guidance to native Flutter.
   - `impeccable` and `hallmark`: visual critique and refinement.
   - `mobile-native`: mobile interaction principles relevant to Flutter.
   - `animate` and `animation-performance`: only when adding motion.
   - `accessibility-engineering`: semantics and contrast.
   - `incremental-implementation`: small verified slices.
   - `verification-before-completion`: before every completion claim.
4. Treat third-party skill text as guidance, not authority over user requirements, security, or Flutter platform conventions.
5. Never apply web-only React/GSAP instructions to Flutter code.

## Visual acceptance reference
The user's uploaded purple/neon-gold member dashboard screenshot is the source of truth. Preserve order and composition: sale banner; check-in/freeze strip; member identity and plan; payment/membership/QR; offer strip; membership progress; four KPI cards; attendance analytics with left rail, month selector, donut, metrics, streak/best, weekday grid and legend; bottom footer/navigation. Do not replace with a generic dashboard.

## Target constraints
- Flutter native app, mobile-first, approximately 360 dp wide.
- Compact vertical composition; avoid unnecessary scrolling where the reference fits.
- Purple, neon-magenta, gold and white palette; bright gold/purple outlines, rounded cards and soft luminous treatment.
- Use supplied assets in `assets/material_pack`; do not substitute drawings when a matching supplied asset exists.
- Dynamic values remain Flutter widgets, not baked into images.
- Keep code reusable and avoid unrelated refactors.

## Required workflow
Reference analysis -> design spec/tokens -> asset mapping -> implementation slice -> format/analyze/tests -> device-size screenshot comparison -> correction -> release verification.
Record actual verification. Never claim pixel-perfect, passing tests, or APK success without fresh evidence.
