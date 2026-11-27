# BAD GYM — Current product design direction

**Product.** A mobile-first gym member dashboard for members and gym staff to understand check-in, plan status, dues, attendance, workout activity, body progress and goals at a glance.

**Character.** Athletic, assured, warm and precise. It should feel like a considered fitness-club product, not a generic AI dashboard or a neon gaming interface.

**World.** A well-made premium training club: forest emerald, champagne metal, warm pearl, quiet espresso and tactile matte materials. The overall dashboard shell belongs to one coherent member-plan palette; the data workspace is calm, bright and neutral.

**Moments.** (1) The member identity and check-in/plan controls, where a contained emerald-and-champagne treatment carries the dashboard's identity. (2) The white/pearl analytics workspace, where charts, product artwork and meaningful status colours carry the visual richness.

**Signature.** A restrained champagne edge and emerald selection/progress cue that recur consistently across check-in, Freeze, member identity, horizontal KPI cards and the vertical rail. For other plans, shift this shared shell together as one palette rather than recolouring isolated components.

## Visual hierarchy

- **Member shell:** Check-in, Freeze, identity card, horizontal KPI card edges and vertical rail must share one plan-derived material and colour hierarchy. For the current Gold example use deep forest/emerald, champagne metal and restrained espresso. The Spark plan can lean greener; Silver can use its steel/slate identity. A member's plan changes the whole shell, not just the plan badge.
- **Data workspace:** Keep the large detail panel pearl-white or warm white with quiet neutral borders and restrained neutral shadows. Its surface must read as a distinct information area inside the member shell.
- **Semantic data colour:** Colour is meaningful, not decorative. Attendance statuses retain consistent meanings (present, absent, holiday, late); payment due, workout and body metrics may use distinct, readable supporting accents. Do not tint every surface with the same accent.
- **KPI cards:** Labels stay compact; values and trends remain prominent and aligned. Put the trend beside the value where space allows, then use a fine divider to separate data from the product artwork/offer. Preserve enough height for large, undistorted artwork.
- **Member identity:** The member name, ID and plan state remain the first-read identity. Keep portrait and details balanced, with visible plan and active states.
- **Navigation:** Horizontal KPI cards and vertical rail share the same shell hierarchy. Every selected item has an unmistakable state, and every item opens the corresponding data view.
- **Surface treatment:** Use soft neumorphic depth sparingly. Most content surfaces stay calm and matte; use one or two deliberate raised/focused moments. Avoid purple as the default dashboard colour, hue gradients on every card, outer glow, heavy shadows everywhere and gratuitous glass blur.
- **Typography:** Prefer clear, readable sans-serif text. Main member name, KPI values, payment amounts and calendar dates take priority over captions. Do not shrink important text to force a fixed layout.
- **Graphics:** Prefer the supplied PulseVault product/person assets. Keep aspect ratio and transparent edges. An asset must support the information or the campaign it appears in.
- **Advertising:** Treat each advert as one campaign unit with matching creative, offer copy, audience and action. Labels must read like real member offers, not internal placeholders such as “AD SPACE”. Mark sample campaigns as demo until an actual advertiser and offer are configured.
- **Motion:** Use brief, purposeful transitions for selection and campaign changes. Avoid endless pulses, flashing or motion that competes with the data; respect reduced-motion preferences.

## Layout and behaviour

- Primary target is 360 dp wide; verify 320 dp and 390 dp, plus compact heights starting at 560 dp.
- Preserve the compact member-card composition and avoid unnecessary vertical scrolling.
- Recover vertical space from duplicated captions, oversized gaps and low-priority padding before reducing primary text or artwork.
- Navigation and KPI cards must use shared selection state and open the correct, focused data section.
- History must show actual event types and chronology, not repeated advertising copy. Calendar dates and period labels must match the displayed month. Charts must describe the metric they actually plot.
- Until live services are connected, mark sample member and analytics values clearly as demo/sample data. Never describe sample data as live.

## Authority

This file captures the owner's latest Emerald + Champagne / pearl workspace direction. Where older project specifications still describe a purple-led shell, follow this file for new work and update conflicting legacy documentation when the related implementation is reviewed.
