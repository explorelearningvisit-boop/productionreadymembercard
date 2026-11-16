# ChatGPT Design Lab — Branch Specification

## Authority
This branch implements the user's supplied festive yellow BAD GYM Member Intelligence reference as an independent evaluation app. It does not modify or supersede `main`.

## Product layout
1. Compact brand header with search, notifications and QR scan affordances.
2. Member card: portrait placeholder, CHECKED-IN badge and timestamp above identity, member metadata, Active and Gold Plan badges, membership progress and expiry.
3. Sponsored campaign strip above metrics.
4. Four horizontal metric cards: Attendance, Workout, Payment, Body.
5. Narrow contextual vertical rail, only beside the intelligence workspace.
6. Right-side bounded workspace. Attendance defaults to calendar; rail swaps Calendar, Trend, Record, Insight, Goal and More in place.
7. Compact attendance intelligence: 81% ring, Present/Late/Absent/Holiday breakdown with progress bars, streak and best streak, calendar chips.

## Design tokens
- Canvas: #FFF8D9
- Surface: #FFFEF9
- Festival yellow: #FFD21A
- Gold: #E7A900
- Ink: #211D16
- Success/present: #168B35
- Alert/absent: #D92D2D
- Late: #E7A900
- Holiday: #913BE0
- Body info: #1688D4
- Typography: Poppins for headings, Inter for body (repository bundled fonts).

## Responsive rules
- Mobile-first; target 360dp width.
- No horizontal member previews.
- Rail target 48dp and only alongside the selected workspace.
- Compact spacing before shrinking legible text.
- Workspace takes remaining bounded height; calendar grid must never create vertical page scrolling.
- Keep the four horizontal metric tabs visible.

## Separation and installation
- Android applicationId: `com.badgym.designlab`.
- Never uninstall or clear production BAD GYM data.
- No production backend writes from sample UI.
- Reuse network tooling only via documented safe setup; no secrets copied into Git.

## Validation status
Initial implementation committed; CI/device validation pending. Do not claim pixel-perfect until screenshots from the Xiaomi 11i are compared against the reference.


## 2026-11-16 — User-approved Gold Premium full dashboard implementation
- The user explicitly selected **Festive Gold Premium** and full-dashboard scope for this isolated Design Lab branch. This branch decision does not silently change `main` or the production package.
- Retain the 360dp compact header/profile/sponsor/four-tab/workspace information architecture and use warm ivory, festival gold, emerald success, red alert, amber late and neutral grey OFF/holiday semantics.
- `lib/main.dart` now renders distinct Attendance, Workout, Payment and Body workspaces, with dedicated rail destinations rather than generic empty placeholders. Existing member portrait, dumbbell logo, shaker and 3D illustrations are referenced as assets.
- Attendance includes calendar, trend, record, insights and goal views. Sundays render neutral OFF; present/late/absent remain green/amber/red.
- Workout, Payment and Body surfaces display only currently available member metrics. Missing workout set/load history, payment transaction history and body measurement history are explicitly identified as not connected; do not fabricate records.
- CI run: https://github.com/explorelearningvisit-boop/productionreadymembercard/actions/runs/43925111976
- Format: PASS; analyze: PASS; Flutter tests: PASS. Android APK build: PASS; artifact 14255597205 uploaded and extracted. SHA-256: `f159b4925f78480d65e6979100c48b7a6d26575877aa2071f81cbd7330d8ede0`. Physical Xiaomi screenshot comparison/install: NOT VERIFIED.
- Do not claim pixel-perfect. Next: finish APK build, inspect generated artifact, then compare fresh Xiaomi 11i screenshot against supplied references and iterate remaining visual differences.
