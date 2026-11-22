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
- Some promotional product art and the bodybuilder illustration are represented by native symbols/emoji until approved, individually verified source PNGs are added.
- A local asset archive is not treated as committed repository assets unless its binary files are actually present in this branch.
