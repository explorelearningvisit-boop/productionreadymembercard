# BAD GYM — Member Intelligence V1

Flutter implementation of the approved Purple + Gold BAD GYM member dashboard reference.

## Visual authority
- The approved user-provided dashboard screenshot is the sole composition reference (691 × 1536 px).
- Do not redesign the hierarchy or introduce unrelated dashboard concepts.
- This V1 builds the UI with native Flutter widgets, gradients, borders, shadows, typography and programmatic indicators. It does not use a flattened screenshot as the screen.
- All shown member values are sample/demo data pending API integration.

## Run
```bash
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter run
```

## V1 scope
- Big Billion Sale banner
- Check-in and Freeze status/action strip
- Member identity and Gold plan/Active state
- Payment due, days remaining, expiry and QR-style placeholder
- Early payment offers and membership progress
- Four sponsored metric tiles: Attendance, Workout, Payment and Body
- Attendance analytics panel with vertical rail, summary, calendar and legend
- Lavender/Purple/Gold neon frame and bottom quick actions

## Responsive behavior
- 360 dp phone width is the primary design target.
- 320 dp compact viewport is covered by widget tests.
- Content remains vertically scrollable; it is not forced into a fixed-height canvas.
- SafeArea is applied outside the dashboard frame so status/navigation bars do not clip the border.

## Known V1 limitations
- This is a visual/UI V1; backend, real QR encoding, live attendance and payments are not connected.
- Existing repository images under `assets/images/` are now registered with Flutter; the profile hero uses `member_hero.webp` with a safe fallback.
- The separate BADGYM Asset Pack v3 has been audited: 26 transparent RGBA PNGs plus a manifest and review sheets. Its high-resolution binary files are staged as a separate package; they are not falsely represented as already committed to this branch.
- The older `assets/images/individual/*.png` directory contains 44 placeholder entries with one identical Git blob SHA; these are not used by the V1 UI and must not be mistaken for the verified v3 artwork.
