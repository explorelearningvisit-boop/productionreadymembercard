# BAD GYM — Minimal Member Intelligence Card

**Status:** Current product scope, approved by the product owner on 2026-11-25.

## Objective
Keep one simple Android member card for the gym check-in flow. This is not a multi-page gym app or a marketing dashboard.

## Card contents
1. Member identity: name, member ID, age and gender.
2. Membership: plan, active status, days used / total days, remaining days and progress.
3. Check-in: one Check In action; after tapping, show checked-in state and time. No modal, route, bottom sheet or snackbar.
4. Essential member indicators: attendance percentage, workout duration, body weight and payment due.
5. Clear sample-data notice until the real gym API is connected.

## Visual direction
- Mobile-first, 360 dp target; test 320 dp and 390 dp.
- One compact card, clean spacing, purple and gold BAD GYM identity.
- Native Flutter text and containers; initial avatar letters are acceptable.
- Readable typography and accessible check-in action.
- No unnecessary page scrolling; avoid overflow on short phones.

## Explicitly out of scope
Advertisements, product promotions, shopping, offer carousels, QR, analytics navigation rail, calendar, chart dashboard, workout plans, multiple screens, decorative illustrations, custom fonts, elaborate animations, and third-party runtime packages.

## Engineering rules
- Keep the existing Flutter app and Android application ID.
- Prefer Flutter SDK only.
- Preserve Android launcher resources and required Gradle/manifest files.
- Use one simple widget tree without GlobalKeys, hero transitions, overlays, modal routes, nested scrolling or animation controllers.
- Build a signed ARM64 release QA APK for the owner's Android phone. QA signing is not Play Store signing.
- Verify widget rendering and lifecycle at 320/360/390 dp; report CI verification separately from real-device verification.
