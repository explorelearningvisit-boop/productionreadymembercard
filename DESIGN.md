# BAD GYM — Current product design direction

**Product.** A phone-first gym member dashboard for members and gym staff to understand plan status, check-in, dues, attendance, workout activity, body progress and goals at a glance.

**Character.** Athletic, assured, warm and precise. It should feel like a considered fitness-club product, not a generic AI dashboard or a neon gaming interface.

**World.** A premium training club with a plan-specific member shell and a quiet pearl information workspace. The shell follows the member's purchased tier; ads and campaign artwork retain their own brand palettes.

## Member-plan colour contract

| Plan | Shell and rail | Inner canvas | Active accent |
|---|---|---|---|
| Gold | Metallic gold / amber, dark bronze rail, champagne rim | Warm pearl and cream | Deep gold with a pale-gold selected state |
| Silver | Cool steel and silver rail | White and cool mist | Steel blue / silver |
| Diamond | Ice blue, silver-blue rail and icy rim | Pearl white and pale blue | Cyan / ice blue |
| Spark | Forest green and emerald rail | White, mint and pale green | Emerald / lime |

Plan identity is derived from the member's plan record. A tier changes the full member shell coherently; it must not change operational status semantics. Present remains green, absent rose, holiday violet and late amber. Payment due remains rose. Advertising is not recoloured to match a plan.

## Visual hierarchy

- **Member shell:** Check-in, Freeze, identity, membership progress, KPI module cards and the vertical rail share the active member-plan palette.
- **Data workspace:** Keep the analytics/detail workspace pearl-white or warm white with quiet borders and restrained shadows.
- **Member identity:** Name, member ID, plan and active state remain the first-read identity. Portrait proportions and the name baseline must not be compressed by decorative backplates.
- **KPI cards:** Attendance, Workout, Payment and Body are the four primary modules. Values lead; captions and product campaign strips remain secondary.
- **Navigation:** Selecting a KPI changes the six-item contextual rail. Each rail item opens the matching module-specific panel. Module changes reset the submenu to that module's overview. Both navigation surfaces share one state.
- **Campaigns:** Keep each advert as one paired creative, offer and action. Demo campaign cards must disclose that purchase/merchant destinations are not connected. Never invent advertiser relationships or live discounts.
- **Surface treatment:** Use soft raised surfaces sparingly. Use a contained outer rim and one or two deliberate depth moments. Avoid universal glow, excessive blur and rainbow gradients.
- **Typography:** Main member name, payment amount, KPI values, attendance percentage and calendar dates take priority. Do not shrink primary text to hide an overflow.
- **Graphics:** Use the supplied PulseVault assets, preserve aspect ratio and transparent edges, and do not hot-link arbitrary artwork at runtime.

## Motion and interaction

- Use 160–220 ms ease-out transitions for hover, focus and selection, and a short fade/slide transition when the detail panel changes.
- Product cut-outs may use a one-shot entrance plus subtle perspective tilt on hover and a tiny pressed response on touch.
- Do not continuously spin product bottles, rotate text or animate whole cards indefinitely.
- Honor Android's reduced-animation preference. Motion must never carry information needed to complete an action.
- Hover is progressive enhancement for pointer devices; every action must remain usable by touch and keyboard/focus.

## Layout and behaviour

- Primary target is 360 dp width. Verify 320, 360 and 390 dp widths and usable heights from 560–800 dp.
- Preserve the compact, no-unnecessary-scroll composition. Recover space from duplicated captions and low-priority padding before reducing primary text or artwork.
- Keep six clearly tappable contextual rail destinations; every one must open a unique content view.
- Calendar dates and labels must agree with the displayed period. Charts must describe the metric they actually plot.
- Until live services are connected, mark sample member, analytics, goals and campaign values as sample/demo. Never describe sample data as live.

## Direction summary

- **Product:** A member intelligence card for a gym member and their club team.
- **Character:** Athletic, calm, premium and trustworthy.
- **World:** A plan-coloured membership shell around a bright pearl data workspace.
- **Moments:** Member identity, four KPI modules, contextual rail, and the attendance analytics calendar.
- **Signature:** Plan-tier metal colour, clear operational status colours, supplied fitness artwork and restrained tactile depth.
