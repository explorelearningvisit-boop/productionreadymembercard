# BAD GYM GitHub APK + Tailscale Xiaomi QA

Firebase is not used by this workflow. The normal path builds and publishes an ARM64 APK as a GitHub Actions artifact. The optional physical-device lane connects an ephemeral GitHub-hosted runner to the owner's Tailscale network and uses Android Debug Bridge (ADB) to install, launch, capture a screenshot and collect bounded diagnostics from the paired Xiaomi.

## Normal APK download (no Tailscale required)

1. Open the repository's Actions tab.
2. Select **BAD GYM GitHub APK + Tailscale Xiaomi QA**.
3. Open a successful run and download the `bad-gym-arm64-apk-<run>` artifact.
4. Extract the ZIP on the Xiaomi and tap `app-release.apk`.
5. Approve Android's package-install permission when prompted.

The workflow formats Dart sources, runs `flutter analyze` and `flutter test`, builds `android-arm64`, verifies the APK signature and SHA-256, and retains the artifact for 30 days. A failed build does not produce an installable artifact.

## One-time Tailscale setup

### A. Tailscale account and policy

1. Install Tailscale on the Xiaomi and sign in to the same tailnet used for the CI integration.
2. In the Tailscale admin console, define the tag `tag:ci` for ephemeral GitHub runners.
3. Create an OAuth client with the `auth_keys` write scope and permission to apply `tag:ci`.
4. Configure the tailnet ACL/grants so `tag:ci` can reach only the Xiaomi device on TCP port 5555. Do not grant broad access to the tailnet.
5. Store the OAuth client ID and secret in GitHub repository Settings -> Secrets and variables -> Actions -> Secrets:
   - `TS_OAUTH_CLIENT_ID`
   - `TS_OAUTH_SECRET`

The official `tailscale/github-action@v4` registers an ephemeral CI node and removes it after the workflow ends. Never put OAuth credentials in source code or workflow variables.

### B. Xiaomi ADB setup

1. On Xiaomi, enable Developer options and USB debugging / Wireless debugging.
2. Pair/authorize ADB using Android's Wireless debugging flow. ADB must show the Xiaomi as an authorized device before proceeding.
3. Switch ADB to TCP mode on port 5555 from an already-authorized ADB host using `adb tcpip 5555`. This initial one-time ADB authorization step is not performed by GitHub.
4. Keep Tailscale connected on the Xiaomi. Find its Tailscale IPv4 address (normally in the `100.x.x.x` range).
5. Add repository Actions variable `TS_DEVICE_IP` with that Tailscale IPv4 address.
6. Add repository Actions variable `ANDROID_ADB_PORT` with `5555` (optional; workflow defaults to 5555).

ADB over TCP is still an administrative debugging interface. Restrict it to the CI tag in Tailscale ACLs, keep Android's ADB authorization enabled, and disable TCP debugging when not testing. Never expose port 5555 on the public internet or router.

## Run a Xiaomi device test

1. Open Actions -> **BAD GYM GitHub APK + Tailscale Xiaomi QA** -> Run workflow.
2. Select `run_tailscale_device_test = true`.
3. Start the run.
4. The workflow builds the APK, joins the tailnet as an ephemeral `tag:ci` node, connects to the configured Xiaomi, installs the APK, launches BAD GYM and captures a screenshot plus bounded logcat/device display diagnostics.
5. Download `bad-gym-xiaomi-device-qa-<run>` from the run's Artifacts.

The device lane is opt-in and only runs on manual dispatch. If Tailscale credentials or device address are missing, APK build remains independent and the remote lane is skipped. If ADB is not reachable/authorized, the device job fails with a diagnostic rather than silently claiming success.

## What this does not do

- It does not use Firebase, Firebase Test Lab or Firebase App Distribution.
- It does not install anything silently from the phone UI; ADB installation requires prior explicit Developer Options/ADB authorization.
- It does not expose public ADB, enable router port forwarding, run arbitrary shell commands supplied by a user, or collect SMS, contacts, microphone, camera or gallery data.
- It does not yet implement a standalone BAD GYM Companion Android app. This workflow uses Android's authorized ADB interface for the limited test sequence above.
