# BAD GYM — Screenshot Fidelity QA / 2026-11-27

## Target reference
Owner-provided 691 x 1536 screenshot uploaded in this conversation on 2026-11-27. This is the visual source of truth for the Gold Plan default Attendance view. It includes Android status/navigation system bars; compare the in-app content region separately from OS chrome.

## Verified repository state
- Repository: explorelearningvisit-boop/productionreadymembercard
- PR: #12 (Draft; open; not merged)
- Base: grok/purple-neon-member-dashboard
- Head: grok/reference-glass-layered-dashboard
- Head commit: 34a820c8108f5455d699b54b23f67213230b5d2a
- Latest CI run inspected: Build #634, run 45983709563, success on the PR head
- ARM64 APK artifact: bad-gym-member-card-arm64-release, artifact ID 15190990900, 18.5 MB APK (artifact ZIP 10,687,531 bytes)
- Build log SHA-256 for APK: aa67b7632d113de2fdf01d568d8fb084807ee7439fc91d96fbaa834b268578b1
- Artifact ZIP SHA-256: 4156629792bf07e62422da6d5597d73b8116faeeda1b54b9675693ff494a9ef0
- APK signature check passes v2, but signer certificate CN=Android Debug. This is a QA/debug signing identity, not proof of production release signing.
- Firebase Test Lab and Firebase App Distribution steps were skipped because Google Cloud / Firebase credentials are not configured.
- No physical-device screenshot capture or screenshot-diff result is attached to Build #634.

## Code and design checks completed
- Current Gold plan shell uses forest emerald, champagne rim, warm pearl canvas, deep wine rail (#6D0201 to #3A080D), and warm gold selected item (#FDE870).
- PulseVault canonical runtime directory exists and pubspec.yaml declares 14 files. Direct Dart asset references inspected are in the same PulseVault directory.
- Dashboard source includes Check-in/Freeze, member identity, payment and offer, membership progress, four KPI modules, contextual rail and analytics workspace.
- Contextual rail source defines five destinations each for Attendance, Workout, Payment and Body.
- Widget tests exercise module switching, submenu navigation, sizes 320x560, 320x640, 360x600, 360x700, 390x720 and 800x600, repeated check-in taps, and repeated mount/dispose.
- Unslop skill is present in .agents/skills/unslop/; project AGENTS.md routes UI work through its nine passes. Flutter adaptations are documented in docs/FLUTTER_UI_UX_SKILL_APPLICATION.md.
- Build #634 logs show format passed, analyze completed successfully, all 12 tests passed, ARM64 APK built, APK v2 signature verified, and artifact upload succeeded.

## Pixel-fidelity status
NOT CERTIFIED. CI/widget tests establish build correctness and tested behavior; they do not establish device-level visual equality with the 691x1536 reference. The GitHub Actions workflow did not capture a device screenshot or calculate a perceptual/pixel diff.

## Outstanding gates before claiming pixel-perfect
1. Install this exact artifact on the target Android phone (or a same-density device) and capture the rendered screenshot with known display density and system-bar insets.
2. Normalize the screenshot to the app-content viewport (exclude/compare OS status and navigation bars separately) and create an overlay/difference report against the owner reference.
3. Inspect the major regions: action-row proportions/artwork, portrait crop and name baseline, payment/whey row, membership progress height, KPI cards and image scale, rail width/item rhythm, analytics ring/legend, offer strips and calendar cell grid.
4. Correct only evidenced mismatches; preserve source data and avoid invented live records.
5. Re-run formatting, analysis, widget tests, ARM64 build, and signature gate once after the focused corrections.
6. Confirm production signing configuration separately. Do not add or expose keystores, passwords, service-account files or secrets in source control or logs.

## Current decision
Keep PR #12 as Draft and unmerged. Do not repeatedly rerun CI without a code or configuration change. Report device screenshot comparison as blocked until an actual target-device capture is available.