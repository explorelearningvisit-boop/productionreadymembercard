# BAD GYM — Reference-led member dashboard implementation prompt

**Source of truth:** the five owner-uploaded menu screenshots from 2026-11-27, the existing approved member-card structure, PulseVault runtime assets, and this repository's `DESIGN.md`. This document is the implementation contract for the Flutter dashboard.

## Product and visual direction

Build a mobile-first gym member intelligence dashboard for a real gym member. Its visual character is athletic, confident, tactile and data-rich.

Use a consistent **lavender / purple pearl-glass system across every plan**:
- Canvas: pale lavender, pearl white and soft lilac gradients.
- Navigation and selected state: deep grape / purple with clear white text and icons.
- Surface: translucent white glass cards, soft inner highlight, thin lavender hairline and restrained violet shadow.
- Progress and success: vivid green.
- Late / caution: amber.
- Absent, overdue and payment due: rose / red.
- Neutral / holiday / disabled: cool light grey.
- Tier identity: retain separate Gold, Silver, Diamond and Spark plan badges. Do not recolour the complete application shell by tier.

Use glassmorphism, soft-neumorphic elevation and selective skeuomorphic cues for progress tracks, ring meters, payment states and interactive controls. Avoid universal gloss, heavy blur, rainbow gradients, large external glows and unnecessary animation.

## Shared screen hierarchy

Preserve the existing top-level member shell and four horizontal module tabs:
1. Member identity: portrait, member name/ID, age/gender, active status and plan.
2. Check-in and membership controls with honest preview/live state.
3. Membership progress and renewal countdown.
4. Horizontal module tabs: Attendance, Workout, Payment, Body.
5. Contextual vertical rail for the selected module.
6. One selected detail widget at a time.

Horizontal tab selection must update the vertical rail. Selecting a rail item must replace the content pane with exactly one corresponding detail view. Both levels must share a single source of selection state; no visual-only dead selection.

## Menu map and component requirements

### Attendance
- **Overview:** attendance percentage ring, present/late/absent/holiday distribution, current streak, average check-in time, calendar with semantic day states and a trend summary.
- **Insights:** attendance score, weekly activity chart, streak summary and next goal.
- **Calendar:** month navigation, weekday alignment, clear present/absent/late/holiday legend, selected day and disabled/off states.
- **History:** dated check-in list, time, day status and source indicator.
- **Trend:** 12-month attendance line chart, best/lowest markers, tracked months and average.
- **Goals:** monthly visit goal, percentage target and weekly consistency progress.

### Workout
- **Overview:** total training time, average duration, best session, lowest session, consistency, daily training chart and active-day summary.
- **Insights:** training load, daily/weekly duration chart, session average and consistency insight.
- **Log:** workout date, duration, exercise list, sets/reps and session summary; show explicit empty state when no workout records exist.
- **Trend:** daily minutes line/area chart, monthly workout pattern bars, best and low markers.
- **Recovery:** sleep, hydration, rest/mobility checklist and relevant PulseVault creative.
- **Goals:** weekly sessions, workout consistency, session completion and recovery goals.

### Payment
- **Overview:** payment status, outstanding amount, plan and period, renewal date/countdown, membership use and payment trend.
- **Insights:** payment behaviour distribution (on-time / early / late), reliability score only when computed from a real ledger, and payment trend.
- **Invoices:** current balance, invoice number/date/status and downloadable receipt action when connected.
- **History:** transaction timeline, amount, payment method, date, receipt and server confirmation; honest empty state without a ledger.
- **Methods:** UPI/card/auto-pay availability and secure method status; never show or store raw card credentials.
- **Rewards:** reward points, cashback, eligible campaigns and offer artwork; campaign details remain demo until a real campaign provider is configured.

### Body
- **Overview:** current weight, transformation target, body-composition ring, weight/muscle/fat indicators and at-a-glance status.
- **Insights:** BMI, body fat, muscle mass and health/fitness indicators only when supported by recorded measurements.
- **Weight:** weight history, multi-series trend, start/current/goal values and date range.
- **Measurements:** chest, waist, arm and other circumference records with change versus prior measurement.
- **Nutrition:** nutrition creative, meal journal, macros and coach plan status.
- **Goals:** target weight, composition target, measurement milestones and progress.

## Data integrity rules

- Existing `MemberSample.demo` remains the currently available member source. Do not silently replace its values with numbers taken from the reference screenshots.
- The five screenshots are visual and component references, not a new authoritative member ledger.
- Any illustrative series or illustrative value must be visibly labelled “Demo”, “Sample” or “Illustrative preview”.
- Never show a hard-coded check-in, payment, body measurement, AI insight or workout value as live.
- Do not invent merchant partnerships, cashback eligibility, transaction IDs, payment references, renewal reminders or exercise history.
- When the backend has no data, use clear empty/loading/unavailable states instead of fabricated personal records.
- Preserve semantic status colours and labels; colour must not be the only signal.

## Chart and motion system

Use `fl_chart` for animated line, bar and pie/donut charts. Every chart must have:
- A specific title and unit.
- A clear time range or category.
- Consistent series colours and a legend when multiple series exist.
- Touch feedback / tooltip where useful.
- A visible demo/sample marker when the series is illustrative.
- No misleading axes, hidden zero values or fake real-time labels.

Motion:
- Module/detail change: fade + short slide, 180–260 ms.
- Chart data transitions: short ease-out, around 250–350 ms.
- Button/card pressed feedback: 120–180 ms, scale around 0.98.
- Product artwork: one-shot entrance and subtle perspective depth only. No endless bottle spins.
- Respect Android reduced-motion preference.
- Touch targets, keyboard/focus semantics and TalkBack labels must remain usable.

## Asset contract

- Inspect `assets/material_pack/inbox/PulseVault/README.md` and `manifest.json` before choosing artwork.
- Reuse the existing transparent WebP/PNG assets where they serve a real visual purpose: bodybuilder, whey/protein products, grocery/fitness creatives, shaker, dumbbell and payment-card graphic.
- Preserve alpha/transparency and source aspect ratio using `BoxFit.contain`.
- Keep all copy, names, labels, prices, values, badges and UI elements as Flutter widgets—not baked into images.
- Generate a new transparent PNG only when a specific required visual slot cannot be served by the existing pack. Add only that asset to the runtime manifest and pubspec.
- Do not add arbitrary decorative assets or duplicate the source pack.

## Mobile and responsive acceptance

- Primary width: 360 dp.
- Verify 320, 360 and 390 dp, and usable heights across 560–800 dp.
- Keep the compact no-unnecessary-scroll dashboard composition.
- Do not shrink member name, primary values, status text or calendar dates to conceal overflow; recompose lower-priority gaps first.
- Avoid clipped chart labels, overflowed legends, unreadable rail items and overlapping asset cut-outs.
- A rail selection must keep its selected state visible after content animation.
- Every module/destination combination must have a unique, testable content identity.

## Engineering and release gates

- Flutter-first. Use the existing app identity and PulseVault runtime path.
- Keep data access separate from UI. No invented backend endpoints or credentials.
- Add/update widget tests for every fixed interaction and layout regression.
- Required CI sequence: `flutter pub get`, format verification, `flutter analyze`, widget tests, ARM64 release QA APK, APK signature verification and artifact upload.
- Install and inspect the exact APK on Xiaomi 11i or a same-density Android device and compare a real screenshot to the owner's references.
- CI/widget tests do not equal device-level pixel-perfect verification.
- QA/debug-signed APK is not a Play Store production release. Production signing requires a private upload key in protected CI secrets.
- Never merge or publish production without the owner’s explicit authorization.

## Implementation completion checklist

- [ ] Shared lavender-glass theme and per-plan badge identity.
- [ ] Attendance overview and all five rail details.
- [ ] Workout overview and all five rail details.
- [ ] Payment overview and all five rail details.
- [ ] Body overview and all five rail details.
- [ ] Single-widget-at-a-time rail navigation for every module.
- [ ] Animated line, bar and donut charts with legends and units.
- [ ] PulseVault asset mapping and transparent image rendering.
- [ ] Demo/live source labels, empty states and honest action previews.
- [ ] Reduced-motion, semantics and touch behaviour.
- [ ] 320 / 360 / 390 dp and short/tall viewport tests.
- [ ] Full CI pass and verified ARM64 APK.
- [ ] Xiaomi 11i screenshot comparison and visual correction pass.
- [ ] Production backend, transaction actions and private signing explicitly validated before calling the app production-ready.
