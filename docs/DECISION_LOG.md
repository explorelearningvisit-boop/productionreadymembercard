# BAD GYM — Dated Product & Engineering Decision Log

Append new accepted decisions; mark old choices superseded instead of deleting history.

## 2026-11-16 — Cross-network development connectivity
- User requires laptop and Xiaomi to work across same home Wi-Fi; laptop on user's own hotspot; laptop on third-party hotspot; user's hotspot shared onward through another phone; USB tethering; Ethernet; phone mobile data; and arbitrary transitions.
- Decision: network-agnostic architecture. No same-LAN, mDNS, DHCP-IP or fixed-port assumption. Tailscale is preferred private overlay. mDNS is optional LAN hint only.
- Tailscale Online does not prove ADB reachability, pairing or authorization. Pairing port and Wireless Debugging connect port differ. Connect port is dynamic.
- Xiaomi 11i 5G (21091116I), Android 13/MIUI. Previously observed Tailscale IP 100.123.18.54 and USB serial zxdada69gunb7ls4; verify live. Latest user-reported connect port 37337 is transient.
- Android may disable Wireless Debugging after phone power-off; user will re-enable it. Do not give generic debug-toggle instructions without evidence; user is an experienced developer.
- Dynamic endpoint discovery is documented target, NOT implemented. Workflow still consumes ANDROID_DEVICE_PORTS_JSON.
- Security: no public ADB; least-privilege Tailscale ACL; secrets only encrypted. Previously exposed Tailscale auth key and ADB key require rotation/revocation.
- Details: docs/NETWORK_ARCHITECTURE.md.

## 2026-11-16 — AI continuity / shared memory
- User requires any fresh AI chat/Antigravity/Claude to reconstruct context from GitHub without user re-explaining and to read prior changes before editing.
- Decision: GitHub main is canonical durable memory. Mandatory bootstrap: docs/AI_CONTEXT_BOOTSTRAP.md. Every agent reads bootstrap, AGENTS, sync state, design spec, task, network architecture, decision log, communication hub and workflow; checks latest commits/CI; writes changes and evidence back.
- Latest explicit user decision + latest dated accepted decision wins. Correct stale contradictory docs. Never silently revive superseded design or architecture.
- Build, tests, install, screenshot and pixel comparison are separate evidence states.

## 2026-11-16 — Current mobile Member Intelligence layout
- Four tabs: Attendance, Workout, Payment, Body; Attendance default; compact mobile-first.
- Full-width check-in/member context; narrow rail beside intelligence content below tabs.
- Remove duplicate check-in/QR label, gym-floor label, Smart Insight and bottom Streak/Best/Plan Days/Next Goal strip.
- Preserve member identity, payment state, expiry and membership progress.
- CURRENT_DESIGN_SPEC.md is current palette/layout authority; historical themes are not authority.


## 2026-11-16 — Deferred install while Xiaomi is powered off
- User is powering off the Xiaomi 11i and explicitly requires the pending BAD GYM installation to remain a durable task, then resume when the phone is powered on and reachable.
- A fully powered-off Android device cannot receive an APK. Treat this as `WAITING_FOR_DEVICE_POWER_ON`, not as an installation failure.
- On a later run, verify Tailscale peer identity, current Wireless Debugging connect endpoint, TCP reachability, ADB transport and authorization separately; then install the latest approved APK in place, launch, smoke-test and capture fresh logs/screenshots.
- Preserve app data. Never automatically uninstall or wipe to resolve signature/install errors. Classify failures and retain artifacts; use bounded backoff and avoid overlapping installs. Resume on later scheduled/manual attempts until success or a user-action blocker.
- Current workflow only skips offline devices and still relies on `ANDROID_DEVICE_PORTS_JSON`; durable deferred queue, dynamic port discovery and retry/reconnect loop are not implemented yet.
- Tracking: https://github.com/explorelearningvisit-boop/productionreadymembercard/issues/2


## 2026-11-16 — Preserve installed app data during CI install failures
- Remove the workflow's automatic uninstall/reinstall fallback on INSTALL_FAILED_UPDATE_INCOMPATIBLE.
- A signature mismatch must report SIGNATURE_MISMATCH_PRESERVED_DATA and retain the installed application and all user data. Any migration/uninstall is an explicit user-approved operation outside unattended CI.


## 2026-11-16 — Unified bordered member dashboard card and restored insight summary
- Latest user instruction supersedes earlier removal of Smart Insight and the bottom summary strip; both are required again.
- Entire dashboard must sit inside one visibly bordered outer card: check-in ribbon, member profile/payment/expiry/progress, four tabs, intelligence rail/canvas, Smart Insight and Streak/Best/Plan Days/Next Goal.
- Keep rail only beside the intelligence canvas from Attendance Trend through the bottom summary, never beside the header/profile.
- Remove redundant CHECK-IN action beside the event ribbon; it is informational and must not open QR or claim a new check-in.
- Keep Attendance, Workout, Payment and Body visible/selectable at 360dp.
- Use light coral/rose/ivory instead of heavy dark brown/deep burgundy blocks.


## 2026-11-16 — Continuous AI-agent observability and safe recovery
- **User decision:** All collaborating AI tools (ChatGPT, Antigravity, Claude, IDE/local agents and GitHub automation) must follow a shared operating model: inspect active work, changed files, logs and failures; diagnose and safely repair; validate; and persist a handoff so the next tool continues without manual context reconstruction.
- **Contract:** `docs/CONTINUOUS_AGENT_OBSERVABILITY.md` defines live-vs-snapshot honesty, event telemetry, filesystem observation, GitHub Actions ingestion, redaction, bounded retries, concurrency locks, device recovery and acceptance criteria.
- **Important implementation distinction:** This is an operating requirement, not a claim that second-by-second monitoring is already active. A persistent local observer/event consumer plus GitHub event ingestion must be built, secured and end-to-end tested. Chat sessions and finite GitHub Actions jobs do not run forever.
- **Safety:** Read-only/redacted telemetry by default; mutations require least privilege, expected hashes, backups and explicit approval. Never expose secrets, public ADB, uninstall automatically or wipe app data.


## 2026-11-16 — Laptop-independent deployment; preserve installed BAD GYM
- User reports laptop stolen and explicitly removes it from future BAD GYM workflows. ChatGPT conversation is the command interface; GitHub and GitHub Actions are the cloud coding/build/QA environment. Do not require local USB, laptop runner, Windows Local Agent or laptop terminal.
- Desired deployment: GitHub cloud runner joins the private Tailscale network, verifies Xiaomi peer and authenticated ADB endpoint, then updates BAD GYM in place and returns launch/smoke-test/screenshot/log evidence.
- User confirms BAD GYM is currently installed and forbids deleting/uninstalling it or wiping its data. Never run uninstall, pm clear or destructive migration automatically. Any migration requires explicit approval.
- Tailscale API/peer-online status does not itself provide remote shell/ADB. ADB requires reachable device-side daemon/endpoint and valid paired host authorization. Tailscale is transport/overlay, not the ADB control protocol.
- Run 43838086739 built APK successfully (commit 668f7a5d895f402113aa2d0763b1ad6c19cd8f08; artifact 14212365972), but device QA failed at ADB connection. User screenshot shows Wireless Debugging OFF and UI requesting Wi-Fi. Installation is NOT verified.
- Investigate a phone-side authenticated deployment/heartbeat mechanism and Android-approved update path that works on cellular/Tailscale without a laptop. Do not promise silent install by a normal app. Static endpoint secret remains a limitation until dynamic discovery passes end-to-end tests.
- Future agents must treat docs/CHATGPT_ONLY_DEPLOYMENT.md and deploymentArchitecture in AI_SYNC_STATE.json as authoritative.


## 2026-11-16 — Compact fixed-viewport intelligence workspace + in-app updates
- User rejected the current tall, vertically scrollable member dashboard: too much empty/oversized card space, weak theme consistency, and too little information per viewport. This is a structural UX correction, not a cosmetic-only palette tweak.
- New interaction model: preserve the member identity/payment/expiry context in a compact header; reduce horizontal quick-tab height/padding; provide four quick tabs Attendance, Workout, Payment, Body; show a compact vertical contextual rail beside a fixed-size intelligence viewport. Selecting a rail item swaps the widget in place rather than stacking widgets or scrolling the page.
- Attendance is the default selected tab and opens the current month's full attendance calendar by default. Attendance rail items expose distinct focused views (Calendar, Trend, History, Streak/Insights) one at a time. Other tabs expose their own relevant focused widgets. Keep widget dimensions bounded and responsive to available viewport; no nested/whole-page vertical scrolling in the primary dashboard. If content cannot fit, paginate/switch widgets rather than expanding the page.
- Visual direction: replace the current inconsistent pale pink/peach/lavender mix and oversized outer shell with a coherent premium BAD GYM performance theme: warm ivory/light surface, controlled crimson/red primary accents, restrained gold for premium/member-plan emphasis, green present/success, red absent/due, amber late/warning, muted grey Sunday/off. No purple/lavender accents. High contrast, tight spacing, smaller but readable type, compact card paddings, no unnecessary banners/duplicated summary metrics. This decision supersedes older palette notes where they conflict.
- Introduce an in-app Update Center. App checks a stable GitHub Release manifest/API for latest versionCode/versionName, release notes, APK URL, SHA-256 and minimum supported version. User sees current/latest version, changelog and an Update action. Download over HTTPS, verify SHA-256, stage the APK, then invoke Android's official package installer for same package ID. Preserve data; never uninstall or clear app data. Android/MIUI confirmation/unknown-source permission is user-approved; do not promise silent install.
- Flutter/Dart code cannot be hot-swapped safely from GitHub into an already installed compiled Flutter APK. UI/logic changes require a new APK; the in-app update feature makes discovery/download/install happen from inside BAD GYM. Remote-configurable content/theme values may be refreshed without APK only when deliberately designed as data, never arbitrary executable Dart code.
- Release signing is a hard prerequisite: all update APKs must use the same protected release signing key as the installed production app. Current CI release build is QA/debug signed; it is NOT yet safe to assume it can update the user's existing installation. Do not ship the in-app updater until release-key custody, GitHub release publication, integrity verification, version monotonicity and Android PackageInstaller flow are validated. Never uninstall to resolve signature mismatch.
- Release history and cross-agent memory are append-only: retain commit SHA, date/time, author/agent, rationale, changed files, tests, build artifact, release notes, known defects and next action in a machine-readable changelog plus AI_SHARED_COMMUNICATION_HUB.md. Update AI_SYNC_STATE.json and ANTIGRAVITY_TASK.md. Never overwrite prior history. All agents must read the new UI and updater architecture docs before changes.
- Acceptance: 360dp layout/widget tests; compact viewport overflow tests; rail item switching tests; default Attendance calendar test; no primary-screen scroll; theme semantic color tests; updater manifest parsing, HTTPS-only URL validation, SHA-256 mismatch rejection, downgrade rejection, version check, installer handoff and cancellation/error tests; CI build/test. Physical Xiaomi screenshot/install remains separate evidence.


## 2026-11-16 — Compact workspace and first in-app updater implementation
- Implementation started in Flutter source, not documentation-only. Root dashboard no longer uses a vertical SingleChildScrollView; it uses LayoutBuilder and a bounded intelligence viewport.
- Member context is compressed; four quick tabs remain visible; contextual rail swaps one focused widget in place. Attendance defaults to Calendar. Trend, History and Insights are separate rail destinations. Workout, Payment and Body have focused destinations.
- Removed the stacked full trend+calendar+insight+summary content from the primary canvas. The footer retains a manual Updates action; startup performs a silent stable-release check.
- Update service reads latest GitHub stable release metadata, requires APK asset digest and HTTPS GitHub URL, compares explicit versionCode from release notes, downloads in native Android code, verifies SHA-256, then commits to Android PackageInstaller. System confirmation is expected.
- Android manifest declares INTERNET and REQUEST_INSTALL_PACKAGES and registers the PackageInstaller result receiver.
- Protected release signing support is conditional in Gradle. Stable release publishing workflow refuses to run without all four protected BADGYM_RELEASE_* secrets. Never use the default debug key for public stable updates.
- Version advanced to 0.2.0+2. CI run 43876682039 was cancelled by rapid subsequent commits before reaching tests; next agent must inspect the newest run and fix all format/analyze/test/Gradle failures before publishing an APK.
- Physical Xiaomi layout and update install are not verified. No release signing key is present in repository context; no production release can be safely published until its protected secrets are provisioned.
- Related files: lib/presentation/member_checkin_screen.dart, lib/core/services/update_center_service.dart, android/app/src/main/kotlin/com/badgym/bad_gym/MainActivity.kt, UpdateInstallReceiver.kt, AndroidManifest.xml, android/app/build.gradle.kts, .github/workflows/publish-android-release.yml, test/widget_test.dart.


## 2026-11-16 — Laptop USB Fast-Deploy vs. Cloud CI Protocol
- **Context & Directive**: The user explicitly clarified the operating roles of the two agents:
  1. **Antigravity (Local Execution Agent)**: Runs on the Windows laptop where the phone is directly attached via USB (`zxdada69gunb7ls4`) or local network. Antigravity must execute code edits, local builds, tests, and direct streamed in-place ADB installs without routing through GitHub Actions during active iteration.
  2. **ChatGPT (Cloud Automation Agent)**: Operates remotely via GitHub Actions and Tailscale automation when the laptop is off or unavailable.
  3. **GitHub Push Gate**: Code and verification artifacts are committed and pushed to GitHub `main` only after full local completion and physical device verification, providing ChatGPT with synchronized truth.
- **Outcome**: The full 6-section BAD GYM composite dashboard with 3D badges, 372px fixed intelligence viewport, and zero-jump navigation was compiled and verified live on Xiaomi 11i 5G (`docs/screenshots/bad_gym_live_screen.png`).


## 2026-11-17 — User re-authorizes independent ChatGPT implementation + screenshot authority
- User explicitly instructs ChatGPT to perform the complete Member Intelligence Flutter UI/UX implementation directly; Antigravity may continue separate local laptop work, but ChatGPT must not depend on Antigravity output.
- Latest reference image: `/mnt/data/1000320035.jpg`, 1024×1536 px, reopened and verified. It supersedes earlier red/ivory, crimson, and other visual references where they conflict.
- Exact visual target: ice-blue/cyan water-glass background, translucent pearl cards, navy typography, blue accents, green/amber/red/neutral attendance semantics; header, integrated member pass/QR/progress, festival banner, four KPI tiles, compact left rail + calendar + right attendance summary, bottom AI Insights.
- ChatGPT implementation lives on `chatgpt/member-intelligence-mobile-rebuild`, not main. Antigravity's local changes are independent and must not be overwritten or treated as a prerequisite.
- Dashboard must remain a bounded no-scroll mobile viewport; rail/tab actions replace the content in place. Do not invent sections or substitute old promo/hero artwork.
- CI build/test, physical Xiaomi install, screenshot comparison, and signing continuity remain separate gates. Preserve existing app data and never uninstall/clear data automatically.


## 2026-11-18 — Universal cross-agent operating constitution
- **User decision**: project context and working rules must persist in the repository so a fresh chat or any AI tool can read them and continue without asking the user to repeat known details.
- **Decision**: `docs/AI_AGENT_OPERATING_CONSTITUTION.md` is the canonical complete rulebook. It covers understanding voice/rough requests before coding, source-of-truth precedence, branch isolation, approved design authority, asset/code quality, testing, CI recovery, device/network/security safety, cross-agent collaboration and evidence-based reporting.
- **Discovery**: add thin tool-specific entrypoints for Gemini/Antigravity, Claude, GitHub Copilot and Cursor; all point to the canonical rulebook. `AGENTS.md` and the bootstrap make it mandatory for all agents.
- **Current branch**: `chatgpt/member-intelligence-mobile-rebuild`; do not alter `main` without explicit user instruction.
- **Current verification**: runs #283 and #284 failed at Dart formatting; tests, APK and device QA were skipped. Formatter diagnostics remain to be retrieved/reproduced. The burgundy/protein-burger UI is not accepted as a design change because the approved current target remains the ice-blue reference. The 2026-11-18 phone screenshot is output evidence only.
