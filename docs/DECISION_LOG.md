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
