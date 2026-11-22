# BAD GYM Member Dashboard — Design Authority

## Master reference
The user's final approved screenshot at 691 × 1536 px is the single source of truth. Preserve its composition, component order, color intent, visual hierarchy and density. Do not substitute other dashboard concepts.

## Required component order
1. Big Billion Sale promotional banner.
2. Check-in complete and Freeze strip.
3. Member portrait area, member name, ID, age, gender, Gold plan and Active state.
4. Payment due, amount, discount, days remaining, expiry and QR marker.
5. Early payment offer strip.
6. Membership days and progress bar.
7. Four sponsored horizontal metric cards: Attendance, Workout, Payment and Body.
8. Attendance Intelligence module: narrow vertical rail and analytics surface.
9. Attendance percentage, present/late/absent/holiday totals, streak and best streak.
10. Month calendar with per-day state colors and compact legend.
11. Bottom utility shortcuts and decorative purple footer.

## Visual language
- Lavender canvas with soft purple light.
- Purple/violet neon and metallic gold borders.
- White/lavender glass-like card surfaces.
- Gold member treatment for Gold plan; plan treatment must remain data-driven for future Silver/Starter variants.
- Green for present/active, yellow for late/offers, red for absent/due, purple for analytics.
- Bold, high-contrast typography sized for phone viewing.

## Engineering constraints
- Native Flutter widgets for all text, metrics, controls, progress and calendar data.
- Never render the full screenshot as the app UI.
- Never invent or substitute unrelated visual components.
- Use SafeArea for system cutouts; the frame must not overlap status/navigation bars.
- 360 dp is primary; 320 dp compact width must remain usable.
- Demo values are sample data and must be replaced by repository-backed member data later.
