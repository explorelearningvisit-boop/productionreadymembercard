# BAD GYM Member Dashboard — Visual Authority

## Master reference
The user's latest 864 × 1536 purple-neon dashboard screenshot is the composition authority. The two supplied asset-library sheets are the source of visual assets and styling cues; do not replace them with unrelated UI concepts.

## Required hierarchy
1. BAD GYM wordmark and fitness-management subtitle.
2. Completed check-in/time, Freeze action, notification indicator.
3. Member portrait, welcome line, name, ID, age, gender, plan and active state.
4. Payment due, days remaining, expiry date and QR marker.
5. Membership elapsed/total days and progress.
6. Big Billion Sale promotional banner.
7. Four compact metric cards: Attendance, Workout, Payment, Body.
8. Attendance Intelligence with vertical rail (Home, Attend, Workout, Pay, Offers, History), Home overview, check-in time, attendance ring, Present/Absent/Holiday/Payment progress rows, streak, trophy and trend.
9. Gym-floor decorative finish.

## Engineering constraints
- 360dp width is the primary phone baseline. 320dp must remain usable.
- All text, metrics, progress, status, navigation and QR data must be real Flutter widgets and remain data-driven when backend integration is added.
- Use decorative image assets only as individual transparent assets; never flatten the whole dashboard or a composite asset sheet into the screen.
- Use native Flutter gradients, clipped glass panels, shadows and custom painting for scalable surfaces and decorative effects.
- Keep motion short and purposeful; respect reduced-motion settings when animation expands beyond implicit transitions.
- Demo values must be clearly treated as sample data until connected to member APIs.

## Current state
This branch is a fresh purple-neon Flutter UI implementation. The visual asset library is available in the working asset pack, but the individual source assets still need to be committed into the repository and wired to their intended widget slots. Do not claim the full asset library is integrated until that is done and visually checked on-device.
