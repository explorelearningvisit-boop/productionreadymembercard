from __future__ import annotations

import os
import shutil

from mcp.server.fastmcp import FastMCP, Image

from . import agent_core as core
from .agent_core import AgentError

mcp = FastMCP(
    "BAD GYM Local Agent",
    instructions=(
        "Local Windows development agent for the BAD GYM Flutter repository. "
        "Prefer USB ADB; use an explicitly supplied current Tailscale Wireless Debugging endpoint otherwise. "
        "Never guess an ADB port, expose ADB publicly, uninstall the app, wipe data, or run arbitrary shell commands. "
        "File writes require BADGYM_AGENT_ENABLE_WRITES=1, approved=true, and an expected SHA-256."
    ),
)


@mcp.tool()
def agent_health() -> dict:
    """Return safe local agent, project path, and toolchain availability."""
    root = core.project_root()
    return {
        "agent": "BAD GYM Local Agent",
        "project_root": str(root),
        "project_exists": root.exists(),
        "adb_available": bool(os.environ.get("BADGYM_ADB_PATH") or shutil.which("adb")),
        "flutter_available": bool(shutil.which("flutter")),
        "tailscale_available": bool(os.environ.get("BADGYM_TAILSCALE_PATH") or shutil.which("tailscale")),
        "writes_enabled": os.environ.get("BADGYM_AGENT_ENABLE_WRITES") == "1",
    }


@mcp.tool()
def list_android_devices() -> list[dict]:
    """List ADB devices and their authorization state. Does not change device state."""
    return core.connected_devices()


@mcp.tool()
def list_tailscale_peers() -> list[dict]:
    """List online/offline Tailscale peer metadata; never returns auth keys or secrets."""
    return core.tailscale_peers()


@mcp.tool()
def connect_wireless_adb(tailscale_ip: str, current_connect_port: int) -> str:
    """Connect to an Android Wireless Debugging endpoint over Tailscale. Requires the current port; never guesses 5555."""
    endpoint = core.validate_tailnet_endpoint(tailscale_ip, current_connect_port)
    response = core.adb(["connect", endpoint], timeout=20)
    state = core.adb(["-s", endpoint, "get-state"], timeout=15).strip()
    if state != "device":
        raise AgentError(f"ADB endpoint responded but is not authorized/ready: {state}; connect output: {response}")
    return f"Connected and verified ADB device state for {endpoint}."


@mcp.tool()
def capture_android_screenshot(serial: str | None = None) -> Image:
    """Capture the current Android display and return the PNG image directly to the MCP client."""
    _, png = core.capture_screenshot(serial)
    return Image(data=png, format="png")


@mcp.tool()
def get_android_logcat(serial: str | None = None, lines: int = 500) -> str:
    """Read a bounded tail of Android logcat for the selected authorized device."""
    if not 1 <= lines <= 2000:
        raise AgentError("lines must be between 1 and 2000.")
    device = core.choose_device(serial)
    return core.adb(["logcat", "-d", "-t", str(lines)], serial=device, timeout=30)[-30000:]


@mcp.tool()
def get_android_screen_resolution(serial: str | None = None) -> str:
    """Return Android display size and density for responsive UI debugging."""
    device = core.choose_device(serial)
    size = core.adb(["shell", "wm", "size"], serial=device).strip()
    density = core.adb(["shell", "wm", "density"], serial=device).strip()
    return f"Device: {device}\n{size}\n{density}"


@mcp.tool()
def tap_android_screen(x: int, y: int, serial: str | None = None) -> str:
    """Tap a coordinate on the selected device. Coordinates are bounded to 0..10000."""
    if not (0 <= x <= 10000 and 0 <= y <= 10000):
        raise AgentError("Tap coordinates must be integers between 0 and 10000.")
    device = core.choose_device(serial)
    core.adb(["shell", "input", "tap", str(x), str(y)], serial=device)
    return f"Tap sent to {device} at ({x}, {y})."


@mcp.tool()
def swipe_android_screen(x1: int, y1: int, x2: int, y2: int, duration_ms: int = 350, serial: str | None = None) -> str:
    """Swipe on the selected device with bounded coordinates and duration."""
    coords = (x1, y1, x2, y2)
    if any(v < 0 or v > 10000 for v in coords):
        raise AgentError("Swipe coordinates must be integers between 0 and 10000.")
    if not 50 <= duration_ms <= 5000:
        raise AgentError("Swipe duration must be between 50 and 5000 ms.")
    device = core.choose_device(serial)
    core.adb(["shell", "input", "swipe", *(str(v) for v in coords), str(duration_ms)], serial=device)
    return f"Swipe sent to {device}."


@mcp.tool()
def press_android_key(key: str, serial: str | None = None) -> str:
    """Press one safe navigation key: BACK, HOME, ENTER or APP_SWITCH."""
    keycodes = {"BACK": "4", "HOME": "3", "ENTER": "66", "APP_SWITCH": "187"}
    if key not in keycodes:
        raise AgentError("key must be BACK, HOME, ENTER or APP_SWITCH.")
    device = core.choose_device(serial)
    core.adb(["shell", "input", "keyevent", keycodes[key]], serial=device)
    return f"{key} key sent to {device}."


@mcp.tool()
def launch_bad_gym(serial: str | None = None) -> str:
    """Launch BAD GYM on an already authorized device; does not install or clear data."""
    device = core.choose_device(serial)
    result = core.adb(["shell", "am", "start", "-W", "-n", core.APP_ACTIVITY], serial=device, timeout=30)
    return f"Device: {device}\n{result[-8000:]}"


@mcp.tool()
def run_flutter_task(task: str) -> dict:
    """Run one allowlisted Flutter command: analyze, test, or build_apk. No arbitrary command execution."""
    commands = {
        "analyze": (["flutter", "analyze", "--no-fatal-infos"], 300),
        "test": (["flutter", "test", "--reporter", "expanded"], 600),
        "build_apk": (["flutter", "build", "apk", "--release"], 900),
    }
    if task not in commands:
        raise AgentError("task must be analyze, test, or build_apk.")
    args, timeout = commands[task]
    return core.run_process(args, timeout=timeout)


@mcp.tool()
def read_project_file(relative_path: str) -> str:
    """Read a bounded text source file within the project; secrets, build output and .git are blocked."""
    path = core.resolve_project_path(relative_path)
    if path.suffix.lower() in {".env", ".pem", ".key", ".jks", ".keystore"} or path.name.lower().startswith("secret"):
        raise AgentError("Sensitive file type/name is blocked.")
    if not path.is_file():
        raise AgentError("Project file does not exist.")
    data = path.read_bytes()
    if len(data) > core.MAX_READ_BYTES:
        raise AgentError("File is larger than the 1 MB read limit.")
    return data.decode("utf-8", "replace")


@mcp.tool()
def write_project_file(relative_path: str, content: str, expected_sha256: str, approved: bool = False) -> dict:
    """Apply a complete file replacement only after explicit approval and stale-hash validation; writes are disabled by default."""
    return core.write_project_file(relative_path, content, expected_sha256, approved)


@mcp.tool()
def install_release_apk(serial: str | None = None, approved: bool = False) -> str:
    """Install the already-built release APK in-place. Requires approved=true; never uninstalls or clears app data."""
    if not approved:
        raise AgentError("APK install requires explicit approval. Call again with approved=true after reviewing target and artifact.")
    device = core.choose_device(serial)
    apk = core.project_root() / "build" / "app" / "outputs" / "flutter-apk" / "app-release.apk"
    if not apk.is_file():
        raise AgentError("Release APK not found. Run run_flutter_task('build_apk') first.")
    result = core.adb(["install", "-r", "-d", "-g", str(apk)], serial=device, timeout=180)
    return f"Installed on {device} without uninstalling or clearing app data.\n{result}"


if __name__ == "__main__":
    mcp.run(transport="stdio")
