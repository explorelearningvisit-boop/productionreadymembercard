# Antigravity Handoff — BAD GYM (living handoff)

**Mandatory:** Read docs/AI_CONTEXT_BOOTSTRAP.md and AGENTS.md before any action. Then read AI_SYNC_STATE.json, CURRENT_DESIGN_SPEC.md, docs/NETWORK_ARCHITECTURE.md, docs/DECISION_LOG.md, this handoff and latest AI_SHARED_COMMUNICATION_HUB.md entries. Inspect latest main commits and current Actions run/artifacts.

## Current handoff — 2026-11-16
- Repository: explorelearningvisit-boop/productionreadymembercard, branch main.
- AI continuity documents have been added: docs/AI_CONTEXT_BOOTSTRAP.md, docs/NETWORK_ARCHITECTURE.md, docs/DECISION_LOG.md. AGENTS.md and CHATGPT_COCKPIT.md were rewritten as mandatory agent protocols; README links to context docs; AI_SYNC_STATE.json and AI_SHARED_COMMUNICATION_HUB.md updated.
- Network topologies required: home Wi-Fi, own hotspot, third-party hotspot, hotspot shared onward through another phone, USB tethering, Ethernet, cellular, and transitions. Never assume same LAN/mDNS/fixed DHCP IP/fixed ADB port.
- Xiaomi 11i 5G (21091116I), Android 13/MIUI. Last observed Tailscale IP 100.123.18.54, USB serial zxdada69gunb7ls4. User last reported Wireless Debugging connect port 37337; transient only. Android may disable Wireless Debugging after power-off; user re-enables it. User is an experienced developer; do not repeat generic debug-toggle instructions without evidence.
- Dynamic ADB endpoint discovery is documented but NOT implemented. Current workflow still consumes ANDROID_DEVICE_PORTS_JSON and DEVICE_ADB_PRIVATE_KEY_B64. Do not claim port auto-discovery yet.
- Security: previous Tailscale auth key and ADB private key material were exposed; rotate/revoke them. Never put secret values in docs/chat/commits.
- Required next implementation: design/build authenticated Android endpoint discovery or device agent, validate ADB over Tailscale across supported topologies, remove static port secret only after end-to-end tests. Maintain manual endpoint fallback until then.

## Existing CI/device QA lessons (historical; verify current run)
- Tailscale join, peer-online, ADB transport, ADB authorization, APK signature, MIUI install authorization, launch, and screenshot are separate failure stages.
- Earlier runs showed Tailscale join succeeded; other runs showed offline peers or ADB endpoint failures. Inspect latest run artifacts rather than repeating old diagnoses.
- Never auto-uninstall or wipe user data. Do not claim fresh screenshot/install without artifacts.

## Before editing
1. Fetch latest main and inspect recent commits and all touched files.
2. Read current workflow .github/workflows/android-cloud-device.yml and docs/ANDROID_CLOUD_DEVICE_QA.md.
3. Preserve ChatGPT or other agent changes; batch coherent commits.
4. Update AI_SYNC_STATE.json and append AI_SHARED_COMMUNICATION_HUB.md after work.
5. Run relevant tests/build and report exact results.

## Active next steps
- [ ] Verify current secret names/configuration without printing values; rotate exposed credentials via admin UI.
- [ ] Implement authenticated current-endpoint discovery for Xiaomi Wireless Debugging.
- [ ] Handle network changes and stale ADB socket reconnect.
- [ ] Validate home Wi-Fi, independent hotspot/cellular, third-party hotspot, USB tethering and Ethernet scenarios.
- [ ] Keep APK build available when device is offline; report device QA separately.


## 2026-11-16 — ChatGPT Windows Local Agent integration
- Added optional Windows stdio MCP server under tools/badgym_local_agent/ with bounded ADB/Tailscale/Flutter operations, direct screenshot image results, guarded source writes and approved in-place APK installation.
- Read docs/LOCAL_AGENT_SETUP.md before local installation or tunnel onboarding.
- USB ADB first; Wireless ADB requires live Tailscale peer + current Android Wireless Debugging connect port + successful adb get-state. No static port assumption.
- Local writes disabled by default and restricted to lib/, test/, pubspec.yaml and analysis_options.yaml with expected-hash checks and external backups.
- This repository commit does not install software on the user's Windows laptop, provision an OpenAI tunnel, connect the phone, or prove physical QA. These require the Windows host and live phone to be online.


## Local Agent merge status — 2026-11-16
- PR #3 merged to main: 2835954f4315b6348b6f800cb721b1113569f719.
- Python Local Agent validation passed on PR head (compileall, 6 unit tests, Ruff); main-branch rerun and Flutter build rerun were queued at the time of this handoff.
- CI install safety fixed: signature mismatch now preserves installed app/data; no unattended uninstall.
- Windows laptop installation, OpenAI Secure MCP Tunnel provisioning, live USB/Wireless ADB, and fresh Xiaomi screenshot remain unverified and require the Windows host/phone to be online.


## Mandatory continuous-observation requirement (2026-11-16)
Before starting, read `docs/CONTINUOUS_AGENT_OBSERVABILITY.md` and follow `AGENTS.md` + `docs/AI_CONTEXT_BOOTSTRAP.md`. User requires all collaborating agents to inspect timestamped active task/run telemetry, changed files and logs through supported authenticated tools, diagnose failures, apply minimal safe fixes, validate and write durable handoffs. Do not claim live/per-second observation unless an actual persistent watcher is running and returning fresh events. The persistent observer + GitHub event ingestion + bounded recovery implementation is tracked in issue #5: https://github.com/explorelearningvisit-boop/productionreadymembercard/issues/5. Coordinate deferred Xiaomi install work with issue #2. Current implementation status: contract documented; watcher NOT YET IMPLEMENTED.
