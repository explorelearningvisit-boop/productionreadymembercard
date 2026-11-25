# BAD GYM — Cross-chat project handoff

Updated: 2026-11-25

## Repository and source of truth
- Repository: https://github.com/explorelearningvisit-boop/productionreadymembercard
- Active branch: `grok/purple-neon-member-dashboard`
- Approved specification: `docs/BADGYM_FINAL_APPROVED_DASHBOARD_MASTER_PROMPT.md`
- Rebuild plan/checkpoint: `docs/PIXEL_PERFECT_REBUILD_PLAN.md`
- Continue the existing Flutter dashboard. Do not create a parallel app or replace the UI with a screenshot.

## Product constraints
- Phone-first Flutter dashboard; target 360 dp width; regression widths 320 dp and 390 dp.
- Approved visual language: purple/violet/electric blue with gold accents, green success, full red payment-due state.
- Keep the existing member hero, check-in/freeze actions, payment/promo row, membership progress, four metric cards, six-item analytics rail, analytics panel and attendance calendar.
- Preserve working interactions. Do not invent APIs. Sample profile, dues and attendance values must remain explicitly sample data until backend integration exists.
- Do not claim pixel-perfect completion from compilation or widget tests alone.
- Do not perform broad destructive rewrites or delete original assets.
- User expects work to continue without asking them to repeat decisions already in the repository/spec.

## Latest verified branch/build
- Latest branch HEAD: `8d7eaff65fb7aad7b1c73f7cab4be579d0cc3fc9`
- Commit: `Fix BAD GYM CI formatting gate before APK build`
- Successful GitHub Actions run: #370, ID `45633404549`
- Run URL: https://github.com/explorelearningvisit-boop/productionreadymembercard/actions/runs/45633404549
- Verified steps: dependency resolution, Dart format, formatting check, Flutter analyze, widget tests, universal Android debug APK build, APK signature verification, artifact upload — all passed.
- Artifact ID: `15032601113`; artifact name: `bad-gym-android-apk`; expires 2026-12-09.
- APK SHA-256: `8ac221e2a21194c3ad0d38766b50966870d2c9eea77de2efb4ac570d4234dbdc`
- APK size: 175,598,932 bytes (about 168 MiB); ABIs present: arm64-v8a, armeabi-v7a, x86_64.
- This is a CI-signed debug/QA APK, not a production Play Store release.

## CI fix made in this chat
- Previous run #369 failed at `dart format --output=none --set-exit-if-changed lib test`; later stages were skipped.
- Workflow `.github/workflows/android-build.yml` was updated to format the CI checkout first (`dart format lib test`), then verify formatting, analyze, test, build and verify signature.
- Important: this formats the ephemeral CI checkout; it does not commit formatter changes back into the repository.

## Work still incomplete — do not mark done
1. Install and launch the latest APK on a real Android device. No ADB or Android emulator was available in the previous session, so runtime/device validation is not yet verified.
2. Capture actual Flutter screenshots at 320, 360 and 390 dp and compare against the approved reference.
3. The final approved reference screenshot is not yet committed to the repository.
4. Audit the remaining inbox/PulseVault images by actual pixels, alpha bounds, dimensions and duplicates; finish the asset manifest. Preserve originals.
5. Complete the visual QA/correction loop for shell geometry, image crops, spacing, typography and the analytics/calendar area.
6. Revisit full-dashboard scrolling and compactness against the approved specification; avoid a long-page feel and scroll only regions that genuinely need it.
7. Backend/API integration is not connected; keep sample-data labeling honest.

## Continuation instruction
Start by reading this handoff, the master prompt and rebuild plan; then inspect the current branch HEAD and latest Actions run before changing code. Continue the existing project in small, evidence-backed commits. After every meaningful change, run formatting, analyze, widget tests and APK build. Report separately what is implemented, CI-tested, visually verified and real-device verified. Never claim a phone run unless installation and launch evidence exists.
