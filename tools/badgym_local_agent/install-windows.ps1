param(
  [string]$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
)
$ErrorActionPreference = "Stop"
$AgentDir = $PSScriptRoot
$VenvPython = Join-Path $AgentDir ".venv\Scripts\python.exe"
$PythonBin = if (Get-Command py -ErrorAction SilentlyContinue) { "py" } elseif (Get-Command python -ErrorAction SilentlyContinue) { "python" } else {
  throw "Python 3.12+ is required. Install Python and ensure it is on PATH."
}
if ($PythonBin -eq "py") {
  py -3.12 --version
  if (-not (Test-Path $VenvPython)) {
    py -3.12 -m venv (Join-Path $AgentDir ".venv")
  }
} else {
  python --version
  if (-not (Test-Path $VenvPython)) {
    python -m venv (Join-Path $AgentDir ".venv")
  }
}
& $VenvPython -m pip install --upgrade pip
& $VenvPython -m pip install -r (Join-Path $AgentDir "requirements.txt")
Write-Host "Agent dependencies installed."
Write-Host "Project root: $ProjectRoot"
Write-Host "Next: run .\start-windows.ps1 from this folder."
