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
- Latest app code CI: Build #727 failed in analyzer. Diagnostics: missing MemberTheme import in dashboard_campaigns.dart and missing ArtworkEntrance import in module_dashboard_views.dart. Tests/APK skipped; targeted fix is next.
- Optimized asset binary commit and alpha report: pending.
- Screenshot overlay/diff and physical Xiaomi device verification: not yet run.
- New APK: pending. Do not reuse Build #720 as the latest UI build.

## Next action
1. Inspect asset generation workflow and verify all nine optimized files are actually committed to the branch.
2. Inspect Android workflow's true-alpha/dimension audit artifact.
3. Review format/analyzer/widget test and ARM64 APK/signature/artifact results.
4. Only after CI passes, render 320/360/390dp and perform reference overlay/diff.
5. Record exact commit/run results here and in docs/CHAT_HANDOFF.md.

- 2026-11-28: Owner mandated unique artwork only, 8K-quality master targets, true transparency/edge verification and no repetitive low-quality WebP duplicates. Durable rule stored in AGENTS.md and docs/ASSET_ORIGINALITY_AND_QUALITY_POLICY.md.
- 2026-11-28: Live Git tree had no optimized binaries; earlier statement that these were uploaded was inaccurate. Duplicate derivative workflow withdrawn.
