# BAD GYM — Pearl Glass / Purple Neon Member Intelligence Dashboard

**Status:** Updated 2026-11-27 from the owner's second reference screenshot. The target is a bright pearl-glass content field framed by purple neon and gold—not a full-screen purple surface. The detailed tokens and component treatments are in `docs/REFERENCE_GLASS_VISUAL_SPEC.md`. This document supersedes the 2026-11-25 visual direction where they conflict.

## Product boundary
One compact Android member dashboard card for the gym check-in flow. The app's own top menu, bottom navigation and Android system navigation are outside this component and must not be implemented here. The supplied full screenshot includes a six-item vertical navigation rail (Attend, Insights, Cal, History, Trend, Goals); reproduce it inside this dashboard.

## Master visual reference
Use the owner's uploaded purple neon / gold dashboard screenshot. Reproduce its component order, color language, dense card hierarchy, glow, rounded outlines and asset placements. Do not invent a different visual direction.

## Component order
1. Top row: Check-in action/status and Freeze promo.
2. Member identity: portrait/bodybuilder graphic, name, member ID, age, gender, Gold Plan and Active status.
3. Payment and promo row: amount due / days left, whey promotion.
4. Membership progress: days used / total, days remaining, percentage and progress track.
5. Four compact metric tiles: attendance, workout duration, payment, body weight.
6. Attendance analytics: title/live status, partner banner, attendance ring, present/absent/holiday/late legend and bars, streak stats, recovery offer, month label, weekday row and compact calendar.
7. Six-item vertical navigation rail: Attend, Insights, Cal, History, Trend and Goals. Match the reference position, width, active-state treatment and icon/label spacing.

## Layout constraints
- Mobile-first; 360 dp is the primary target. Verify 320 dp and 390 dp.
- Compact, fixed card layout; no vertical scrolling, no horizontal scrolling, no clipping or overflow.
- Must fit inside the bounded area supplied by the host dashboard; scale proportionally when the available area is smaller.
- Reproduce the six-item vertical navigation rail visible in the supplied reference. Do not add any additional app-level top menu or bottom menu.
- Keep all important labels legible at the smallest supported size.

## Asset authority
The authoritative 14-image source pack is:
`reference_library/recovered_from_history/assets/material_pack/pulsevault/`
Read its README before choosing assets. Do not use the full-screen screenshot as a runtime background. Prefer the already optimized transparent WebP assets from:
`reference_library/recovered_from_history/assets/material_pack/inbox/`
and sibling categorized folders. Use BoxFit.contain for transparent cutouts and preserve their aspect ratio. Keep all labels, amounts, dates and controls as live Flutter widgets.

## Data
Current demo member: Ashwani Kumar Singh, BG215, 28 yrs, Male, Gold Plan, Active; 22/30 membership days, 8 days left, ₹500 due; attendance 81%, workout 58 min, body weight 69.5 kg. Clearly mark sample data until a real gym API is connected.

## Engineering rules
- Keep the existing Flutter app and Android application ID.
- Flutter SDK only; no new runtime packages.
- No nested scrolling, GlobalKeys, Hero transitions, overlays, modal routes, snackbars or animation controllers.
- Use a single stable widget tree; check-in state is local and must not create routes or overlays.
- Keep reference archive outside pubspec assets. Only register the selected optimized runtime assets.
- Build a signed ARM64 QA APK and verify format, analysis, widget tests, emulator launch, APK signature and exact size. Real-device verification must be reported separately.
