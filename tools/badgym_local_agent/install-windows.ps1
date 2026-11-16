param(
  [string]$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
)
$ErrorActionPreference = "Stop"
$AgentDir = $PSScriptRoot
$VenvPython = Join-Path $AgentDir ".venv\Scripts\python.exe"
if (-not (Get-Command py -ErrorAction SilentlyContinue)) {
  throw "Python 3.12+ is required. Install Python and enable the py launcher."
}
py -3.12 --version
if (-not (Test-Path $VenvPython)) {
  py -3.12 -m venv (Join-Path $AgentDir ".venv")
}
& $VenvPython -m pip install --upgrade pip
& $VenvPython -m pip install -r (Join-Path $AgentDir "requirements.txt")
Write-Host "Agent dependencies installed."
Write-Host "Project root: $ProjectRoot"
Write-Host "Next: run .\start-windows.ps1 from this folder."
