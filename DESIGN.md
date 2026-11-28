# BAD GYM — Current product design direction

**Product.** A phone-first gym member dashboard for members and gym staff to understand check-in, attendance, workout, payment, body composition and membership status.

**Character.** Athletic, confident, tactile and data-rich.

**World.** A premium fitness club rendered in lilac pearl glass: lavender glass surfaces, deep-violet navigation, purple highlights, bright green success/progress, amber caution and rose absence/due states.

## Reference-derived visual system

- Use the supplied five dashboard references as the visual authority for the four KPI modules and payment detail variations.
- Apply the lilac/purple glass shell consistently across Gold, Silver, Diamond and Spark plans. Plan identity stays in its own badge and membership copy; it must not recolour the entire application shell.
- Keep operational semantics stable: present/success green, late amber, absent/payment due rose, holiday neutral/violet.
- Use a pale lavender canvas, soft raised pearl cards, restrained inner highlights, thin lavender edges and controlled shadows. Avoid dark page backgrounds and indiscriminate neon glow.
- Use glassmorphism and soft neumorphic depth on containers, with selective skeuomorphic details only for meaningful controls (progress, rings, payment state, chart markers). Do not make every surface equally glossy.
- Campaign artwork retains its own brand colours and must remain marked as a demo until a real merchant is connected.

## Information architecture

- Horizontal KPI tabs: Attendance, Workout, Payment and Body.
- Tapping a KPI changes the contextual vertical rail.
- Each module exposes six destinations; selecting one opens exactly one corresponding detail widget in the content pane.
- Attendance: overview, insights, calendar, history, trend and goals.
- Workout: overview, insights, log, trend, recovery and goals.
- Payment: overview, insights, invoices, history, methods and rewards.
- Body: overview, insights, weight trend, measurements, nutrition and goals.
- Preserve the member identity/progress header; module-specific content must add unique information rather than duplicate the same KPI values repeatedly.

## Charts, data and visual assets

- Charts must use real, labelled axes/units and consistent semantic series colours. Sample charts must be explicitly marked as sample.
- Use the existing Flutter drawing/widgets and project dependencies where they meet the design; add a chart dependency only when it is actually used in production code.
- Prefer existing PulseVault transparent cut-outs and preserve their aspect ratio. Generate new transparent PNG assets only for a specific missing visual slot; never invent assets as decoration.
- Keep the current member sample data clearly marked. No chart, AI insight, payment, attendance or check-in value may be represented as live until its data source is connected.

## Motion and interaction

- Use 160–220 ms ease-out selection and state transitions, and 220–360 ms fade/slide transitions between module widgets.
- Add restrained depth/tilt and press feedback to artwork and interactive cards; never continuously spin product imagery.
- Respect Android reduced-motion settings. All actions remain usable by touch, keyboard/focus and TalkBack.

## Layout and validation

- Primary target: 360 dp wide, with 320, 360 and 390 dp width checks and 560–800 dp usable height checks.
- Keep the dashboard compact and avoid unnecessary scrolling, but do not shrink primary data to hide overflow.
- Every menu item must have a unique content widget and an honest demo/live status.
- Run formatting, static analysis, widget tests, ARM64 release build and APK signature checks after changes.
- CI success is not physical-device visual verification. Record Xiaomi 11i screenshot comparison separately.

## Direction summary

- **Product:** Member intelligence and progress for a gym member.
- **Character:** Athletic, tactile, assured.
- **World:** Lavender pearl glass with deep violet chrome and semantic data colours.
- **Moments:** Attendance calendar, workout analytics, payment behaviour and body composition.
- **Signature:** One coherent purple glass system with bright semantic data and tier-specific member badges.
