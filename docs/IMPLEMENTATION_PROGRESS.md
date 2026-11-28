# BAD GYM — Emerald Pearl implementation progress

Updated: 2026-11-28  
Branch: grok/purple-neon-member-dashboard  
Resume rule: Verify actual HEAD and CI before trusting this ledger.

## Owner direction locked
- Approved visual: Emerald + Pearl dashboard generated 2026-11-28.
- Source 841×1870px, ratio 0.4497.
- SHA-256 d49be4260ddb9fe1f9f5424af58a5e7c0f09cc261b20a5d4a5dbf8e4d409f740.
- Logical reference 360×800dp full device with SafeArea/system bars.
- Forest emerald frame/rail, pearl workspace; Gold badge, ice Freeze, mint Attendance, lavender Workout, sky Payment, mint Body.
- Purple Neon/Lilac superseded.

## Checkpoint
- Stage 0 visual spec: complete in this checkpoint.
- Stage 1 theme migration: implementation/CI verification pending.
- Stage 2 PulseVault alpha/dimension/crop audit and transparent asset pack: **next stage; not started**.
- Stage 3 shell/check-in/Freeze/profile: pending after Stage 2.
- Stages 4–11 pending.

## Previous baseline
- Last previous-theme commit 1c3ca6cf06e2035d39122a40909b8335e5da9e65.
- Build #717 passed format, analyzer, widget tests, ARM64/signature and artifact upload; Test Lab/App Distribution skipped due credentials.
- Previous pre-Emerald APK is not the new build. New Stage 1 ARM64 QA APK from Build #720 has SHA-256 8f2c80749bde3b8fdb43ea1c28dcdf0e98c112ff9b10d2f51e03730a9a004511, size 19,189,131 bytes; apksigner verification passed. Firebase Test Lab/App Distribution skipped due missing credentials.

## Next action
1. Verify live HEAD.
2. Inspect Actions run/logs.
3. Fix evidenced failures only; never weaken tests.
4. After Stage 1 CI passes, inventory dimensions/alpha/crop for all PulseVault art; generate only missing cut-outs per Section 7.
5. Update this ledger and CHAT_HANDOFF after every stage.

## Stage log
- 2026-11-28: Emerald/Pearl visual direction and spec prepared.
- 2026-11-28: Stage 1 Emerald/Pearl theme migration + component surfaces committed; Build #719 failed on one undefined identifier, fixed in c23eb0a; Build #720 passed format, analyzer, widget tests, ARM64 release build, signature verification and artifact upload.
