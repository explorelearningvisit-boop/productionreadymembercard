# BAD GYM — Approved Reference Visual Specification

## Source
- User-uploaded image: `1000320298.png`
- Native dimensions: 691 × 1536 px
- Color mode: RGB
- SHA-256: `694278b5a4c8aa76a4a3306bfe978f36d9aaaef897495965d31170785d4e59c6`
- Status: authoritative visual reference for the current reconstruction.

## Visual language
- Primary canvas: deep crimson / burgundy red with layered red gradients and subtle luminous highlights.
- Primary accent: saturated warm gold/yellow, used for double borders, outlines, badges, membership progress, and selected states.
- Surfaces: warm white / ivory glass panels with soft shadows, glossy bevels and thin gold/red edge treatments.
- Text: strong near-black on white cards; white on red header/promotional surfaces; red for due/payment emphasis.
- Semantic states: green = present/active/checked-in; yellow = late/attention; red = absent/due; purple = holiday.
- Typography should be modestly larger than the current build while retaining the same hierarchy and fitting 360dp width.

## Reference composition and approximate source-image bounds
Coordinates are in original 691 × 1536 screenshot pixels, not dp. They are measurement guides, not hard-coded Flutter offsets.

| Region | Approximate bounds | Required content |
|---|---:|---|
| Android status bar | y 0–47 | System status icons/time; not part of app layout |
| Brand header | x 15–679, y 48–141 | Dumbbell logo, BAD GYM wordmark, Member Intelligence, search, notification badge, QR action |
| Member pass | x 9–682, y 142–489 | Avatar, checked-in state/time, member name and ID, age/gender, QR, Active and Gold Plan, Payment Due, expiry, membership days/progress |
| Amazon banner | x 13–679, y 497–620 | Sponsored Amazon Great Indian Festival banner, discount message and weights art |
| KPI row | x 10–683, y 627–755 | Attendance, Workout, Payment, Body; distinct colored glass cards |
| Intelligence workspace | x 10–682, y 764–1260 | Left rail, Attendance Intelligence title/month, 81% ring, status counts and percentages, weekday labels, monthly date pills, streak/best strip |
| Protein Burger banner | x 10–681, y 1264–1457 | Fitness Nutrition label, Protein Burger artwork, 50% OFF, Order Now |
| Android navigation bar | y 1458–1535 | System navigation; not part of app layout |

## Calendar requirements
- October 2026, Monday-first seven-column calendar.
- Day chips are rounded horizontal capsules, not circular dots.
- Present = green; Late = yellow; Absent = red; Holiday = purple; unrecorded days = pale neutral.
- Sundays are not automatically forced to OFF. Their appearance follows the actual attendance status. In this reference Sundays 4, 11, 18 and 25 are purple holiday entries.
- Summary list shows count and percentage: Present 23 / 81%, Late 2 / 7%, Absent 2 / 7%, Holiday 4 / 13%.
- Ring: 81%, 25 / 31 Days.
- Footer: Streak 5 Days and Best 14 Days.

## Native vs raster boundary
Keep native Flutter:
- all typography, numbers, icons, status pills, buttons, card borders, progress bars, charts, QR, calendar grid, rail labels, KPI data and month selector.
Use raster art only for:
- member portrait / isolated photographic subject
- Amazon banner composite artwork if using the source crop
- Protein Burger banner composite artwork if using the source crop
- any separately isolated complex decorative illustration that has been validated.

## Extracted source assets
The companion asset pack contains:
- `reference_full_691x1536.png` — original screenshot copy.
- `member_portrait_cutout_3x.png` — first-pass GrabCut portrait, RGBA, 336×489.
- `sponsored_amazon_banner.png` — original banner crop, RGB, 666×123.
- `protein_burger_banner.png` — original banner crop, RGB, 671×193.
- `asset_manifest.json` — dimensions, alpha, byte size, hashes and processing notes.

The portrait extraction is a first-pass segmentation and must be reviewed for hair/shoulder edge halos before production integration. Banner crops intentionally retain their full backgrounds; transparency is not appropriate for a composite banner whose background and text are part of the design.

## Current code alignment updates
- Attendance calendar now respects recorded Sunday holiday status instead of forcing every Sunday to OFF.
- Date chips changed from circles to rounded horizontal capsules.
- Attendance summary now presents count and percentage rather than mini progress bars.
- Selected text sizes increased modestly.
- Full-device screenshot comparison is still required before pixel-match acceptance.
