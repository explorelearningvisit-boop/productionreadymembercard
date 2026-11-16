param(
  [string]$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path,
  [switch]$EnableWrites
)
$ErrorActionPreference = "Stop"
$Python = Join-Path $PSScriptRoot ".venv\Scripts\python.exe"
if (-not (Test-Path $Python)) { throw "Run .\install-windows.ps1 first." }
if (-not (Get-Command adb -ErrorAction SilentlyContinue)) { throw "Android Platform Tools (adb) must be on PATH." }
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) { Write-Warning "Flutter not found on PATH; build tools will be unavailable." }
if (-not (Get-Command tailscale -ErrorAction SilentlyContinue)) { Write-Warning "Tailscale CLI not found on PATH; peer discovery will be unavailable." }
$env:BADGYM_PROJECT_ROOT = (Resolve-Path $ProjectRoot).Path
$env:PYTHONPATH = $PSScriptRoot
if ($EnableWrites) { $env:BADGYM_AGENT_ENABLE_WRITES = "1" } else { $env:BADGYM_AGENT_ENABLE_WRITES = "0" }
& $Python -m badgym_local_agent.server
