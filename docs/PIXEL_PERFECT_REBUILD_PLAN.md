# BAD GYM — Pixel-Perfect Dashboard Rebuild Plan

## Working checkpoint
- Repository: `explorelearningvisit-boop/productionreadymembercard`
- Active branch: `grok/purple-neon-member-dashboard`
- Reference screenshot: user-provided portrait screenshot, 691 × 1536 px (includes Android status/navigation bars).
- Logical implementation target: 360 dp mobile width; validate 360 dp and 390 dp, plus narrow 320 dp regression.
- Design authority: this screenshot + audited transparent asset pack + existing purple/neon theme. Do not substitute the older crimson/gold design.
- Keep the current implementation and working behavior until each replacement is verified. No broad destructive rewrite.
- Sample member/payment/attendance values must remain clearly sample data until connected to a real API.

## Truthful current status (2026-11-24)
Implementation has started on the approved purple / violet / electric-blue direction. Latest verified CI checkpoint:
- Branch: `grok/purple-neon-member-dashboard`
- Latest implementation HEAD: `c12e62400fb203bdd19514c754ea93a0c2b29d15`
- GitHub Actions run `45358512382`: success (format, analyze, widget tests, release APK build and artifact upload).
- Artifact: `bad-gym-member-intelligence-c12e62400fb203bdd19514c754ea93a0c2b29d15`

Implemented in this increment:
- Added centralized shell, alert, progress and spacing tokens in `lib/theme/member_theme.dart`.
- Changed the dashboard outer frame and inner member surface to a continuous purple/violet/indigo gradient with gold/violet border treatment.
- Changed the member name and metadata to high-contrast light text on the dark surface.
- Changed Payment Due to a full crimson alert surface, white amount/label, warning icon and red alert styling in the reminder dialog.
- Rebuilt membership progress as a compact, semantic card with a visible green 22/30 fill and red days-left warning pill.
- Reworked Workout and Body KPI trend indicators to sit inline with the primary values; increased the available artwork region in the four metric tiles.
- Changed promotional shine effects from indefinite repeating loops to finite entrance passes; reduced-motion behavior remains supported.

Still incomplete / not verified:
- The generated final approved reference image is not yet committed as a binary file in the repository; the GitHub file connector used for this pass exposes text writes but not a binary upload path. The repository already contains the prior PulseVault reference asset, which is not being misrepresented as the newly approved generated image.
- PNG pixel inspection, dimensions, alpha bounds, crop/duplicate audit and contact sheet remain pending. GitHub's binary file fetch path did not return decoded pixels.
- Outer frame, profile, metric artwork sizing and spacing still need actual Flutter screenshot comparison against the approved generated image.
- Analytics rail and content panel have not yet received the full visual rebuild from the new reference.
- No emulator/device screenshot comparison or real-device install verification has been performed.
- Live backend/API integration remains out of scope for this UI-only increment; sample values remain sample values.

This checkpoint is a partial implementation, not a pixel-perfect or production-ready completion claim. Continue in thin increments and update this section only with fresh evidence.
 
## Reference composition inventory
1. Android status bar / app frame boundaries (do not recreate OS chrome inside Flutter).
2. Two-column action strip: green Check-in success with time and Freeze / Pause Plan promotion.
3. Member hero: portrait, member name, ID, age, gender, Gold Plan and Active badges.
4. Combined payment + whey offer row: Payment Due ₹500 on left; whey tub promotion on right.
5. Membership status: completed days / total days, days remaining and percentage progress.
6. Four compact metric/product tiles: Attendance + Whey, Workout + Creatine, Payment + SBI card, Body + Fat Loss.
7. Analytics workspace: vertical navigation rail (Attend, Insights, Cal, History, Trend, Goals); ad strip (Blinkit + LIVE); donut and Present/Absent/Holiday/Late breakdown; streak/best/month metrics and Recovery Combo offer.
8. Monthly attendance calendar: month summary, Train More banner, weekday labels and color-coded date cells (present, absent, holiday/off, selected).
9. Consistent outer frame, rounded white/lavender surfaces, purple neon edging, gold accents, emerald success, soft shadows and tight spacing.

## Non-negotiable implementation rules
- Build real Flutter widgets, not a full-screen screenshot background.
- Keep product/portrait artwork transparent and correctly cropped; never stretch or distort.
- Record source file, role, pixel dimensions, aspect ratio, alpha channel, crop bounds, output dimensions, output format and destination for every processed asset.
- Preserve originals under the inbox/raw-originals path. Do not delete or overwrite source assets.
- Use native Flutter for text, buttons, QR, charts, calendar, status, progress and navigation.
- Use animation only where it communicates state or hierarchy. Prefer transform/opacity, bounded durations, interruptible transitions and reduced-motion support. No perpetual high-cost animation.
- Payment reminder popup must clearly state that payment is sample-only until a payment API is connected.
- No dependency is added unless an existing Flutter primitive cannot satisfy the requirement; any package addition must pass compatibility, analyze, tests and build.
- Never mark a stage complete without a commit diff and fresh CI or reproducible local evidence.

## Staged execution plan

### Stage 0 — Repository and CI baseline (in progress)
- Verify branch HEAD, recent diffs, project instructions, current widget tree and existing test failures.
- Establish a known-good baseline and record current failures before visual work.
- Gate: latest commit CI passes format, analyze, widget tests and release APK build, or every blocker is explicitly recorded.

### Stage 1 — Reference and asset forensics
- Build a visual contact sheet of all 14 PulseVault PNGs and any already-mounted source pack.
- Inspect each file visually and extract dimensions, alpha bounds, format and duplicate similarity.
- Match each graphic to the screenshot inventory; mark uncertain mappings instead of guessing.
- Create `docs/ASSET_MANIFEST.md` with source → semantic name → crop/resize → destination → use.
- Create normalized production derivatives at target display sizes / 2× density where appropriate; retain originals.
- Gate: every visible promotional/product/portrait asset has an evidence-backed mapping and is registered in `pubspec.yaml`.

### Stage 2 — Design tokens and frame geometry
- Measure reference proportions, section gaps, card radii, border widths, shadows, typography scale, colors and image boxes.
- Define reusable Flutter tokens for spacing, radii, typography, gradients, borders and shadows.
- Derive sizes from constraints; no tablet-first fixed-width layout.
- Gate: 360 dp and 390 dp geometry has no overflow and matches measured section proportions.

### Stage 3 — Top action strip + member hero
- Rebuild Check-in and Freeze cards, including green success badge and snowflake/bottle art.
- Rebuild portrait frame/crop, member metadata and Gold/Active pills.
- Verify text baseline, avatar size, spacing and badge dimensions against reference.
- Gate: focused widget tests and screenshot comparison.

### Stage 4 — Payment + whey promotion + membership
- Compose payment due and whey promotion side-by-side in the same row at the target width.
- Fit product art without clipping; tune text, offer pill and CTA.
- Rebuild membership label, days-left value and animated progress.
- Add accessible payment reminder dialog; do not imply online payment is connected.
- Gate: payment dialog interaction test, responsive layout tests and screenshot comparison.

### Stage 5 — Four KPI / product cards
- Implement four equal-width cards with distinct semantic colors and correct product/card graphics.
- Match title, large metric, trend, image crop, offer chip and glow/border treatment.
- Verify narrow-width text scaling and hit targets.
- Gate: each card has independent tests and visual evidence.

### Stage 6 — Analytics rail and overview
- Rebuild vertical rail, ad strip, LIVE badge, attendance donut, legend/bars, streak/best/month strip and recovery promo.
- Keep the chart native and data-driven; do not flatten it into a bitmap.
- Add section transitions with reduced-motion handling.
- Gate: every rail item opens its correct panel; no overflow at 320/360/390 dp.

### Stage 7 — Monthly calendar
- Rebuild month title/summary, Train More ad, weekday labels and date cells.
- Implement present/absent/holiday/off/selected states and accessible labels.
- Gate: date-state tests and screenshot comparison.

### Stage 8 — Motion, interaction and accessibility pass
- Check-in feedback, freeze/resume, payment reminder, banner CTA, navigation and calendar interactions.
- Add only purposeful micro-interactions; profile/dashboard entrance motion must not delay content.
- Respect reduced motion and mid/low-end Android frame budget.
- Gate: interaction tests, semantics/touch target review and animation performance check.

### Stage 9 — Whole-dashboard visual QA
- Capture emulator screenshots at 360 × target height and 390 dp; include 320 dp regression.
- Compare with the reference using aligned crops and pixel/structural diffs; inspect section boundaries, image crops, type, spacing, color and shadows.
- Fix the largest visual mismatches first and repeat until remaining deviations are documented.
- Gate: screenshot evidence + complete checklist; no claim of pixel-perfect without this.

### Stage 10 — Release verification
- Run clean format, analyze, full widget tests and release APK build on latest HEAD.
- Verify APK artifact SHA, size, timestamp and install/run evidence where available.
- Distinguish CI-built APK from device-install and production-signing approval.
- Gate: latest HEAD green and artifact link verified.

## Current checkpoint / next action
Latest recorded code HEAD before this plan: `47103cb5e2364aa5c0b34283b51a715a03d1fe9a`.
A follow-up test fix is being committed to scope the ₹500 assertion to the payment dialog; rerun CI on that new HEAD before proceeding to Stage 1.
