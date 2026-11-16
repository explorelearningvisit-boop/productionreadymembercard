# BAD GYM — Windows Local Agent

This folder contains the optional local MCP execution agent for the production Flutter Member Intelligence repository. See docs/LOCAL_AGENT_SETUP.md for installation, USB/Wireless ADB setup, tool inventory, security boundaries and Secure MCP Tunnel onboarding.

Quick start (PowerShell, from repository root):

~~~powershell
.\tools\badgym_local_agent\install-windows.ps1
.\tools\badgym_local_agent\start-windows.ps1
~~~

The agent defaults to read/diagnostic mode. Writes are disabled unless started with the local EnableWrites switch and every write also requires approved=true plus an expected SHA-256. Never expose ADB publicly or commit local credentials.
