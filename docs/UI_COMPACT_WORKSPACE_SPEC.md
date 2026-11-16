# BAD GYM — Compact Intelligence Workspace Specification

Status: ACCEPTED PRODUCT DIRECTION — implementation pending unless a section says otherwise.

## Objective
Replace the current vertically scrolling, tall dashboard with a compact, fixed-viewport workspace. The user explicitly rejected the screenshot dated 2026-11-16 because the card consumes most of the screen while showing too little useful information.

## Screen architecture
1. Compact member context header: member avatar/name/ID, active/plan state, due amount, expiry and membership progress. Avoid a tall hero banner. Preserve the facts; compress presentation.
2. Four horizontal quick tabs in this order: Attendance, Workout, Payment, Body. Reduce card height, vertical padding, icon box and gaps. Selected state is clear but restrained.
3. Below the tabs, a narrow contextual vertical rail and a single fixed-size content viewport. The rail height matches the viewport, not the full page. Tapping a rail item replaces the current widget in place; never append another widget below it.
4. Default tab: Attendance. Default rail item: Calendar. Open the current month calendar immediately.
5. Attendance rail destinations: Calendar, Trend, History, Streak/Insights. Each has a dedicated compact widget; only one is visible at a time. Calendar uses existing day semantics: green present, red absent, amber late, grey Sunday/off, and a neutral non-purple holiday treatment.
6. Workout, Payment and Body each expose contextual rail destinations and bounded widgets. Use existing data/features; do not invent data or claim unavailable functionality.

## Viewport rules
- Target 360dp width and the real usable height between system status/navigation bars on Xiaomi 11i.
- No vertical scroll on the primary dashboard. Avoid nested scroll views inside the primary viewport.
- Use LayoutBuilder/constraints and explicit compact variants. Every selected widget must have a bounded height and pass 360dp tests.
- If information exceeds the viewport, use rail/tab switching, segmented detail views, or a deliberate detail sheet—not an ever-growing page.
- Keep typography legible; reduce whitespace/padding before reducing text below accessible size.
- Preserve data and interactions. No dummy metrics, no hardcoded member replacement, no destructive migrations.

## Visual system
- Premium light warm-ivory surfaces, controlled crimson/red primary accents, restrained gold premium accent, semantic green/red/amber/grey.
- Remove mixed lavender/purple + peach/pink + gold competing gradients. Avoid a large decorative outer frame consuming space.
- Strong contrast, clear hierarchy, compact surfaces, consistent radii, thin borders, restrained shadow.
- No duplicate metric repeated in header, quick tab and selected widget unless deliberate navigation summary.

## Acceptance criteria
- Default launch: Attendance > Calendar, current month visible.
- Switching Attendance rail items replaces content without increasing screen height or page scroll extent.
- All four top tabs visible at 360dp.
- Header, quick tabs, rail and widget fit usable viewport without overflow.
- No ScrollView on root dashboard path; tests assert no scroll extent for primary screen.
- Test all rail items and tab changes; screenshot at 360dp and Xiaomi physical device before claiming visual completion.

## Historical design
Previous full-height scrollable card, full chart+calendar stacked together, and unified tall outer frame are rejected by user's 2026-11-16 feedback. Retain older screenshots/logs as history; do not delete them or treat them as current visual authority.
