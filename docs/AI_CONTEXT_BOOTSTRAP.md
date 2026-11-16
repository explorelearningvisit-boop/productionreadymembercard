# BAD GYM — AI Context Bootstrap (Start Here)

This is the universal handoff for every fresh AI chat or coding agent. GitHub is the durable project memory; do not depend on chat history.

## 60-second startup
1. Open repository explorelearningvisit-boop/productionreadymembercard, branch main.
2. Read this file, AGENTS.md, AI_SYNC_STATE.json, CURRENT_DESIGN_SPEC.md, ANTIGRAVITY_TASK.md, docs/NETWORK_ARCHITECTURE.md, docs/DECISION_LOG.md, AI_SHARED_COMMUNICATION_HUB.md, and .github/workflows/android-cloud-device.yml.
3. Inspect latest commits, pull requests, Actions runs and artifacts. Do not assume old status remains current.
4. Inspect actual source before editing. Preserve all other agent changes.
5. After work, update state and handoff log, then commit.

## Project identity
- Product: BAD GYM Member Intelligence.
- Repository: https://github.com/explorelearningvisit-boop/productionreadymembercard
- Branch: main.
- Stack: Flutter/Dart, Android + iOS target.
- Android package: com.badgym.bad_gym; launcher: com.badgym.bad_gym/.MainActivity.
- Primary device: Xiaomi 11i 5G (21091116I), Android 13 / MIUI, 1080×2400.
- Tailscale IP previously observed: 100.123.18.54; verify live.
- USB ADB serial previously observed: zxdada69gunb7ls4; verify live.

## Product/UI baseline
- Four horizontal tabs: Attendance, Workout, Payment, Body. Attendance is default.
- Compact mobile layout; member header/profile full-width; narrow vertical rail beside intelligence content below tabs.
- User removed duplicate check-in/QR label, gym-floor label, Smart Insight banner, and bottom Streak/Best/Plan Days/Next Goal strip.
- Preserve member identity, payment state, plan expiry and membership progress.
- CURRENT_DESIGN_SPEC.md is the only visual authority. Historical themes are not authority.

## Network reality
Laptop and Xiaomi may use same home Wi-Fi, different cellular networks, user's own hotspot, third-party hotspot, user's hotspot shared onward through another phone, USB tethering, Ethernet, or changing uplinks. Do not assume same LAN, DHCP IP, or mDNS. Tailscale is the preferred private overlay. ADB pairing, transport and port are separate concerns.

## Device debugging facts
- User is an experienced developer. USB debugging, Wireless debugging and MIUI security debugging are normally enabled/configured. Do not repeat generic toggle instructions without evidence.
- Android may disable Wireless Debugging after phone power-off; user will re-enable it after reboot.
- Latest reported Wireless Debugging connect port was 37337 on 2026-11-16. It is transient, not permanent. Pairing port and connect port are different.
- Verify USB serial and Tailscale IP live. Phone must be powered on and online for remote actions.

## Current implementation truth
- GitHub Actions builds APK and runs Tailnet inventory + ADB QA.
- Current workflow still reads encrypted ANDROID_DEVICE_PORTS_JSON to map hostname/IP to current ADB connect port. Dynamic discovery/Android agent is a desired enhancement, not implemented.
- Build/test pass does not mean phone install/screenshot pass. Read latest run and artifacts.
- Never paste secrets into chat or repository. Previously exposed Tailscale auth key and ADB private-key material require rotation/revocation.

## Agent coordination
- Fetch latest main and inspect recent commits before editing.
- Read source and docs; preserve other agents' changes; no blind overwrite, force-push or reset.
- Record accepted architecture/product changes in docs/DECISION_LOG.md.
- After meaningful work, run relevant format/analyze/tests/build, update AI_SYNC_STATE.json and append AI_SHARED_COMMUNICATION_HUB.md, update ANTIGRAVITY_TASK.md, then commit.
- Keep secrets out of context files. If docs conflict, latest explicit user decision and latest dated decision win; correct stale docs.
- Report build, test, device connection, install, launch and screenshot separately. Never claim physical QA without fresh artifacts.

## Copy-ready new-session prompt
You are joining BAD GYM Member Intelligence. Repository: https://github.com/explorelearningvisit-boop/productionreadymembercard, branch main.

Do not ask me to explain previous context. First read docs/AI_CONTEXT_BOOTSTRAP.md, AGENTS.md, AI_SYNC_STATE.json, CURRENT_DESIGN_SPEC.md, ANTIGRAVITY_TASK.md, docs/NETWORK_ARCHITECTURE.md, docs/DECISION_LOG.md, AI_SHARED_COMMUNICATION_HUB.md and inspect the actual GitHub Actions workflow and latest run/artifacts.

Fetch latest main and recent commits before editing. Preserve ChatGPT/Antigravity/other-agent work. Laptop and Xiaomi may use different changing Wi-Fi, cellular, hotspot, USB tethering or Ethernet networks. Do not assume same LAN or fixed ADB port. Tailscale identity is preferred; ADB pairing and current connect endpoint must be discovered and verified separately. Latest reported port 37337 is transient. User is an experienced developer; do not give generic debugging-toggle instructions without evidence. Android may disable Wireless Debugging after power-off; user will re-enable it.

Make only the requested change, inspect actual code, run relevant tests/build, report evidence precisely, and update AI_SYNC_STATE.json plus AI_SHARED_COMMUNICATION_HUB.md. Never expose secrets or wipe app data. Current task: [DESCRIBE TASK].


## Windows local agent
- Local MCP agent source: tools/badgym_local_agent/.
- Setup/runbook: docs/LOCAL_AGENT_SETUP.md.
- It supports USB-first ADB and explicitly supplied current Wireless Debugging endpoint over Tailscale; no fixed IP/port assumption.
- MCP screenshots are returned as image content directly to the MCP client, not uploaded to GitHub as an intermediate.
- Agent file writes are disabled by default and require local enablement, explicit per-call approval and expected file hash.
- OpenAI Secure MCP Tunnel is the private transport option for compatible OpenAI surfaces. ChatGPT custom MCP is web-only; do not promise direct custom MCP access from the Android ChatGPT app.

## Continuous agent observation (mandatory)
Read `docs/CONTINUOUS_AGENT_OBSERVABILITY.md` before any work. Inspect actual connected tool capabilities and fresh timestamped telemetry; distinguish live events from snapshots. Observe active task/run IDs, changed files and logs where tools expose them; diagnose failures from full logs, repair minimally, validate, and record evidence in `AI_SYNC_STATE.json` and `AI_SHARED_COMMUNICATION_HUB.md`. Do not claim persistent/second-by-second monitoring unless a deployed watcher is running. The watcher and deferred recovery requirements remain implementation work until end-to-end verified.
