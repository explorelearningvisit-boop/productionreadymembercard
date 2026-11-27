# BAD GYM — Final Gold Reference / Emerald + Wine Rail Implementation Spec

**Design authority:** The owner's FIRST uploaded screenshot in the current reference pair is the final layout and information hierarchy. The SECOND screenshot is a colour-only supporting reference for the deep red/wine vertical rail and warm-gold active item. Do not replace the first screenshot's content or section order with the second screenshot's red full-screen layout.

## Five-line design direction

- **Product:** A compact gym-member dashboard for check-in, plan/payment status, attendance, workouts, body data and goals.
- **Character:** Athletic, assured, warm, precise.
- **World:** A premium training club with forest-emerald controls, champagne metal, pearl-white glass and a deep wine navigation rail.
- **Moments:** Member identity and check-in/Freeze actions; four colour-coded KPI/product cards; a pearl-white analytics workspace with charts and calendar.
- **Signature:** Champagne outer rim + emerald action + wine rail + gold selected rail tile.

## Palette authority

| UI region | Gold plan treatment | Source |
|---|---|---|
| Outer shell / Check-in | Forest emerald with restrained tonal shift | First screenshot |
| Outer rim | Champagne / antique gold | First screenshot |
| Freeze | Pearl white with warm neutral hairline; purple snowflake artwork is kept only as supplied product art | First screenshot |
| Member identity | Pearl white, gold portrait plate and plan badge, emerald Active badge | First screenshot |
| Vertical rail | Deep wine-red `#6D0201` to `#3A080D` | Second screenshot, rail only |
| Selected rail item | Warm champagne gold `#FDE870` | Second screenshot, active item only |
| Main data workspace | Warm pearl white `#FFFEFC` / `#F9F7F2` | First screenshot |
| KPI cards | Attendance warm yellow, Workout lavender, Payment sky, Body mint | First screenshot |
| Semantic attendance | Present green, Absent rose, Holiday violet, Late amber | First screenshot |

Other member plans keep the same information hierarchy but receive their own plan-derived shell palettes. Spark remains forest/emerald. Silver remains slate/steel-blue. The Wine + Champagne treatment is a Gold-plan navigation variation, not a universal red background.

## Layout — preserve the first reference

Preserve the first reference's section order and information:
1. Check-in and Freeze row.
2. Member portrait, name, ID, age, gender, plan and Active state.
3. Payment due + Whey Protein offer.
4. Membership used / total, days remaining and progress.
5. Four horizontal KPI cards: Attendance, Workout, Payment, Body.
6. Lower workspace with a vertical contextual rail and one large pearl-white data panel.
7. Within Attendance: status ring and legend, streak/best/month trend, campaign strips and the monthly calendar.

The dashboard remains mobile-first, primarily 360 dp wide, and no unnecessary vertical scrolling. Recover space from redundant gaps, padding and labels before shrinking numbers or artwork. Keep key figures and campaign art undistorted.

## Contextual navigation contract

Horizontal cards select a primary module. The vertical rail then displays exactly five destinations relevant to that module:

| Horizontal module | Five vertical destinations |
|---|---|
| Attendance | Overview, Calendar, History, Insights, Goals |
| Workout | Overview, Workout Log, Trend, Recovery, Goals |
| Payment | Overview, Invoices, History, Methods, Rewards |
| Body | Overview, Weight, Measures, Nutrition, Goals |

One shared selected state drives the KPI highlight, rail list, selected rail item and detail workspace. A Payment submenu must never appear under Attendance. Each destination has its own relevant view and heading. A selected visual state without a working destination is a defect.

## Surfaces and Unslop rules

- The data workspace is pearl white / warm white with quiet hairline borders and small neutral shadows.
- Use rich colour in the KPI card fills, meaningful chart series, product artwork, plan badge and active nav state; do not tint the whole analytics surface.
- Avoid purple radial glows, broad blurred washes, neon borders, colored outer shadows, gradient text and gratuitous blur.
- Use one neutral shadow scale and one border family. Keep nested radii consistent.
- Use the Flutter Material icon font and one coherent icon language. No missing-glyph boxes, cross placeholders or emoji icons.
- Use sentence-case UI labels, a few type sizes and weights up to 600. Keep member name, key metrics, payment amount and calendar dates readable.
- Motion is finite and purposeful: short one-shot artwork entrance and brief menu-content transition. No periodic timers, flashing, pulse loops or movement when a screen is idle.

## PulseVault asset contract

Canonical runtime folder: `assets/material_pack/inbox/PulseVault/`.

The directory contains the original 16 approved member-card assets (including bodybuilder, whey, shaker, grocery, creatine, Gold/Active badge plates, Freeze snowflake, calendar, dumbbell, ProteinX, SBI and fat-loss artwork). Original source copies in `assets/member_card/` remain retained until a later verified cleanup.

Use transparent artwork with `BoxFit.contain`. Never bake member names, data, button labels, prices or advertiser claims into image assets. Use native Flutter text for these. Advert creative, offer copy and CTA must remain one matched campaign; no unrelated randomized artwork. Until a real advertiser is configured, all offer inventory remains labelled Demo/Sample.

## Data truth

- Sample member: Ashwani Kumar Singh / BG215 / 28 yrs / Male / Gold Plan.
- Sample values remain sample data: ₹500 due, 22/30 membership days, 81% attendance, 58 min workout, 69.5 kg.
- Do not invent invoice numbers, completed transactions, exact body measurements, advertiser contracts or LIVE status.
- Where a category has no source data, clearly state that records are not connected or not loaded.

## QA gates

1. `flutter pub get`
2. `dart format --output=none --set-exit-if-changed lib test`
3. `flutter analyze`
4. `flutter test --reporter expanded`
5. ARM64 release build and APK signature verification.
6. Test 320×560, 320×640, 360×600, 360×700, 390×720 and 800×600 without overflow or unnecessary scrolling.
7. Verify all runtime PulseVault image references are declared in `pubspec.yaml`.
8. Passing CI is not proof of pixel-perfect device rendering. Report a fresh 360 dp screenshot comparison separately.

## Skill attribution

This project uses Unslop by Damir Sokolovsky, loaded from `.agents/skills/unslop/`. Its design rules are applied as adapted to Flutter and Android. Unslop is licensed CC BY 4.0; retain attribution in copies and adaptations.
