# BAD GYM Member Dashboard — Visual Authority

## Master reference
The approved purple-neon BAD GYM dashboard screenshot (1024 × 1536) is the composition authority. The two supplied asset-library sheets are source material for reusable visual assets. Do not replace the reference with unrelated concepts or flatten the complete screen into a background image.

## Required hierarchy
1. BAD GYM wordmark and fitness-management subtitle.
2. Completed check-in/time, Freeze action, notification indicator.
3. Member portrait, welcome line, name, ID, age, gender, plan and active state.
4. Payment due, days remaining, expiry date and QR marker.
5. Membership elapsed/total days and progress.
6. Big Billion Sale promotional banner with equipment artwork.
7. Four compact metric cards: Attendance, Workout, Payment, Body.
8. Attendance Intelligence with vertical rail (Home, Attend, Workout, Pay, Offers, History), Home overview, check-in time, attendance ring, Present/Absent/Holiday/Payment progress rows, streak, trophy and trend.
9. Gym-floor decorative finish with equipment and plants.

## Engineering constraints
- 360dp width is the primary phone baseline. 320dp must remain usable.
- All text, metrics, progress, status, navigation and QR data must be real Flutter widgets and remain data-driven when backend integration is added.
- Use individual transparent image assets with meaningful names; never render a composite asset sheet or full reference screenshot as the UI.
- Prefer native Flutter gradients, clipped glass panels, shadows and custom painting for scalable surfaces and decorative effects.
- Keep motion short and purposeful. Demo values must be clearly treated as sample data until connected to member APIs.
- Preserve asset aspect ratio and tight alpha bounds; avoid arbitrary sprite-cell crops for the final asset library.

## Current implementation status
The Flutter dashboard hierarchy and purple theme are present. The latest CI build passed, but this is not proof of visual fidelity or final asset integration. The sprite atlases and their CustomPainter widgets are still in the branch. Individual source assets, naming, transparency, crop quality, and on-device screenshot matching remain open verification gates.
