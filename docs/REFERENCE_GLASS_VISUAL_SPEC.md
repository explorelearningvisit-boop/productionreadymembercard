# BAD GYM — Pearl Glass / Purple Neon Dashboard Specification

**Visual authority:** Owner's second uploaded reference screenshot (2026-11-27). The first screenshot is the implementation under review, not the design authority.

## Art direction

Build a premium mobile gym dashboard with layered materials and distinct semantic color zones. Purple is a brand frame/accent, not a full-screen fill. Avoid the generic single-purple AI-template appearance. The interface should combine pearl glass, pale lavender transparency, selective neon purple, warm gold, emerald, cyan, red and mint.

The reference screenshot itself must never be placed behind the UI. All dynamic labels, amounts, status, dates, values and controls remain native Flutter widgets.

## Color and material tokens

| Token | Value | Use |
|---|---|---|
| Page lavender | `#E9D8FF` | Outside the outer frame |
| Frame grape | `#270044` | Outer shell |
| Frame violet | `#6410B5` | Outer frame highlight and rail |
| Accent purple | `#6B12C9` | Buttons, progress, selected controls |
| Ink plum | `#220B3B` | Text on light surfaces |
| Pearl | `#FFFCFF` | Main glass panel |
| Lilac glass | `#F8F2FF` | Cards / inner canvas |
| Glass edge | `#DCC5F3` | Fine lilac strokes |
| Gold | `#FFD34E` | Frame rim, portrait backplate, plan pill |
| Emerald | `#12D56A` | Active / present |
| Rose | `#E52B52` | Payment alert / absence |
| Cyan | `#D9F1FF` | Payment KPI tile |
| Mint | `#D8FFE2` | Body KPI tile |

Material treatment:
- Outer shell: grape-to-violet gradient, gold 1.5–2 dp inner rim, fine lavender highlight and controlled violet/pink bloom outside the edge.
- Inner canvas: pearl-to-pale-lilac gradient with a few very low-opacity radial light blooms. It must stay bright behind all content.
- Glass surfaces: translucent pearl/lilac gradients, 1–1.5 dp light-violet border, small white highlight, soft shadow tinted to the card's accent. No heavy purple shadow under every element.
- Product cutouts: preserve transparent edges and original aspect ratio using `BoxFit.contain`; never stretch or hard-crop them.

## Component-by-component treatment

1. **Check-in and Freeze**
   - Check-in is a deep grape / electric-violet glossy action with white text, emerald check disc, the bodybuilder cutout to the far edge and a localized purple-pink glow.
   - Freeze is a separate icy-white / blue-lilac glass action with purple snowflake artwork, dark-plum text and the shaker cutout at the far edge. It must not become a second purple card.

2. **Member identity**
   - Pearl-white glass panel with a warm gold edge.
   - Portrait on a yellow/gold backplate with subtle diagonal light; transparent member cutout contained and bottom-aligned.
   - Member name is dark plum, heavy rounded sans-serif; metadata is purple/plum semibold.
   - Gold Plan pill uses gold gradient and dark text. Active pill uses emerald gradient and white text. Both have a fine white keyline and restrained glow.

3. **Payment due and offer**
   - Payment card is pale pearl/blush glass, not a solid red block. Wallet icon sits on a small lavender tile; label is dark plum; amount uses rose/purple alert emphasis; days-left is muted plum.
   - Whey promo uses a lilac glass surface. Product cutout, dark-purple product name, prominent purple discount and compact pink/violet CTA remain distinct.

4. **Membership**
   - Pale lilac glass panel and dark-plum copy.
   - Days-left warning is a compact rose capsule. Percentage uses brand purple.
   - Progress track is pale lavender with a glossy purple gradient fill. Do not use the attendance green as its fill.

5. **Four KPI tiles**
   - Attendance = warm yellow; Workout = lavender; Payment = sky-blue; Body = mint. Each tile has its own subtle tonal gradient and edge/shadow, not one shared purple glow.
   - Labels and values are native text. Use large, contained PulseVault WebP product/person artwork in the centre.
   - CTA strips use their own semantic accents: protein red, creatine magenta, SBI blue, fat-loss green. Trend chips remain translucent and compact.

6. **Attendance analytics**
   - A large frosted pearl/lilac panel with a soft violet keyline and bright internal surface.
   - Header and partner banner sit at the top. Keep DEMO status visible until a real API feeds live data; never label sample data LIVE.
   - Attendance ring is segmented by Present (emerald), Absent (rose), Holiday (violet) and Late (amber), with 81% and 25/31 centered.
   - Legend uses matching colored dots and progress bars, with readable counts and percentages.
   - Streak / best / monthly trend stats sit on a subtle divider. Recovery offer is a separate lilac promo strip.
   - Calendar heading, count summary, weekdays and rounded day cells must be legible. Present = pale mint, absent = pale rose, late = pale amber, off/holiday = cool grey; selected day has a violet outline.

7. **Navigation rail**
   - Keep the six approved destinations: Attend, Insights, Cal, History, Trend, Goals.
   - Rail remains deep grape-purple with gold outer edge. Selected destination gets a warm-yellow glass tile; inactive icons/labels remain white.

## Typography

- Use the existing Flutter/system sans-serif stack; do not add a font dependency.
- Member name and major section headings: 20–22 sp normal scale, weight 800–900.
- KPI values: 18–22 sp normal scale, weight 900.
- Supporting labels: 10–12 sp normal scale, weight 600–800.
- Dense metadata / CTA labels: 8–10 sp only where necessary; keep them high contrast.
- Keep line height tight on compact labels, but do not shrink primary names, values or calendar dates to fit.

## Layout and responsive contract

- Primary design width is 360 dp. Verify 320 and 390 dp as well as 600–800 dp heights.
- Preserve the fixed no-scroll composition and the 6-destination in-card rail.
- Preserve section order: action row, identity, payment+offer, membership progress, four KPI cards, attendance analytics.
- Keep the analytics panel using the space left by the header instead of leaving dead space.
- No clipped labels, distorted images, off-screen controls, nested scroll views or RenderFlex overflows.

## Asset authority

Use the PulseVault assets already in the repository. Prefer optimized `assets/member_card/*.webp` variants where they exist: bodybuilder, whey, shaker, creatine, Blinkit, SBI, freeze snowflake and calendar. Use transparent PNG only when no optimized WebP equivalent exists. Keep asset registration explicit in `pubspec.yaml`; never use the full-screen screenshot as a runtime image.

## Data / behavior

Retain demo member Ashwani Kumar Singh, BG215, 28 yrs, Male, Gold Plan, Active, 22/30 membership days, ₹500 due, 81% attendance, 58 min workout and 69.5 kg. Continue to mark sample analytics as DEMO / sample data until a real API is connected. Keep the check-in interaction local and safe; do not invent backend behavior.

## QA gates

Run format, static analysis, all widget tests, compact viewport checks, ARM64 release build, APK signature check and artifact checksum. Do not claim pixel-perfect completion from a green build alone; compare a fresh 360 dp screenshot against the reference and report physical-device verification separately.
