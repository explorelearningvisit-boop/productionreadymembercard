# BAD GYM — Emerald Pearl implementation plan

Visual master: docs/BADGYM_EMERALD_PEARL_VISUAL_MASTER_SPEC_2026-11-28.md  
Resume record: docs/IMPLEMENTATION_PROGRESS.md  
Branch: grok/purple-neon-member-dashboard

| Stage | Work | Acceptance |
|---|---|---|
| 0 Visual lock | Spec, DESIGN, tokens, wireframe, prompt, handoff | Authority fixed |
| 1 Theme tokens | MemberTheme/MemberPlanPalette/tests | Emerald/Pearl actual Flutter theme |
| 2 Asset pack | PulseVault alpha/dim/crop audit and missing art | Real alpha, ratio, manifest/pubspec |
| 3 Shell/identity | Frame, check-in, Freeze, profile | 360dp top aligned |
| 4 Payment/membership | Due, offer, progress | One Days Left, no AD |
| 5 KPI row | Four equal cards | Semantic fills/art |
| 6 Intelligence | Rail, ring, legend, stats, offer, calendar | Correct default and six destinations |
| 7 Motion/accessibility | Native motion, semantics, reduced motion | Focused tests, no loops |
| 8 Pixel QA | 320/360/390 captures + diff | Measured geometry, no overflow |
| 9 Android QA | Format/analyze/tests/ARM64/signature/SHA | CI gates pass |
| 10 Device | Xiaomi 11i install/launch/capture | Separately recorded |
| 11 Backend | Auth and real data/actions | Never faked during UI scope |

Reference 841×1870px, ratio 0.4497; full logical device 360×800dp. Dashboard uses SafeArea and real OS bars. Verify 320/360/390dp and 560–800dp usable heights. No scrolling/clipping/stretched art/overflow at 360dp.

No app identity/signing changes, unrelated refactor, web runtime, unnecessary package, fake live data, screenshot background, mass asset deletion or production release claim without separate signing/device validation.
