# BAD GYM — Antigravity Full-Run Handoff (Windows Laptop + Xiaomi + GitHub)

**Updated:** 2026-11-16  
**Repository:** https://github.com/explorelearningvisit-boop/productionreadymembercard  
**Branch:** `main`  
**Purpose:** Give Antigravity one complete, evidence-led task to sync the current Flutter app, run the full local validation/build, connect to the Xiaomi through authorized ADB (USB first, Tailscale/Wireless Debugging second), launch/smoke-test, capture screenshots/logs, and write a durable result back to GitHub for ChatGPT and future agents.

---

## 1. Read before doing anything

Read in this order:

1. `AGENTS.md`
2. `docs/AI_CONTEXT_BOOTSTRAP.md`
3. `AI_SYNC_STATE.json`
4. `CURRENT_DESIGN_SPEC.md`
5. `docs/UI_COMPACT_WORKSPACE_SPEC.md`
6. `ANTIGRAVITY_TASK.md`
7. `docs/NETWORK_ARCHITECTURE.md`
8. `docs/CHATGPT_ONLY_DEPLOYMENT.md`
9. `docs/LOCAL_AGENT_SETUP.md`
10. `docs/IN_APP_UPDATE_ARCHITECTURE.md`
11. `docs/CONTINUOUS_AGENT_OBSERVABILITY.md`
12. Latest entries in `AI_SHARED_COMMUNICATION_HUB.md`
13. `.github/workflows/android-cloud-device.yml` and latest GitHub Actions run/artifacts.

Then inspect the actual Flutter source, Android Gradle/signing configuration, local agent source and current git state. Do not trust old run IDs or stale ports.

## 2. Current known project state (verify it live)

- Flutter app; Android package: `com.badgym.bad_gym`; activity: `com.badgym.bad_gym/.MainActivity`.
- Main branch version last built: `0.2.0+2`.
- Last verified CI commit: `70f943f09e0e528241fd8df64a9cb05a00d0af3b`.
- Last verified CI run: [43879102167](https://github.com/explorelearningvisit-boop/productionreadymembercard/actions/runs/43879102167), attempt 2.
- CI result: Dart format PASS, Flutter analyze PASS, Flutter tests PASS, Android APK build PASS.
- Artifact: `bad-gym-android-release-70f943f09e0e528241fd8df64a9cb05a00d0af3b`; artifact ID `14231087792`; SHA-256 `c9fe784ce1db28dc2d4fe85bdbedc218303b3a3a1af5dd522e3c3de595006f08`.
- Latest Tailnet QA rerun: Xiaomi 11i peer appeared `Online=false`; no ADB connect/install/launch/screenshot was performed. This is the last known cloud QA evidence, not necessarily the live state now.
- Previous observed Xiaomi Tailscale IP: `100.123.18.54`; previous observed Wireless Debugging connect port: `37337`. Both are historical observations only. Query live Tailscale status and phone screen; do not hardcode the port.
- Primary device: Xiaomi 11i 5G (21091116I), Android 13 / MIUI.
- Existing BAD GYM installation and user data must be preserved.

## 3. Hard safety rules

1. **Never uninstall BAD GYM, clear app data, use `adb uninstall`, or run destructive reset commands.**
2. Never bypass Android/MIUI install confirmation or device security.
3. Before an APK replacement, inspect package ID, versionCode, and signing certificate compatibility. Use `adb install -r` only when signature continuity is confirmed. If Android returns `INSTALL_FAILED_UPDATE_INCOMPATIBLE`, stop, save the exact error, and preserve the existing installation/data. Do not work around it by uninstalling.
4. Do not assume a local Flutter debug APK has the same signature as the existing app or the GitHub Actions APK. Do not run `flutter run` if it would overwrite the installed package with an incompatible signing identity.
5. Do not assume Tailscale Online means ADB is reachable. Verify the actual ADB handshake and `adb get-state`.
6. Never assume port 5555. Wireless Debugging pairing port and connect port are different; the connect port changes.
7. Never expose ADB to public internet or add router port-forwarding.
8. Never print or commit tokens, Tailscale auth keys, ADB private keys, pairing codes, keystore files/passwords, environment dumps or other secrets. Previously exposed credentials must be rotated/revoked; do not reuse them.
9. Do not overwrite concurrent ChatGPT changes. Fetch/pull latest main and inspect diffs before edits.
10. Screenshots/logs must not contain OTPs, notifications, private messages, personal financial data or secrets. Crop/redact before committing evidence.

## 4. Windows PowerShell preflight — exact commands

Open PowerShell and run from the repository root. If the folder is elsewhere, locate it first; do not create a second stale clone.

```powershell
$Repo = "C:\Users\User\AndroidStudioProjects\productionreadymembercard"
Set-Location $Repo

git status --short --branch
git fetch origin
git pull --ff-only origin main
git log -5 --oneline --decorate

flutter --version
flutter doctor -v
java -version
adb version

tailscale status
adb start-server
adb devices -l
flutter devices
```

If the repo path differs, use the actual local checkout path and record it only in the local machine, not in public docs.

### Device connection decision

**A. USB ADB available**

- Select the Xiaomi serial shown by `adb devices -l` with state `device`.
- If state is `unauthorized`, resolve the phone's existing authorization prompt; do not reset keys unless required and explicitly approved.
- Confirm: `adb -s <SERIAL> get-state`.
- Read display: `adb -s <SERIAL> shell wm size` and `adb -s <SERIAL> shell wm density`.

**B. USB not available; use Tailscale + Wireless Debugging**

1. Check `tailscale status` and identify the Xiaomi peer by hostname and online state. Use the current Tailscale IPv4 reported by the CLI, not an old IP from this document.
2. On the phone, read the current Wireless Debugging screen. Record the current **pairing endpoint/port** and **connect endpoint/port** separately. Never write the pairing code to a log or GitHub.
3. If the ADB host has not been paired, run `adb pair <TAILSCALE_IP>:<CURRENT_PAIRING_PORT>` and enter the one-time code locally in the terminal prompt. Pairing may fail if the Android Wireless Debugging service does not bind/route over the Tailscale interface; do not guess alternate ports.
4. Connect using the current **connect port**, not pairing port:
   `adb connect <TAILSCALE_IP>:<CURRENT_CONNECT_PORT>`
5. Verify:
   `adb -s <TAILSCALE_IP>:<CURRENT_CONNECT_PORT> get-state`
   Expected exact output: `device`.
6. If no route/TCP handshake/ADB authorization, stop and capture redacted diagnostics. Do not switch to public IP, port-forwarding, guessed port 5555, or secret disclosure.

## 5. Full local validation/build

Only after source sync and preflight:

```powershell
flutter pub get
dart format --output=none lib test
if ($LASTEXITCODE -ne 0) { throw "Dart format failed" }

flutter analyze --no-fatal-infos
if ($LASTEXITCODE -ne 0) { throw "Flutter analyze failed" }

flutter test --reporter expanded
if ($LASTEXITCODE -ne 0) { throw "Flutter tests failed" }

flutter build apk --release
if ($LASTEXITCODE -ne 0) { throw "Android release build failed" }

$Apk = "build\app\outputs\flutter-apk\app-release.apk"
if (-not (Test-Path $Apk)) { throw "APK not found" }
Get-FileHash $Apk -Algorithm SHA256
```

Record Flutter, Dart, Java, Gradle, Android SDK/build-tools versions and exact commit SHA. Do not claim success if a command exits non-zero.

## 6. Launch and physical-device smoke test

First confirm the device is still authorized:

```powershell
adb devices -l
adb -s <SERIAL_OR_IP:PORT> get-state
adb -s <SERIAL_OR_IP:PORT> shell dumpsys package com.badgym.bad_gym
```

If BAD GYM is already installed, launch the **existing app without reinstalling**:

```powershell
adb -s <SERIAL_OR_IP:PORT> shell am force-stop com.badgym.bad_gym
adb -s <SERIAL_OR_IP:PORT> shell am start -W -n com.badgym.bad_gym/.MainActivity
adb -s <SERIAL_OR_IP:PORT> shell wm size
adb -s <SERIAL_OR_IP:PORT> shell wm density
adb -s <SERIAL_OR_IP:PORT> exec-out screencap -p > .\badgym-current-screen.png
adb -s <SERIAL_OR_IP:PORT> logcat -d -t 800 > .\badgym-logcat.txt
```

Inspect the screenshot and logcat. Redact sensitive content before any GitHub upload.

### Optional update/install — strict gate

Do not install the freshly built APK just because it exists. First verify:
- `applicationId` is `com.badgym.bad_gym`;
- APK versionCode is greater than or equal to installed versionCode and not a downgrade;
- APK signing certificate matches the installed package's signing certificate;
- the user has authorized this exact update.

Then use only in-place install:
```powershell
adb -s <SERIAL_OR_IP:PORT> install -r .\build\app\outputs\flutter-apk\app-release.apk
```
If signature compatibility is uncertain, do not install. If it fails with update-incompatible, preserve the existing app/data and report. Never use `adb uninstall`, `pm clear`, `-k` uninstall tricks, or data wipe.

### Flutter live run

`flutter run -d <SERIAL_OR_IP:PORT>` is for a development/debug session and may attempt to replace the installed app with a locally debug-signed APK. Use it only after verifying the local debug signing certificate matches the installed app. Otherwise launch the already-installed app with `am start` and test the QA APK via the safe update gate above.

## 7. Visual QA checklist — current compact workspace

At 360dp logical width and actual Xiaomi viewport:
- Attendance tab is selected by default and Calendar shows the current month.
- Four tabs remain visible: Attendance, Workout, Payment, Body.
- Member context is compact and readable.
- Calendar, Trend, History and Insights swap in the same bounded viewport; no vertical growth/scroll.
- Workout, Payment and Body contextual destinations render without overflow.
- Month navigation works.
- No RenderFlex overflow, clipping, missing assets, red error screen or runtime exception.
- Tap each top tab and each Attendance rail item; capture a screenshot after each meaningful state if safe.
- Record screen size/density and screenshot dimensions. Do not claim pixel-perfect until physical screenshots are inspected.

## 8. Evidence and GitHub write-back contract

Create a unique run folder, e.g. `qa/local-runs/2026-11-16T18-30-00+05-30/` (use actual local time). Include:

- `RUN_REPORT.md`: local time + UTC, operator/agent, commit SHA, branch, host OS, tool versions, device model/serial (redact serial if public), network type (Wi-Fi/cellular/hotspot/Ethernet; no SSID/password), Tailscale peer online state, ADB transport type, current endpoint port (port is not a secret), each command + exit code, tests, APK hash, install/launch outcome, screenshot names, log locations, failures, root causes, retries and next actions.
- `screenshots/`: only reviewed/redacted screenshots. Keep binary screenshots reasonably sized.
- `logs/`: only redacted relevant log excerpts, never full secret-bearing environment output.
- Update `AI_SYNC_STATE.json` with the latest local run ID, commit, test/build/device evidence, artifact hashes and blockers.
- Append (never replace) a timestamped entry to `AI_SHARED_COMMUNICATION_HUB.md`.
- Update `ANTIGRAVITY_TASK.md` with remaining tasks and exact next action.
- Update `docs/DECISION_LOG.md` only if a new architecture/security/product decision was made.
- Commit and push the report/evidence to GitHub (prefer a focused branch + PR if main changed during work). Do not force-push.
- Include commit URL, Actions run URL and evidence file URLs in the handoff so ChatGPT can fetch them on the next turn.

Suggested evidence commit:
```powershell
git status --short
git add qa/local-runs AI_SYNC_STATE.json AI_SHARED_COMMUNICATION_HUB.md ANTIGRAVITY_TASK.md
git commit -m "qa(android): record Antigravity full device run"
git push origin HEAD
```
If no source changes were made and only a report is needed, commit only the run report and required state/handoff docs. Do not stage secrets, keystores, APKs unless the repository explicitly uses Git LFS/release assets, or unredacted logs.

## 9. Antigravity copy/paste master task

You are the BAD GYM Flutter Android build + Xiaomi physical QA operator. Follow `docs/ANTIGRAVITY_FULL_RUN_HANDOFF.md` and every repository instruction. Do not ask the user to restate project history.

Start by syncing latest `origin/main`, checking git status, reading the required docs, reviewing the latest Actions run/artifacts, and inspecting the actual source and signing setup. Then run the Windows PowerShell preflight and full validation/build exactly as documented. Discover the phone via USB ADB first; if absent, use the currently online Tailscale Xiaomi peer and the phone's currently displayed Wireless Debugging pairing/connect ports. Never guess ports.

First launch the already-installed BAD GYM without reinstalling and capture a reviewed screenshot/logcat. Run the compact workspace visual smoke test. Only install the new APK if package/version/signing certificate compatibility is verified. Use `adb install -r` only; never uninstall or clear data. If signature mismatch or MIUI restriction appears, stop and preserve app/data.

Do not pretend local MCP, Tailscale, ADB, phone install or screenshot is working until a fresh tool/log confirms it. Do not claim `flutter run` is safe before checking debug signing identity. Use the existing BAD GYM Local Agent MCP only if it is installed/configured in this Antigravity client; its current tools do not include arbitrary shell or `flutter run`, so use Antigravity's own approved integrated terminal for the documented PowerShell/Flutter commands. Use Local Agent tools for health, ADB inventory, Tailscale peer inventory, screenshot, logcat, launch and guarded in-place APK install.

When done, create `qa/local-runs/<timestamp>/RUN_REPORT.md`, commit redacted evidence, update `AI_SYNC_STATE.json`, append `AI_SHARED_COMMUNICATION_HUB.md`, update `ANTIGRAVITY_TASK.md`, and push a commit/PR to GitHub. Include exact commit, Actions run, screenshot and report URLs. ChatGPT will read the new GitHub handoff and continue from that evidence. Preserve all prior history and concurrent work.

## 10. Definition of done

- [ ] Latest main synced and local changes reconciled.
- [ ] Flutter format, analyze, tests and release APK build pass locally.
- [ ] Xiaomi detected and ADB `get-state=device` verified.
- [ ] Existing app launched without uninstall/data clear.
- [ ] Current screen and compact workspace screenshots captured and inspected.
- [ ] Each tab and Attendance rail item smoke-tested.
- [ ] Update install attempted only after signature/version checks; otherwise blocker recorded.
- [ ] Redacted report/evidence committed and pushed to GitHub.
- [ ] AI_SYNC_STATE, AI_SHARED_COMMUNICATION_HUB and ANTIGRAVITY_TASK updated.
- [ ] Exact next action and any user-only Android confirmation clearly recorded.
