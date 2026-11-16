# BAD GYM Windows Local Agent — Setup & Operations

## Purpose and boundary

This repository contains the Windows-side execution agent for BAD GYM Member Intelligence. It is a separate developer tool, not part of the Flutter runtime. It does not change app permissions, install a background Android service, or silently take control of a phone.

- AI/MCP client: requests bounded operations.
- Windows agent: executes approved local operations against this repository.
- Android: reached through authorized USB ADB first, or Wireless Debugging over a verified Tailscale endpoint.
- GitHub Actions: remains the cloud build and CI/device-QA path.
- GitHub is not used as a screenshot relay for local iteration; screenshot bytes are returned directly as an MCP image result.

## Windows prerequisites

Install Python 3.12+, Flutter stable, Android Platform Tools (ADB), Git, and Tailscale for Windows. scrcpy is optional for interactive mirroring; the MCP agent uses ADB for screenshots, launch and logs. Ensure the phone's existing ADB authorization is valid.

From the repository root in PowerShell:

~~~powershell
Set-ExecutionPolicy -Scope Process Bypass
.\tools\badgym_local_agent\install-windows.ps1
.\tools\badgym_local_agent\start-windows.ps1
~~~

The MCP server uses stdio. Configure your MCP-capable desktop client using tools/badgym_local_agent/mcp-config.example.json, replacing placeholder paths with the real absolute Windows repository path. The client starts the process; keep the client open while using its tools.

## Tools exposed

- agent_health: toolchain and agent readiness.
- list_android_devices: USB/wireless ADB inventory.
- list_tailscale_peers: safe Tailscale peer metadata.
- connect_wireless_adb: connect only to an explicit current 100.64.0.0/10 Tailscale IPv4 + current Wireless Debugging connect port, then verify adb get-state.
- capture_android_screenshot: returns PNG bytes directly through MCP.
- get_android_logcat: bounded logcat tail.
- get_android_screen_resolution: reads display size and density.
- tap_android_screen, swipe_android_screen, press_android_key: bounded screen interaction.
- launch_bad_gym: launches the app without clearing data.
- run_flutter_task: allowlisted analyze, test, or release APK build.
- read_project_file: bounded source reads; protected paths and secret-like files are blocked.
- write_project_file: complete replacement limited to lib/, test/, pubspec.yaml, and analysis_options.yaml; requires the local write feature flag, explicit approval argument and expected SHA-256. A backup is written under the user's profile outside the repository.
- install_release_apk: installs the existing release APK in-place only with explicit approval; it never uninstalls or clears app data.

There is deliberately no arbitrary shell/PowerShell tool, no generic file deletion, no secret-reading tool and no force-push tool.

## USB + Wireless operating sequence

1. Call list_android_devices. If the Xiaomi is authorized over USB, use that serial; no network discovery is needed.
2. If USB is absent, call list_tailscale_peers and identify the online Xiaomi node by hostname/device identity. Do not rely on a stale IP.
3. Read the current Android Wireless Debugging connect port from the phone. It is dynamic and differs from the pairing port. Call connect_wireless_adb with the current Tailscale IP and connect port.
4. Call list_android_devices again and verify state is device.
5. Capture screenshot, inspect logs, launch and test. Build with run_flutter_task; install only after reviewing and approving the target.

The phone may disable Wireless Debugging after reboot. Tailscale online does not prove ADB pairing/authorization or an active TCP port. The agent never guesses port 5555. ADB must not be exposed through public router forwarding.

## MCP client configuration

The included JSON is a template for local MCP clients that support stdio servers. Keep paths local and do not commit personal machine configuration containing secrets. This is not a ChatGPT cloud connection by itself.

## Connecting a private agent to OpenAI

OpenAI Secure MCP Tunnel is the supported route for connecting a private/local MCP server to supported OpenAI products without exposing it publicly. It requires a Platform tunnel ID, a runtime API key, appropriate Platform tunnel permissions, an installed tunnel-client, and an associated ChatGPT workspace/app with custom MCP access. Keep credentials in local secure input/environment references; never put them in this repository.

Operator sequence (verify current CLI help before use):

1. Create/manage the tunnel in OpenAI Platform Tunnels settings and associate the correct Platform organization and ChatGPT workspace.
2. Install the official OpenAI tunnel-client release on the Windows host.
3. Follow tunnel-client help quickstart and its onboarding guide to bind the local stdio MCP command above.
4. Run tunnel-client doctor --profile <profile> --explain; start the client and verify ready/active polling.
5. In ChatGPT web, use Plugins / Add custom MCP server / Tunnel where the account/workspace supports it, select the same tunnel, and test a safe read-only tool.
6. Only enable write actions where the ChatGPT workspace and app permissions support them; retain the agent's local approval gates.

Important product boundary: OpenAI documentation currently says custom MCP connections are configured on ChatGPT web, not the ChatGPT mobile app. Published eligibility guidance lists Pro custom MCP as read/fetch-only and full MCP for Business and Enterprise/Edu; it does not list Go. Do not assume this Go account can use custom MCP or write actions without checking the actual account/workspace UI. Therefore this repository integration does not make the current Android ChatGPT app a direct phone-control client. Use a supported ChatGPT web/workspace or a separately built Responses API client for the full tool loop.

Official references:
- https://developers.openai.com/api/docs/guides/secure-mcp-tunnels
- https://developers.openai.com/api/docs/guides/tools-connectors-mcp
- https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt
- https://github.com/openai/tunnel-client

## Local verification

~~~powershell
$env:PYTHONPATH = (Resolve-Path .\tools).Path
py -3.12 -m unittest discover -s .\tools\badgym_local_agent\tests -v
py -3.12 -m compileall .\tools\badgym_local_agent
~~~

The CI workflow .github/workflows/local-agent-validation.yml runs these checks on relevant changes. A green Python agent check does not mean the Windows agent has been installed on the user's laptop, the tunnel has been provisioned, or the physical phone is connected.
