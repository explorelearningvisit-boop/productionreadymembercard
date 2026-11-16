from __future__ import annotations

import hashlib
import ipaddress
import json
import os
import shutil
import subprocess
from pathlib import Path
from typing import Any

PACKAGE_ID = "com.badgym.bad_gym"
APP_ACTIVITY = "com.badgym.bad_gym/.MainActivity"
MAX_READ_BYTES = 1_000_000
MAX_WRITE_BYTES = 2_000_000
ALLOWED_WRITE_ROOTS = ("lib", "test")
ALLOWED_ROOT_FILES = {"pubspec.yaml", "analysis_options.yaml"}
DENIED_PARTS = {".git", ".github", ".venv", "__pycache__", "build", "secrets", ".env"}


class AgentError(RuntimeError):
    pass


def project_root() -> Path:
    configured = os.environ.get("BADGYM_PROJECT_ROOT")
    root = Path(configured).expanduser() if configured else Path(__file__).resolve().parents[2]
    root = root.resolve()
    if not root.exists() or not root.is_dir():
        raise AgentError(f"Project root does not exist: {root}")
    return root


def resolve_project_path(relative_path: str, *, write: bool = False) -> Path:
    if not relative_path or "\x00" in relative_path:
        raise AgentError("A non-empty relative project path is required.")
    rel = Path(relative_path)
    if rel.is_absolute() or any(part in ("..", "") for part in rel.parts):
        raise AgentError("Absolute paths and path traversal are not allowed.")
    if any(part.lower() in DENIED_PARTS for part in rel.parts):
        raise AgentError("This path is protected by the local agent policy.")
    root = project_root()
    target = (root / rel).resolve()
    if target != root and root not in target.parents:
        raise AgentError("Path escapes the configured project root.")
    if write:
        allowed = rel.parts[0] in ALLOWED_WRITE_ROOTS or (len(rel.parts) == 1 and rel.name in ALLOWED_ROOT_FILES)
        if not allowed:
            raise AgentError("Writes are limited to lib/, test/, pubspec.yaml and analysis_options.yaml.")
        if target.exists() and target.is_symlink():
            raise AgentError("Writing through symbolic links is not allowed.")
    return target


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def run_process(args: list[str], *, timeout: int = 60, cwd: Path | None = None) -> dict[str, Any]:
    try:
        result = subprocess.run(
            args, cwd=str(cwd or project_root()), capture_output=True,
            text=True, errors="replace", timeout=timeout, shell=False,
            env={**os.environ, "CI": "1"},
        )
    except FileNotFoundError as exc:
        raise AgentError(f"Required executable not found: {args[0]}") from exc
    except subprocess.TimeoutExpired as exc:
        raise AgentError(f"Command timed out after {timeout}s: {args[0]}") from exc
    return {
        "command": args,
        "returncode": result.returncode,
        "stdout": result.stdout[-24000:],
        "stderr": result.stderr[-12000:],
        "ok": result.returncode == 0,
    }


def executable(name: str, env_name: str) -> str:
    configured = os.environ.get(env_name)
    found = configured or shutil.which(name)
    if not found:
        raise AgentError(f"{name} not found. Install it or set {env_name}.")
    return found


def adb(args: list[str], *, serial: str | None = None, timeout: int = 30, binary: bool = False):
    command = [executable("adb", "BADGYM_ADB_PATH")]
    if serial:
        command += ["-s", serial]
    command += args
    try:
        result = subprocess.run(command, capture_output=True, timeout=timeout, shell=False)
    except FileNotFoundError as exc:
        raise AgentError("Android Platform Tools (adb) are not installed or not on PATH.") from exc
    except subprocess.TimeoutExpired as exc:
        raise AgentError(f"ADB command timed out after {timeout}s.") from exc
    if result.returncode != 0:
        err = result.stderr.decode("utf-8", "replace")[-4000:]
        raise AgentError(err or f"ADB failed ({result.returncode}).")
    return result.stdout if binary else result.stdout.decode("utf-8", "replace")


def connected_devices() -> list[dict[str, str]]:
    output = adb(["devices", "-l"])
    devices = []
    for line in output.splitlines()[1:]:
        parts = line.split()
        if len(parts) >= 2:
            devices.append({"serial": parts[0], "state": parts[1], "details": " ".join(parts[2:])})
    return devices


def choose_device(serial: str | None = None) -> str:
    devices = connected_devices()
    ready = [d["serial"] for d in devices if d["state"] == "device"]
    requested = serial or os.environ.get("BADGYM_ADB_SERIAL")
    if requested:
        if requested not in ready:
            raise AgentError(f"Requested device {requested} is not in ADB state 'device'. Current devices: {devices}")
        return requested
    if len(ready) == 1:
        return ready[0]
    if not ready:
        raise AgentError(f"No authorized Android device. ADB inventory: {devices}")
    raise AgentError(f"Multiple Android devices are connected. Supply an exact serial: {ready}")


def tailscale_peers() -> list[dict[str, Any]]:
    ts = executable("tailscale", "BADGYM_TAILSCALE_PATH")
    result = run_process([ts, "status", "--json"], timeout=15, cwd=project_root())
    if not result["ok"]:
        raise AgentError(result["stderr"] or "Tailscale status failed.")
    try:
        payload = json.loads(result["stdout"])
    except json.JSONDecodeError as exc:
        raise AgentError("Tailscale returned invalid JSON.") from exc
    peers = []
    for peer in (payload.get("Peer") or {}).values():
        peers.append({
            "hostname": peer.get("HostName"),
            "dns_name": peer.get("DNSName"),
            "online": bool(peer.get("Online")),
            "os": peer.get("OS"),
            "ips": peer.get("TailscaleIPs") or [],
        })
    return peers


def validate_tailnet_endpoint(ip: str, port: int) -> str:
    try:
        address = ipaddress.ip_address(ip)
    except ValueError as exc:
        raise AgentError("A valid Tailscale IPv4 address is required.") from exc
    if address.version != 4 or address not in ipaddress.ip_network("100.64.0.0/10"):
        raise AgentError("Wireless ADB must use a Tailscale CGNAT IPv4 address (100.64.0.0/10).")
    if not 1 <= int(port) <= 65535:
        raise AgentError("ADB port must be between 1 and 65535.")
    if int(port) == 5555:
        raise AgentError("Do not assume legacy ADB port 5555; use the current Wireless Debugging connect port.")
    return f"{address.compressed}:{int(port)}"


def capture_screenshot(serial: str | None = None) -> tuple[str, bytes]:
    device = choose_device(serial)
    data = adb(["exec-out", "screencap", "-p"], serial=device, timeout=30, binary=True)
    if not data.startswith(b"\x89PNG\r\n\x1a\n"):
        raise AgentError("The connected device did not return a valid PNG screenshot.")
    return device, data


def write_project_file(relative_path: str, content: str, expected_sha256: str, approved: bool) -> dict[str, str]:
    if os.environ.get("BADGYM_AGENT_ENABLE_WRITES") != "1":
        raise AgentError("File writes are disabled. Set BADGYM_AGENT_ENABLE_WRITES=1 locally after reviewing the security policy.")
    if not approved:
        raise AgentError("Write not applied. Review the proposed content and call again with approved=true.")
    encoded = content.encode("utf-8")
    if len(encoded) > MAX_WRITE_BYTES:
        raise AgentError(f"File exceeds the {MAX_WRITE_BYTES}-byte write limit.")
    target = resolve_project_path(relative_path, write=True)
    current = target.read_bytes() if target.exists() else b""
    actual_hash = sha256_bytes(current) if target.exists() else "MISSING"
    if expected_sha256 != actual_hash:
        raise AgentError(f"Stale-file protection: expected {expected_sha256}, current file is {actual_hash}. Re-read before editing.")
    backup_root = Path.home() / ".badgym-agent" / "backups"
    backup_root.mkdir(parents=True, exist_ok=True)
    backup_path = None
    if target.exists():
        backup_path = backup_root / (sha256_bytes(str(target).encode())[:12] + "-" + target.name + ".bak")
        backup_path.write_bytes(current)
    target.parent.mkdir(parents=True, exist_ok=True)
    temp = target.with_suffix(target.suffix + ".agent-tmp")
    temp.write_bytes(encoded)
    os.replace(temp, target)
    return {"path": relative_path, "sha256": sha256_bytes(encoded), "backup": str(backup_path) if backup_path else "none"}
