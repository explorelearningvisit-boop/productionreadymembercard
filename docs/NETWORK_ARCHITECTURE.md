# BAD GYM Network & Android Device Connectivity Architecture

## Goal
Support laptop-to-Xiaomi development across changing uplinks without assuming one Wi-Fi, hotspot, subnet, DHCP IP or Wireless Debugging port.

## Known endpoints (verify live)
- Xiaomi 11i 5G / 21091116I / Android 13 MIUI.
- Tailscale IP previously observed: 100.123.18.54; verify live.
- USB ADB serial previously observed: zxdada69gunb7ls4; verify live.
- Latest user-reported Wireless Debugging connect port: 37337. Transient only.
- Android may disable Wireless Debugging after power-off; user will re-enable it.

## Supported topology matrix
| Laptop uplink | Phone uplink | Same LAN guaranteed? | Preferred path |
|---|---|---:|---|
| Home Wi-Fi | Same home Wi-Fi | Usually | USB if attached; otherwise Tailscale; mDNS optional |
| User's hotspot | Cellular/other Wi-Fi | No | Tailscale |
| Third-party hotspot | Phone cellular | No | Tailscale |
| User hotspot shared onward through another phone | Cellular/tether chain | No | Tailscale |
| USB tethering | Phone cellular/Wi-Fi | No | Tailscale |
| Ethernet | Phone cellular/Wi-Fi | No | Tailscale |
| Any uplink transition | Any | No | invalidate stale socket, rediscover, reconnect |

## Layer separation
1. Uplink: Wi-Fi, cellular, hotspot, USB tethering, Ethernet.
2. Overlay: Tailscale stable node identity/MagicDNS when available; IP and routes must be verified. Direct path may fall back to DERP. Relay does not expose arbitrary services.
3. Android Wireless Debugging: pairing identity and connect endpoint. Pairing port/code differs from connect port; connect port may change after reboot, toggle or network change.
4. ADB: TCP + authorized host key + daemon state. Tailscale Online does not prove ADB is reachable, paired or authorized.
5. QA: install, launch, screenshot, logs and visual comparison each need separate evidence.

## Connection selection
1. Prefer authorized USB ADB if attached to laptop.
2. Otherwise resolve current Xiaomi Tailscale peer identity/IP and confirm online.
3. Discover current Wireless Debugging connect port using authenticated device-side discovery or explicitly supplied current endpoint.
4. Test TCP, then adb connect and adb get-state. Distinguish timeout, refused, unauthorized, offline and device.
5. mDNS is optional same-LAN hint only; never required across cellular/hotspot/Tailscale.
6. Unknown port means endpoint unknown; never guess 5555.
7. On network transition invalidate stale ADB sockets, resolve route/endpoint again, reconnect with bounded exponential backoff.
8. Verify device model, serial and package before install.

## Dynamic port discovery — target, NOT implemented
Current GitHub Actions workflow reads ANDROID_DEVICE_PORTS_JSON. This static mapping requires updating after the connect port changes. Do not describe current workflow as dynamic discovery.

To remove manual secret edits, implement an authenticated device-side discovery agent or approved endpoint registration:
- Agent reports device identity and current ADB connect endpoint to a private authenticated control channel.
- Authenticate with provisioned device identity; protect transport using Tailscale ACLs/TLS.
- GitHub runner fetches fresh endpoint and validates TCP + adb connect + adb get-state.
- Never transmit pairing codes/private keys in logs.
- Evaluate Android 13 and MIUI background restrictions before selecting foreground service, Termux service or user-started helper. Do not promise persistence without tests.
- Manual current-port registration remains fallback until agent passes end-to-end tests.
- Never use public router port-forwarding or expose ADB publicly.

## Tailscale design
- Prefer GitHub Actions OIDC/OAuth short-lived identity over reusable long-lived auth keys.
- Least-privilege ACL: CI runner reaches only approved device and required ADB endpoint.
- Verify node identity/key expiry policy live.
- Both devices must be online; Tailscale cannot wake a powered-off phone or re-enable Wireless Debugging.

## Current GitHub Actions truth
- Workflow: .github/workflows/android-cloud-device.yml.
- Build/test and device QA are separate jobs.
- Device QA currently reads ANDROID_DEVICE_PORTS_JSON and DEVICE_ADB_PRIVATE_KEY_B64.
- Network topology can vary, but ADB port dependency remains static today.
- Upload inventory, endpoint diagnostics, ADB/install logs, screenshots and Logcat even on failure.
- Never auto-uninstall or wipe app data to fix install/signing errors.

## Acceptance tests
- Laptop home Wi-Fi + phone same Wi-Fi.
- Laptop own hotspot + phone cellular.
- Laptop third-party hotspot + phone cellular.
- Laptop USB tethering + phone independent network.
- Laptop Ethernet + phone cellular.
- Change laptop uplink mid-run: detect stale session and reconnect or fail clearly.
- Reboot phone: after user re-enables Wireless Debugging, rediscover endpoint without editing GitHub secret.
- Phone offline: report offline safely; keep build artifact.
- Pairing revoked: report unauthorized and require one-time re-pair, not a port fix.
