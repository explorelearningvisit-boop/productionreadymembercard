# BAD GYM — Emerald Pearl Member Intelligence Dashboard
**Version:** 1.0 | **Owner approved:** 2026-11-28 | **Platform:** Flutter/Dart  
**Working branch:** grok/purple-neon-member-dashboard

> This is the new visual master and supersedes Purple Neon/Lilac Glass. Do not continue the old purple frame, purple navigation rail or purple promo shell.

## Approved image metrics
- Generated owner-approved source: 841×1870 px, ratio 0.4497 portrait.
- SHA-256: d49be4260ddb9fe1f9f5424af58a5e7c0f09cc261b20a5d4a5dbf8e4d409f740
- Source filename in generation runtime: a_clean_modern_realistic_app_dashboard_ui_mobil.png
- Visual authority only; never use as runtime background or flattened UI.
- Logical reconstruction: 360×800dp full-device portrait. The source includes OS chrome; Flutter uses actual SafeArea/system bars and MediaQuery insets. Raster pixels are not logical dp.

## Source of truth
- Repo: explorelearningvisit-boop/productionreadymembercard
- Design direction: DESIGN.md
- Full spec and copy-ready prompt: this file
- Tokens: assets/design_system/emerald_pearl_theme.json
- Progress: docs/IMPLEMENTATION_PROGRESS.md
- Handoff: docs/CHAT_HANDOFF.md
- Runtime art: assets/material_pack/inbox/PulseVault/
- Theme: lib/theme/member_theme.dart
- Screen: lib/screens/member_dashboard_screen.dart
- Analytics: lib/widgets/attendance_panel.dart and module_dashboard_views.dart
- Components: lib/widgets/dashboard_primitives.dart

## Five-line design direction
- Product: phone-first gym member intelligence for check-in, membership, payment, training and attendance.
- Character: athletic, assured, human and precise.
- World: premium fitness club, pearl-glass workspace, deep forest-emerald structural frame.
- Moments: ice Freeze card, tangible gym product art in four KPI cards, attendance ring/calendar.
- Signature: compact Member Intelligence workspace with deep-emerald contextual rail and bright pearl data panel.

## Color system

| Role | Hex | Usage |
|---|---|---|
| Forest shell | #012022 | deepest frame |
| Emerald shell | #01493C | frame and rail |
| Emerald primary | #0F8457 | actions, selected states, progress |
| Emerald deep | #07533E | dark CTA/check-in |
| Pearl background | #F6FAFA | main canvas |
| Pearl surface | #FCFDFD | cards |
| Raised pearl | #F0F6F7 | inset surfaces |
| Soft mint | #E0F6E7 | positive KPI/selected rail |
| Mint edge | #CBE8D5 | fine borders |
| Main ink | #142C25 | primary text |
| Secondary ink | #536A61 | secondary text |
| Muted ink | #788C83 | captions |
| Champagne | #D6AA3C | Gold Plan only |
| Sky | #E3F2FA | Payment KPI |
| Sky ink | #236C98 | payment accent |
| Muted lavender | #EEEAF6 | Workout KPI only |
| Ice | #E5F4FC | Freeze |
| Ice ink | #267CA3 | Freeze details |
| Rose | #D94B5D | due/absent |
| Amber | #D69A2D | late/caution |
| Muted violet | #766899 | holiday only |
| Off neutral | #E4E8E7 | off days |

Rules:
- Emerald + pearl is product identity. Purple is not frame, shell, rail, primary action or promo shell.
- Gold belongs to Gold Plan; ice to Freeze; sky to Payment; lavender to Workout; mint to Attendance/Body.
- Present/success=emerald; late=amber; absent/payment due=rose; holiday=muted violet; off=neutral grey.
- Show Days Left once only, in Membership Progress.
- No rainbow/hue gradients, gradient text, full-screen glow, radial blobs, chrome liquid or particles. Gradients shift within one material family only.

## Material finish
Pearl cards have near-white fill, one fine edge, small neutral/green-tinted shadow and optional top highlight. Emerald frame/rail are clipped inside the shell. Freeze is ice-white/pale-blue with snowflake and bottle cut-out; only static CustomPainter ice facets if needed, no full-screen blur. Gold Plan is champagne with dark text. Active is emerald. Campaign cards may be richer only inside their own bounds. Glass means translucent pearl, fine edge and restrained highlight; prefer tinted fill to repeated BackdropFilter on low-end devices. Neumorphism is subtle contact depth, not multiple opposing shadows on every card.

## Typography and spacing
Use Android system Roboto initially; no new font pack. One family. Sentence case. Weights 400 secondary, 500 labels, 600 section headings, 700 primary values; avoid blanket w800/w900. All content text remains Flutter Text, never baked into assets. Use tabular figures.
| Element | Size at 360dp |
|---|---:|
| Member name | 18–21sp |
| Section title | 14–16sp |
| KPI value | 18–22sp |
| KPI label | 9.5–11sp |
| Member metadata | 10.5–12sp |
| Attendance legend | 10–11sp |
| Calendar weekday | 9–10sp |
| Calendar date | 12–13sp |
| Campaign caption | 8.5–10sp |
| Sync footnote | 8–9sp |

Use a 4dp grid; 2dp optical nudge is allowed. Outer radius 24–28dp, cards 14–18dp, controls 9–12dp. 1dp hairline. Neutral/green shadow 5–8% opacity, blur 4–8dp, y 1–3dp. No external neon halo.

## 360dp wireframe and section order

| Order | Region | Target budget | Content |
|---|---|---:|---|
| 1 | Check-in / Freeze | 48–50dp | Two adjacent panels |
| 2 | Member identity | 92–96dp | Portrait, name/meta, Gold + Active |
| 3 | Payment / offer | 56–60dp | Due left, product right |
| 4 | Membership progress | 40–44dp | 22/30, one days chip, 73%, bar |
| 5 | KPI row | 124–130dp | Four equal tiles |
| 6 | Intelligence | remaining safe space (~320dp baseline) | 54dp rail + analytics |
| — | OS bars | actual insets | OS-owned, never fake |

```text
┌──────────────────────────────────────┐
│ ANDROID STATUS BAR (system-owned)    │
├────────────────────┬─────────────────┤
│ CHECK-IN           │ FREEZE / ICE    │
├──────────────────────────────────────┤
│ MEMBER PORTRAIT    │ NAME + META     │
│                    │ GOLD | ACTIVE   │
├────────────────────┬─────────────────┤
│ PAYMENT DUE        │ PRODUCT OFFER   │
├──────────────────────────────────────┤
│ MEMBERSHIP 22/30     8 DAYS LEFT 73% │
│ [──────── emerald progress ────────] │
├────────┬────────┬────────┬───────────┤
│ATTEND  │WORKOUT │PAYMENT │BODY       │
│81%     │58 min  │₹500    │69.5 kg    │
│ART     │ART     │ART     │ART        │
│OFFER   │OFFER   │OFFER   │OFFER      │
├────────┬─────────────────────────────┤
│        │ MEMBER INTELLIGENCE         │
│ ATTEND │ partner/demo creative       │
│ INSIGHT│ attendance ring + legend    │
│ CAL    │ streak / best / this month  │
│ HISTORY│ recovery creative           │
│ TREND  │ month heading + compact     │
│ GOALS  │ 7-column attendance grid    │
│        │ sample / sync footnote      │
└────────┴─────────────────────────────┘
│ ANDROID NAVIGATION BAR (system-owned)│
└──────────────────────────────────────┘
```

360dp is primary; verify 320 and 390dp. SafeArea/LayoutBuilder control usable height. Outer margin 4–6dp, inner padding 4–6dp. KPI cards equal flex children with 3–4dp gaps. Bottom rail 52–56dp, content gap 4–5dp. Rail is inside dashboard, no duplicate app navigation. No scrolling/clipping/overflow at reference size; reclaim decorative gaps before shrinking key text.

## Component contracts

### Check-in and Freeze
Check-in is dark emerald with green check, 07:12 AM and member cut-out. Freeze is ice-white/pale-blue with snowflake, Freeze, Stay Cool · Pause Plan, short Demo offer and bottle. Separate touch targets. Freeze remains local preview. Existing purple shaker is a replacement candidate.

### Member identity
Transparent portrait in rounded clipped plate. Name one line when possible. Metadata member ID/age/gender with aligned icons and dividers. Gold Plan champagne, Active emerald. Perks/rewards captions subdued and sample-labelled. No text baked into images.

### Payment/promotion
Payment due left: wallet, PAYMENT DUE, ₹500 in rose and alert icon. No AD prefix. No Days Left duplicate. Whey product offer right: deep emerald card, transparent product art, Whey Protein, 25% OFF, champagne CTA. Demo until real campaign. Art/copy/CTA must stay as one paired campaign item.

### Membership
22 / 30 Days, 73%, one 8 Days Left chip and emerald progress. 22/30 = 73.3% rounded 73. Remaining days derives from total minus used unless server-authoritative.

### KPI cards
Equal geometry/header/value/art/footer. Attendance mint 81% +6% Protinex; Workout muted lavender 58 min +12% Creatine; Payment sky ₹500 Due SBI art; Body mint 69.5kg −0.8kg Fat Loss. KPI tap changes module workspace/rail; campaign strip opens preview separately.

### Member Intelligence
Default is compact Attendance overview. “DEMO” until live source. Ring 81% / 25 of 31. Legend: Present 23 (74%), Absent 2 (6%), Holiday 4 (13%), Late 2 (6%). Labels remain; color is not sole cue. Stats: 5d streak, 14d best, +6% this month (sample). Recovery offer compact/Demo. October 2026 demo calendar, 7 columns: Present mint, Late amber, Absent rose, Holiday muted violet, Off neutral grey, selected/today emerald outline. Footer “Sample member data · Live sync not connected”.

### Navigation rail
Attend, Insights, Calendar (shorten to Cal only if needed), History, Trend, Goals. Deep forest emerald; selected pale mint with dark ink/icon. No rainbow items.

## Data contract
Current MemberSample.demo:
- Ashwani Kumar Singh / BG215 / 28 yrs / Male / Gold Plan / Active
- 22 of 30 days, 8 days left, 73%, ₹500 due
- Attendance 81%; Workout 58 min; Body 69.5kg
- 23 present, 2 late, 2 absent, 4 holiday
- 5d current streak, 14d best, +6% month change — all demo

Never invent live AI readiness, health values, body fat, workout recommendation, payment or partner data. Check-in/Freeze/campaign actions remain previews.

## Asset pack and export contract

Runtime root assets/material_pack/inbox/PulseVault/. Theme tokens assets/design_system/emerald_pearl_theme.json. New assets go into PulseVault only after review. Retain old files until replacements, manifest, pubspec, CI and screenshot pass. Reference screens never runtime backgrounds.

New art exports at **3× display dp**. These are target canvas sizes, not measured existing assets:

| Asset proposal | Display dp | Export px | Ratio |
|---|---:|---:|---:|
| 01_member_portrait_cutout.webp | 84×88 | 252×264 | 0.95 |
| 02_checkin_mascot_cutout.webp | 54×48 | 162×144 | 1.13 |
| 03_freeze_bottle_ice_cutout.webp | 46×48 | 138×144 | 0.96 |
| 04_whey_promo_cutout.webp | 76×52 | 228×156 | 1.46 |
| 05_attendance_product_cutout.webp | 60×54 | 180×162 | 1.11 |
| 06_workout_product_cutout.webp | 60×54 | 180×162 | 1.11 |
| 07_payment_card_cutout.webp | 64×48 | 192×144 | 1.33 |
| 08_body_product_cutout.webp | 60×54 | 180×162 | 1.11 |
| 09_grocery_partner_cutout.webp | 44×34 | 132×102 | 1.29 |
| 10_recovery_banner_cutout.webp | 66×42 | 198×126 | 1.57 |

Transparency/crop:
- WebP with alpha or PNG RGBA only; no fake checkerboard.
- Preserve full silhouette (hair, hands, limbs, lids, caps). Nothing touches crop edge.
- 5–8% clear padding around object.
- Prefer no baked contact shadow; Flutter renders subtle neutral shadow.
- Lossless WebP for fine detail or alpha WebP quality 88–92 if materially smaller; PNG RGBA is okay.
- Fixed slot, BoxFit.contain, preserve aspect. Never stretch/BoxFit.fill.
- Validate alpha min/max, subject bbox, ratio, size and visual crop.
- No text, pseudo-logo, QR, price, watermark or UI in art.
- Use licensed/owner-provided brand assets only; otherwise “Partner offer · Demo”.

Per-asset generation prompt:
“One [specific gym object/person] cut out on a fully transparent background, realistic studio product photography or controlled 3D product render, soft upper-left key light, subtle neutral contact shadow, front three-quarter view, centered with 6 percent transparent breathing space, full object entirely inside canvas, no crop, no text, no letters, no logo, no watermark, no UI, no border, PNG RGBA or alpha WebP, [exact target pixel dimensions].”

Use realistic studio style, natural materials, moderate highlights; never generate the whole dashboard as a runtime background. Audit current PulseVault dimensions/alpha/crop before reuse. Potential art: bodybuilder, whey, creatine, Protinex, SBI, fat-loss, snowflake, dumbbell. Re-evaluate purple shaker/progress bar/backplates. Keep original source files; register only selected optimized files in pubspec.

## Flutter architecture
Flutter/Dart and current app ID. No React/Next/Vite/Tailwind/shadcn/GSAP/Framer/Three.js/JS runtime. Native widgets, existing fl_chart, limited CustomPainter. Stable single screen; separate UI/data repository. LayoutBuilder, SafeArea, Expanded/Flexible/AspectRatio and explicit text constraints. Never globally shrink text to hide overflow. Four KPI modules and six rail destinations remain. Use semantic theme tokens. No new runtime packages without concrete need and license/size/maintenance review. No BackdropFilter on every card.

## Motion
| Moment | Flutter primitive | Duration |
|---|---|---:|
| KPI selection | AnimatedContainer/AnimatedSwitcher | 160–200ms |
| Panel switch | fade + 4–6dp slide | 220–280ms |
| Progress | TweenAnimationBuilder | 300–450ms once |
| Freeze feedback | AnimatedContainer/icon fade | 160–200ms |
| Product art | ArtworkEntrance | 180–240ms once |
| Button press | InkWell/AnimatedScale .98 | 100–140ms |
| Attendance ring | CustomPainter + TweenAnimationBuilder | 350–500ms once |
| Calendar selection | AnimatedContainer | 140–180ms |

Respect MediaQuery.disableAnimations. No idle loops, autoplay, shimmer/pulse/spin, particles. Never hide data during motion.

## Accessibility/performance
TalkBack action/state semantics; 44×44dp practical target where possible; WCAG AA contrast 4.5:1 body, 3:1 large/non-text; color never sole cue; test text scaling 1.0/1.2; fixed art slots and bundled assets; avoid full-screen blur/continuous shaders. Physical device separate from CI.

## Pixel verification
1. Real Flutter capture at 360dp.
2. OS bars treated consistently.
3. Crop/align safe content.
4. 50% overlay + diff image.
5. Record section boxes/gaps/rail width/text baselines/art bounds.
6. Inspect 320/390dp.
7. Check overflow/clipping/missing asset/scroll.
8. Record device/OS/API/dp/file/commit.
9. CI pass is not device certification.

## Stages
| Stage | Work | Acceptance |
|---|---|---|
| 0 Visual lock | Spec, DESIGN, tokens, wireframe, prompt, handoff | Authority fixed |
| 1 Theme tokens | MemberTheme/MemberPlanPalette/tests | Emerald/Pearl Flutter theme |
| 2 Asset pack | Alpha/dim/crop audit and missing art | Real alpha, correct ratio, manifest/pubspec |
| 3 Shell/identity | Frame, check-in, Freeze, profile | 360dp top section aligned |
| 4 Payment/membership | Due, offer, progress | One Days Left; no AD tag |
| 5 KPI row | Four equal cards | Role-based surfaces and art |
| 6 Intelligence | Rail, ring, legend, stats, offer, calendar | Default view and six destinations |
| 7 Motion/accessibility | Native motion, semantics, reduced motion | Focused tests; no loops |
| 8 Pixel QA | 320/360/390 capture + diff | Measured geometry, no overflow |
| 9 Android QA | Format/analyze/tests/ARM64/signature/SHA | All CI gates pass |
| 10 Device | Xiaomi 11i install/launch/capture | Separately recorded |
| 11 Backend | Auth and real data/actions | Never faked during visual scope |

A stage completes only after validation and progress update.

## Exclusions
No screenshot runtime background; no web component code in Dart; no unlicensed paid Animmaster content; no fake partner/live/data claims; no extra bottom app nav; no mass asset deletion; no unrelated refactor; no app ID/signing/secrets/Firebase changes; no blanket w900, excessive gradients or neon shadows.

## Skill routing
Unslop: nine passes (spacing, color, icons, copy, type, layout, details, visuals, motion); retain bundled CC BY 4.0 attribution. Animmaster: motion inspiration/native Flutter only, no paid source without license. Skiper: check free/premium and attribution. Vengeance: retain MIT if source copied. These are not runtime dependencies.

## Copy-ready implementation prompt
You are implementing BAD GYM's Emerald Pearl Member Intelligence Dashboard in the existing Flutter Android repository. Read AGENTS.md, DESIGN.md, this spec, docs/IMPLEMENTATION_PROGRESS.md, assets/design_system/emerald_pearl_theme.json and PulseVault README before editing.

Visual authority: owner-approved portrait reference generated 2026-11-28, 841×1870px, ratio 0.4497, mapped to 360×800dp full-device. Pixels are not logical units. Reconstruct in SafeArea with real OS insets. Preserve section order and compact one-screen structure.

Design: Emerald + Pearl; forest-emerald frame/rail, pearl workspace. Gold only Gold Plan. Freeze ice. Attendance mint, Workout muted lavender, Payment sky, Body mint. Due/Absent rose, Late amber, Holiday muted violet, Off neutral grey. Quiet shadows/edges. No purple shell, rainbow gradients, gradient text, heavy blur or permanent glow.

Build check-in/Freeze; member identity/Gold/Active; payment/product offer; membership progress with one Days Left chip; four equal KPI cards; Member Intelligence with six-item rail, attendance ring/legend, streak stats, recovery offer, October calendar and sample-sync footnote. Payment has no AD tag and no duplicate Days Left.

Assets: true transparent PNG RGBA/alpha WebP, 3× slot size, Section asset rules. No fake alpha, embedded text/logo/UI, stretched art or full-screen background. Update manifest/pubspec only after validation.

Flutter/Dart native only. No web runtime. Use Flutter animation primitives and CustomPainter only when helpful. Keep blur/shadow low-cost. Respect reduced motion; no loops.

Data remains Demo. No fake live state, attendance/payment, merchant partnerships or AI readiness. Actions remain previews until backend.

Work one stage at a time. After each stage update docs/IMPLEMENTATION_PROGRESS.md and docs/CHAT_HANDOFF.md; commit focused changes on grok/purple-neon-member-dashboard. Verify HEAD before edit. Run pub get, format, analyze, widget tests and ARM64 CI build. Inspect real logs/artifacts. Compare actual 360dp capture with owner image via overlay/diff. CI pass is not physical certification.

Fresh chat: read live HEAD and docs/IMPLEMENTATION_PROGRESS.md, verify last stage against commits/Actions, start first incomplete stage. Do not ask owner to repeat recorded requirements. GitHub docs are durable handoff; do not claim conversational memory is permanent.

## Changelog
- 2026-11-28: Emerald + Pearl approved; Purple Neon/Lilac superseded.
- 2026-11-28: Locked 841×1870px source, 0.4497 ratio, 360×800dp logical target.
- 2026-11-28: Defined visual, wireframe, asset, motion, QA and cross-chat contracts.


## 18. Stage checkpoint — 2026-11-28
- Stage 1 theme tokens and first-pass component color migration implemented on grok/purple-neon-member-dashboard.
- Commits: 4f6ddbb (master docs), 7e77819 (theme migration), c23eb0a (analyzer identifier fix).
- Build #720 on c23eb0a passed format, analyzer, widget tests, ARM64 release APK and signature verification.
- Next: Stage 2 audit all PulseVault images for actual dimensions, alpha channel, subject bbox and semantic/color suitability; never delete originals before verified replacements.
