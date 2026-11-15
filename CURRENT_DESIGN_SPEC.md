# BAD GYM — Current UI/UX Source of Truth
Last updated: 2026-11-15
Status: ACTIVE — this file supersedes older design descriptions in AGENTS.md, AI_SHARED_COMMUNICATION_HUB.md, screenshots notes, and prior AI session logs whenever they conflict.

## Current reference
The user-provided image in the 2026-11-15 conversation is the latest approved visual reference (1024x1536 portrait). Match its composition, hierarchy, proportions, visual treatment and red/gold/white palette. Do not revert to Royal Purple / Neon Violet: that was an older iteration and is obsolete.

## Design language
- Brand direction: bold BAD GYM red performance dashboard; premium glossy / glass-like highlights, bright white content surfaces where the reference uses them, deep crimson gradients, gold/yellow accents, clean typography and crisp high-contrast text.
- Core palette: primary strawberry red #E50914; deep crimson #76000D; burgundy #380008; warm white #FFF8F5; gold #FFDF00 / #FFB800; success green #16A34A. Purple is not a primary brand/theme colour.
- Top brand bar and Check-In Success hero: vivid red gradient, white branding, gold accents, athlete cutout and gym equipment illustration.
- Member profile / membership card: user has explicitly requested the complete card to be red-themed, including member identity, payment/renewal details, membership progress label and progress track. Use a crimson gradient outer card and coordinated red inner surfaces; white/light text; gold progress fill and percentage badge; green Active and gold Plan pills. Do not leave the overall member card white.
- Quick stats: preserve four distinct cards (Attendance, Workout, Payment, Body); selected Attendance uses red; inactive cards remain light/white with red iconography and readable text.
- Vertical navigation rail: deep burgundy/red body with bright red active item, white icons/labels and restrained red glow. No purple rail.
- Intelligence card: light pearl/white content surface as in reference, red section icon/selected accents, clear data visualisation, readable calendar and legend.
- Promotional banner: red/gold branded campaign artwork; avoid stretching/cropping text or faces.

## Content and layout rules
- Use the supplied reference's information architecture: brand header; check-in hero; member profile; payment and expiry; membership progress; four quick stats; vertical navigation plus intelligence panel; promotional banner.
- Member identity is data-driven. Do not hardcode a different person's name; current sample model may display Ashwani Kumar Singh. The user referred to the member card; use the data model name.
- Keep the layout mobile-first and verify at 360dp width and on Xiaomi 11i (1080x2400, Android 13) when a live device is available. Avoid horizontal overflow, clipped labels, tiny text, or duplicated metrics.
- Do not invent features or replace the user's information architecture. Improve spacing, contrast, accessibility, responsive behaviour and component consistency.
- Do not flatten UI text/charts into images. Use native Flutter widgets for labels, metrics, charts, buttons and calendar; raster art only for isolated illustrations.

## Asset policy
- Audit each asset for dimensions, file size, alpha channel, crop and actual usage before declaring it production-ready.
- Keep transparent isolated illustrations as PNG/WebP with verified alpha. Do not use sprite sheets, contact sheets, or intermediate extraction files as final individual assets.
- Do not regenerate assets merely because a folder contains test exports. First inspect what the app actually references and whether existing art is valid.
- Record asset source/license and purpose in assets/README.md.

## AI collaboration protocol
1. Read this file first before any UI/UX change.
2. This file is the single current design authority. Older purple-theme notes are historical only and must not be treated as active requirements.
3. If the user changes the reference or palette, update this file and AI_SYNC_STATE.json in the same change.
4. After changes, run dart format, flutter analyze, flutter test and release APK build in GitHub Actions.
5. Device installation, screenshot and logcat are only VERIFIED when a current workflow run reports success and its artifacts contain the actual fresh capture. Do not copy old screenshots and label them live.
6. Never put private ADB keys, Tailscale auth keys, OAuth secrets or tokens in Git files or chat. Use encrypted GitHub Actions secrets.
7. Tailscale IP is private; Android Wireless Debugging TCP port is dynamic. Never assume port 5555 or reuse a stale port. Discover/update the port after checking the phone. Tailscale reachability does not imply ADB pairing/authorization.
8. Report build, test, device-connectivity and screenshot status separately; distinguish verified facts from pending setup.
