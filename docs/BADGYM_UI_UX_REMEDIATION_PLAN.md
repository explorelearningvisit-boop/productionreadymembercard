# BAD GYM — UI/UX Remediation Plan

## Reference and constraints
- Primary visual reference: the supplied 691 × 1536 member dashboard screenshot.
- Primary target: narrow Android phones around 360 dp width and 600–700 dp usable height.
- Preserve the existing information architecture: check-in/freeze, member identity, payment/offer, membership progress, four KPI modules, contextual vertical rail, analytics/calendar.
- Member data has visual priority. Ads remain visible but must not compete with KPI values, payment state, or attendance.
- Plan palette applies to the member dashboard shell and data components. Advertisements retain campaign/product brand colors.

## Findings from the installed screenshot and code review
1. Rail labels were clamped to 8–9.5 sp and icons to 14–18 dp. This is too small for a six-destination rail on a phone.
2. KPI values and trend chips shared one horizontal row. On four narrow cards this compressed the actual value.
3. The compact payment due caption and days-left text used 7.5–9.2 sp, making important billing state hard to read.
4. Gold and Active identity pills used image-backed backgrounds. These can contain embedded decoration/text and create a layered/overprinted appearance behind the labels.
5. Workout, Payment, and Body root destinations reused the label “Attend”, which is contextually incorrect.
6. Gold used a purple shell despite the new plan-based color rule. There was no Diamond palette.
7. Product artwork only had a one-shot entrance. It had no controlled depth/tilt treatment.
8. Promotional cards are currently sample UI. A real purchase/offer destination cannot be inferred from a sample asset or label.

## Plan A — Design system and plan identity
**Implementation**
- Gold: warm metallic gold frame, champagne/ivory canvas, dark bronze rail, gold progress and selected state.
- Silver: cool steel/silver surfaces with restrained blue-grey accents.
- Diamond: icy pearl, silver-blue and cyan accents.
- Spark: emerald/green palette.
- Keep campaign artwork and ad CTA colors independent of member tier.
- Use gradient/text status chips instead of image backgrounds for Gold Plan and Active.

**Why**: users should recognize the active membership tier immediately and consistently.
**Trade-off**: plan colors must not alter semantic colors for due/overdue, absent, late, or success states.
**Acceptance**: screenshot tests verify distinct plan palettes and stable ad colors.

## Plan B — Data-first typography and responsive layout
**Implementation**
- Increase rail labels to a readable 10.5–12 sp range and icons to 18–22 dp where space permits.
- Make KPI values the first visual stop; suppress secondary trend chips on the narrowest compact layout rather than shrinking the value.
- Increase payment due and days-left captions; keep amount and status readable at 320–390 dp.
- Avoid using FittedBox as a routine substitute for proper layout. Use it only as a final overflow guard.
- Keep key touch targets close to 44 dp where practical.

**Why**: the user's primary task is reading member data, not reading ad copy.
**Trade-off**: fewer secondary labels may be visible on short screens; the detail panel can carry expanded information.
**Acceptance**: no clipped text, KPI values remain prominent, and no render exceptions across 320×560, 320×640, 360×600, 360×700, 390×720.

## Plan C — One source of truth for navigation state
**Implementation**
- Horizontal KPI module selection sets the active module and resets its submenu to index zero.
- The vertical rail is generated only from the active module's menu definition.
- Each rail item has a unique semantic label, stable key, selected state, and matching detail panel.
- Root labels are contextual: Attend, Workout, Payment, Body. Secondary labels remain module-specific.

**Why**: two independent menus create contradictory states and confusing navigation.
**Trade-off**: module switching intentionally resets the rail to that module's overview; preserving an old submenu index would be unsafe because menu lengths and meanings differ.
**Acceptance**: tap every KPI, then every rail destination; assert title, selected state and detail content all match.

## Plan D — Advertising as a separate, functional layer
**Implementation**
- Keep ad surfaces and product colors separate from the membership theme.
- Use product-specific actions only when a real offer identifier, destination URL, in-app route, or merchant action exists.
- For sample campaigns, clearly mark the state as demo/sample and do not pretend that purchase is live.
- Track ad impressions and taps only after a real analytics destination is configured.

**Why**: a visually clickable “BUY NOW” that does nothing breaks trust.
**Trade-off**: a campaign without a destination can show a preview but cannot be called a working purchase flow.
**Acceptance**: each live CTA has a testable destination and back-navigation; sample campaigns are clearly non-transactional.

## Plan E — Motion and interaction
**Implementation**
- Use short, finite entrance motion for data cards and restrained perspective tilt for product cut-outs.
- Keep product rotation subtle and limited; never rotate text, price, CTA, or the entire card.
- Add pressed-state scale/overlay and 160–220 ms transitions for module changes.
- Avoid infinite shimmer/pulse loops, excessive parallax, or motion that affects scrolling and readability.
- Respect reduced-motion accessibility settings before adding continuous animation.

**Why**: depth belongs to product artwork, while the member data remains stable.
**Trade-off**: motion is decorative and must never be required to understand an action.
**Acceptance**: no layout shift, no perpetual animation load, and all controls remain tappable during transitions.

## Current implementation batch
- [x] Increase vertical rail width and icon/label sizing.
- [x] Replace image-backed Gold/Active status pills with clean gradient pills.
- [x] Correct contextual root labels for Workout, Payment and Body.
- [x] Make Gold palette gold/champagne and add Diamond palette; preserve Spark green and Silver steel-blue.
- [x] Increase KPI and attendance/calendar typography; prioritize compact KPI values over trend chips.
- [x] Add restrained perspective entrance motion to product cut-outs.
- [ ] Run formatter, analyzer, widget tests and release APK build.
- [ ] Verify on the user's physical Xiaomi 11i; CI/emulator success is not physical-device verification.
- [ ] Wire live ad destinations after actual offer/product URLs or in-app routes are supplied.
