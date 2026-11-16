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
