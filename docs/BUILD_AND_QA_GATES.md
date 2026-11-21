# Build and QA Gates

## Visual authority
- The approved purple-neon BAD GYM dashboard reference is the composition and color authority.
- Use the two supplied asset sheets only as source material for individual assets; never ship a flattened reference screenshot as the UI.
- Preserve the purple/white glass treatment, purple neon accents, green attendance success, red absence/payment warning, gold plan badge, and blue body metric.

## Required implementation
1. Brand header, check-in status, Freeze control, notification indicator.
2. Member portrait, identity, plan and active state.
3. Payment due, days remaining, expiry date, member QR and membership progress.
4. Big Billion Sale promo banner.
5. Four compact KPI cards: Attendance, Workout, Payment, Body.
6. Attendance Intelligence: vertical rail, overview, attendance ring, Present/Absent/Holiday/Payment rows, streak, trophy and trend.
7. Gym-floor footer decoration.

## Engineering gates
- 360dp is the primary phone baseline; 320dp must remain usable.
- Real Flutter widgets for text, metrics, progress, status and navigation; QR must be generated from member data.
- Individual transparent image assets only. Do not rely on sprite-sheet painters for final UI assets.
- Demo member values must remain explicitly sample data until connected to APIs.
- Keep assets correctly named, tightly cropped, alpha-preserving and optimized for mobile.
- Run Dart format, Flutter analyze, widget tests at 320dp and 360dp, then release APK build.
- Device QA requires installation on the target Xiaomi 11i, launch verification, screenshot comparison and logcat review.
- Report CI, APK availability, signing, device installation, launch and visual fidelity as separate outcomes. A green CI build alone is not a production-ready claim.
