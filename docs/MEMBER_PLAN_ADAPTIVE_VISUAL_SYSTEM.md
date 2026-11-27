# BAD GYM — Member Plan Visual System & Motion Specification

**Owner direction:** Every member card receives its own identity from the purchased plan. The current sample member is Gold Plan. Spark Plan must use a green-led frame, rail, surface tint and progress system. Do not hard-code purple as the universal brand color.

## Plan palette contract

| Plan | Frame and navigation | Inner canvas | Active accent |
|---|---|---|---|
| Gold | Espresso / antique-bronze with champagne rim | Warm pearl, cream and pale champagne glass | Antique gold / bronze |
| Spark | Forest green / emerald with pale lime rim | White, mint and pale green glass | Emerald |
| Silver | Slate / steel blue | White, cool mist and blue glass | Steel blue |

Plan color tokens are provided by `MemberPlanPalette.forPlan(member.plan)`. The current implementation selects the plan palette from the member record, not from a global app preference. Extending the member record with additional plans should only require another palette definition.

Semantic colors remain consistent across plans: present = green, absent = rose, holiday = violet, late = amber; payment due = rose; payment KPI = sky; body KPI = mint. Plan identity must not make operational statuses ambiguous.

## Layout and edge rules

- The outer frame, its gradient and all radial light effects must be clipped inside the frame. There is no large glow painted outside the device card.
- The area outside the frame uses the active plan's dark frame tone, so the shell reads as one contained piece.
- All top-level panels have a 2–4 dp horizontal inset. Membership progress is intentionally narrower than its parent row to stop left/right borders and shadows from visually colliding.
- Glass panels use their own fine edge and restrained shadow. Avoid a single purple shadow around every panel.
- The plan and Active pills are 30 dp high with 8 dp sponsor captions underneath.
- Check-in no longer repeats the member portrait artwork. It uses a partner-offer asset and a separate sponsor caption.
- Freeze has a 14 sp heading, readable secondary copy and a separate member-offer badge.
- Payment due has a proper wallet icon, high-contrast amount and days-left detail.

## Typography and minimums at the 360 dp target

| Element | Target size |
|---|---:|
| Member name | 17.5–21 sp |
| Main section headings | 14–16 sp |
| KPI values | 17–20 sp |
| KPI labels | 9.2–10.5 sp |
| KPI offer strips | 8.2–9.2 sp |
| Attendance legend | 9–10.5 sp |
| Calendar dates | 12–13 sp |
| Calendar weekday names | 9–10 sp |
| Sponsor captions | 8 sp where space allows |

The one-foot readability target applies to the primary amounts, status, KPI value, attendance percentages and dates. Footnotes may remain smaller because they are not customer decisions.

## Icon system and root cause

The app previously used Flutter's `Icons.*` widgets but declared `uses-material-design: false` in `pubspec.yaml`. This prevented the Material icon font from being bundled, producing missing-glyph boxes/crosses in navigation and the payment wallet. The application now enables `uses-material-design: true`; use named Material icons for navigation, wallet, member metadata, plan and status. Avoid text-symbol substitutes such as hollow squares.

## Advertising and motion

- Sponsor locations are explicit preview inventory, not claims of actual brand partnerships: `AD SPACE • BLINKIT` and `AD SPACE • SBI REWARDS`.
- Check-in and Freeze rotate their short partner/offer messages every seven seconds using an AnimatedSwitcher fade + vertical slide.
- Four KPI artworks have distinct one-shot entrances: rise, settle, tilt and lateral fade.
- Product artwork preserves aspect ratio with `BoxFit.contain`. No external image is hot-linked at runtime.
- Motion is brief and finite on image entrance; only sponsor text rotates. No forever-loop animation is added to dense dashboard content, reducing GPU/battery cost and keeping widget tests deterministic.
- Future sponsor creatives should be represented as a local asset + title + offer + motion style, not baked into a screenshot.

## Assets

Use the existing PulseVault / `assets/member_card` source pack for the current visual prototype. Use Material icons where a functional symbol is needed. Do not pull arbitrary Pinterest images into the app: an asset must have a clear source and usable license before it is copied into the repository. Brand marks shown in ad-space previews must remain illustrative until an actual advertiser relationship is confirmed.

## QA gates

- Dart formatter, Flutter static analysis and all widget tests.
- Viewport regressions at 320×560, 320×640, 360×600, 360×700, 390×720 and 800×600.
- No RenderFlex overflow, no missing asset or missing Material glyph.
- ARM64 release APK signature and checksum verification.
- Capture a fresh 360 dp device screenshot and compare it visually against the supplied screenshot. Passing CI is not proof of pixel-perfect physical-device output.
