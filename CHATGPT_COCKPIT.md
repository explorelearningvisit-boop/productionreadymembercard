# BAD GYM — AI Agent Cockpit

**Start every session at [docs/AI_CONTEXT_BOOTSTRAP.md](docs/AI_CONTEXT_BOOTSTRAP.md).** This file is a quick guide, not a substitute for the full bootstrap.

## Canonical project
- Repository: https://github.com/explorelearningvisit-boop/productionreadymembercard
- Branch: main
- Flutter/Dart; Android + iOS project.
- Android package: com.badgym.bad_gym
- Device: Xiaomi 11i 5G (21091116I), Android 13 / MIUI.
- Full rules: AGENTS.md. Current design: CURRENT_DESIGN_SPEC.md. Machine state: AI_SYNC_STATE.json.

## AI session loop
1. Fetch latest main and inspect recent commits/working tree.
2. Read docs/AI_CONTEXT_BOOTSTRAP.md, AGENTS.md, AI_SYNC_STATE.json, CURRENT_DESIGN_SPEC.md, ANTIGRAVITY_TASK.md, docs/NETWORK_ARCHITECTURE.md, docs/DECISION_LOG.md, and latest AI_SHARED_COMMUNICATION_HUB.md entries.
3. Inspect actual source and current GitHub Actions workflow/run/artifacts. Do not rely on stale chat context.
4. Make requested change only; preserve other agents' work.
5. Format, analyze, test and build as appropriate.
6. Update AI_SYNC_STATE.json and append an inter-agent handoff entry. Commit/push.
7. Report build, tests, install, launch and screenshot as separate verified outcomes.

## Current UI invariants
- Four tabs: Attendance, Workout, Payment, Body; Attendance default.
- Compact mobile-first Member Intelligence card.
- Follow CURRENT_DESIGN_SPEC.md only; historical palettes and stale screenshots are not authority.
- Preserve member identity/payment/expiry context. Do not restore removed duplicate check-in labels, gym-floor label, Smart Insight or bottom metric strip.

## Device/network facts
- User's laptop and Xiaomi may be on unrelated networks: home Wi-Fi, own/third-party hotspot, hotspot shared through another phone, USB tethering, Ethernet, cellular and network transitions.
- No fixed LAN, DHCP IP, mDNS or ADB port assumption.
- Tailscale is the preferred private overlay; ADB pairing and current Wireless Debugging connect port are separate and must be verified.
- Latest user-reported port was 37337; transient only. Android may disable Wireless Debugging after power-off; user will re-enable it.
- Do not give generic instructions to turn debugging on without evidence. User is an experienced developer.
- Dynamic ADB endpoint discovery is a target, not yet implemented. Current workflow still reads ANDROID_DEVICE_PORTS_JSON.

## Security
Never paste secrets or private keys in chat, docs, logs or commits. A previously exposed Tailscale auth key and ADB private key must be rotated/revoked. Keep only secret NAMES in docs. Never auto-uninstall or wipe user app data.

## New-session prompt
Use the copy-ready prompt in docs/AI_CONTEXT_BOOTSTRAP.md.


## Windows execution agent
- Local MCP server: tools/badgym_local_agent/; operator guide: docs/LOCAL_AGENT_SETUP.md.
- It exposes bounded ADB screenshot/log/touch, Tailscale peer discovery, allowlisted Flutter analyze/test/build and guarded source read/write/install tools.
- Start in read-only mode. Never use arbitrary shell, delete, force-push, uninstall or clear-data actions.
- Screenshots return directly through MCP image content. GitHub Actions remains the cloud build/device QA route.
- ChatGPT mobile custom MCP is not supported by current product docs; connect from supported ChatGPT web/workspace or a separate Responses API client.
