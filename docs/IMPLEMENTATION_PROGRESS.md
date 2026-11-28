# BAD GYM — Emerald Pearl implementation progress

Updated: 2026-11-28  
Branch: grok/purple-neon-member-dashboard  
Resume rule: verify current HEAD and latest CI before trusting this ledger.

## Approved visual and behavior
- Emerald + Pearl master remains current; specification in docs/BADGYM_EMERALD_PEARL_VISUAL_MASTER_SPEC_2026-11-28.md.
- Four KPI states: Attendance, Workout, Payment, Body; one dashboard and four contextual lower-panel views.
- Main app cycles through the four KPI states every 3 seconds. A thin line below the KPI row fills from zero to full; no countdown number.
- Center arrow toggles the lower workspace between contextual rail/details and a simple quick snapshot for users who prefer less information.
- Manual KPI taps remain enabled. Reduced-motion or non-resumed lifecycle pauses the timer.
- Compact row budgets reclaim about 20dp net on the 360dp target while retaining labels/values.
- Sponsored product artwork uses finite entrance motion; no perpetual animation.

## Previous verified checkpoints
- Stage 1 Emerald/Pearl theme verified by Build #720 on c23eb0a779d00e973d76e6838341e93ceb0952d0.
- Original PulseVault metadata audit Build #722 (16/16 files) and source-image review Build #723 completed.
- Earlier report: docs/PULSEVAULT_ASSET_AUDIT_2026-11-28.md.
- Live Git tree inspection confirmed PulseVault/optimized does not exist. The derivative generator was not delivering unique creative art and is withdrawn.

## Current change batch
- Timer + centered details toggle + quick snapshot mode: commit ba8d4c7e36902d5f3f7447046fd942d15b718cde.
- Campaign asset path migration, finite ad-art entrances, increased image slots, native fallback for cropped dumbbell campaign, and new widget tests: commit ef65e9ed67ab4c8c4492052c16ea4d0615458348.
- Owner quality rule is mandatory in AGENTS.md and docs/ASSET_ORIGINALITY_AND_QUALITY_POLICY.md: no duplicates, no fake 8K, unique concept first, true transparency/edge checks and provenance.
- Previous generator made low-value copies of existing artwork; its script and auto-commit workflow are being removed. No optimized/ binary files were present in the live Git tree despite earlier claims.

## Validation state
- Latest verified app CI: **Build #733 SUCCESS** on commit `f413dc9c34fe2976e91e46ada5d61f099f865d2a`.
- Build #733 passed: original PulseVault audit + source archive, Dart format, Flutter analyzer, full widget tests (including compact 320×560 / 360×780 responsive layouts, auto-rotation, timer progress and detail toggle), ARM64 release APK build, APK signature verification and artifact upload.
- The initial test failures were corrected in focused commits: analyzer import fixes (`413ab34`), const lint (`0247c95`), narrow KPI ad footer width (`fa24060`, `e41b583`), compact header breakpoint and Freeze/member identity height budgets (`e48618b`), conditional Text const (`f413dc9`). No tests were disabled or weakened.
- Build #733 APK: 19,189,331 bytes; SHA-256 `f48548f08cf3e39867796bb0949ecb5cfa6bf29ea64858b2e1ee9e8f38be9b19`; `lib/arm64-v8a/libapp.so` and `libflutter.so` verified in package; apksigner verification passed.
- GitHub artifact: `bad-gym-member-card-arm64-release`, artifact ID `15266626403`; run https://github.com/explorelearningvisit-boop/productionreadymembercard/actions/runs/46152936686.
- Firebase Test Lab/App Distribution skipped because required Google/Firebase credentials are not configured.
- Physical Xiaomi device install/launch and actual reference screenshot overlay/diff remain pending. CI/widget viewport tests are not device or pixel-perfect certification.
- No new unique art generated. The owner’s originality/8K/real-alpha policy remains mandatory; the old duplicate derivative generator is withdrawn.

## Next action
1. Inspect asset generation workflow and verify all nine optimized files are actually committed to the branch.
2. Inspect Android workflow's true-alpha/dimension audit artifact.
3. Review format/analyzer/widget test and ARM64 APK/signature/artifact results.
4. Only after CI passes, render 320/360/390dp and perform reference overlay/diff.
5. Record exact commit/run results here and in docs/CHAT_HANDOFF.md.

- 2026-11-28: Owner mandated unique artwork only, 8K-quality master targets, true transparency/edge verification and no repetitive low-quality WebP duplicates. Durable rule stored in AGENTS.md and docs/ASSET_ORIGINALITY_AND_QUALITY_POLICY.md.
- 2026-11-28: Live Git tree had no optimized binaries; earlier statement that these were uploaded was inaccurate. Duplicate derivative workflow withdrawn.


## Latest successful checkpoint — Build #733
- Current code commit: `f413dc9c34fe2976e91e46ada5d61f099f865d2a`.
- GitHub Actions: Build #733 SUCCESS — https://github.com/explorelearningvisit-boop/productionreadymembercard/actions/runs/46152936686
- Passed: original asset metadata audit, source asset archive upload, formatting, analyzer, widget tests, coverage upload, ARM64 release build, signature verification, installable artifact upload.
- Widget suite covers: four dashboard module states/navigation, three-second progress sweep and auto-advance, center details expand/collapse, reduced-motion handling, 320×560/320×640/360×600/360×700/390×720/800×600 layout cases and payment panel states.
- APK artifact ID: 15266626403 (`bad-gym-member-card-arm64-release`); size 19,189,331 bytes; SHA-256 `f48548f08cf3e39867796bb0949ecb5cfa6bf29ea64858b2e1ee9e8f38be9b19`.
- Verified APK contains `lib/arm64-v8a/libapp.so` and `lib/arm64-v8a/libflutter.so`; signature check passed.
- Firebase Test Lab/App Distribution skipped because credentials are not configured.
- Remaining: physical-device validation and actual screenshot overlay/diff across the four approved views. Do not claim pixel-perfect until measured capture comparison is complete.
