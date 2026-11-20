# BAD GYM Green Glass Reference — Implementation Plan

## Source of truth
The uploaded 864 × 1536 portrait dashboard reference is the visual authority for this branch. Preserve its information architecture and labels; do not invent new dashboard sections.

## Locked content and hierarchy
1. BAD GYM brand mark and Fitness Management System subtitle.
2. Check-in completed time, Freeze action, notification bell.
3. Member portrait, welcome line, member name, ID, age, gender.
4. Gold Plan and Active status.
5. Payment due, expiry countdown/date, QR.
6. Membership 22 / 30 days and 73% progress.
7. BAD GYM Big Billion Sale fitness-gear promotional banner.
8. Four compact metric tiles: Attendance 81%, Workout 58 min, Payment ₹500 Due, Body 69.5 kg.
9. Attendance Intelligence panel with exactly six vertical destinations: Home, Attend, Workout, Pay, Offers, History.
10. Home overview: check-in time, 81% donut, 25 Present / 2 Absent / 4 Holiday / 1/1 Payment with percentages and bars; bottom insights 5d, 14d, +6%.

No separate Workout Intelligence, Body Progress, Pre-plan, or Training Package sections are to be added. Workout and Body remain only in the original four metric tiles and the existing vertical navigation.

## Visual tokens extracted from the reference
- Main environment: bright ice-cyan / pale aqua glass with a clean gym interior.
- Primary accents: vivid neon green and emerald.
- Secondary accents: violet for Workout, warm red/coral for Payment, cyan/teal for Body.
- Gold/yellow for Gold Plan and sale call-to-action.
- Surfaces: translucent white / frosted glass, bright white edge highlights, soft teal shadows.
- Cards: large rounded corners, glossy gradients, layered elevation.
- Typography: bold condensed-looking display hierarchy for headings, highly legible sans-serif for data; avoid ornamental fonts for dense metrics.
- Icons: simple high-contrast line/solid fitness symbols, consistent stroke weight.

## Implementation phases
1. Reference audit and locked information architecture.
2. Theme tokens and reusable glass surface primitives.
3. Asset pack: member portrait, BAD GYM banner art, gym background, icons; use transparent PNG/WebP for raster illustrations and SVG for scalable symbols.
4. Profile / check-in / payment / QR / membership header.
5. Promotional banner and four metric cards.
6. Attendance Intelligence shell and vertical rail.
7. Attendance donut, legend bars, and three insight values.
8. 360dp layout, overflow and accessibility pass.
9. Animation and interaction polish.
10. Screenshot comparison, tests, and release APK.

## Asset policy
Do not place a full screenshot as a fake interactive screen. Use cropped/transparent individual artwork only where it does not duplicate UI text or block interactions. Keep all data labels and controls native Flutter widgets.
