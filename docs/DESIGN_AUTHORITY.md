# BAD GYM dashboard — current design authority

## Visual target
- Current target is the user's latest purple-neon BAD GYM dashboard reference.
- Keep the member screen's information hierarchy: brand, check-in/freeze, member profile, plan/status, payment/expiry/QR, membership progress, promotion, four metric tiles, Attendance Intelligence and its vertical rail, attendance breakdown and gym-floor decorative finish.
- The member example currently shown is Ashwani Kumar Singh / BG215; retain the sample values only as demo data, not as hard-coded production member records.
- Use the compact phone viewport first (360dp baseline). Scale layout with constraints rather than stretching a screenshot.

## Implementation rules
- Rebuild UI using Flutter widgets, gradients, shapes, text, Material icons and dynamic progress/chart primitives.
- Do not use a flattened dashboard image as a screen background.
- Dynamic text, icon choices, statuses, progress, navigation, QR, charts and banners must remain code-driven and data-bound.
- Decorative photography/illustration may use transparent PNG assets. A checkerboard preview is not proof of alpha transparency; validate alpha before using a supplied sprite sheet as a production asset.
- The currently supplied composite sheets are retained as visual reference only; do not crop or present the whole sheet as a single live dashboard asset.
- The existing member portrait is retained pending delivery of a separately approved transparent portrait asset.

## Rebuild history
- The prior green dashboard widgets were removed from the new rebuild branch.
- The current branch implements the purple-neon visual system as a native Flutter screen; it is a first implementation pass and must pass CI plus on-device screenshot comparison before being called pixel-perfect.
