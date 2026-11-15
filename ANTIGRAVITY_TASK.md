# Antigravity Handoff — BAD GYM (2026-11-15)

## Read first
1. Read `CURRENT_DESIGN_SPEC.md`; it is the active visual authority and supersedes older purple/red-only notes.
2. Read this file before changing CI, build, device QA, assets, or app code.
3. Keep ChatGPT and Antigravity changes batched; avoid one commit per tiny edit when a single logical commit is possible.

## Latest verified device failure diagnosis
Workflow run #24: https://github.com/explorelearningvisit-boop/productionreadymembercard/actions/runs/43720865187
- Tailscale action connected successfully on attempt 1. Do not misdiagnose this run as a Tailscale join failure.
- Tailnet inventory showed Xiaomi 11i online at 100.123.18.54.
- ADB reached the phone.
- APK install failed first with `INSTALL_FAILED_UPDATE_INCOMPATIBLE`: installed app and new APK had different signing certificates.
- Workflow uninstalled the old app, then MIUI returned `INSTALL_FAILED_USER_RESTRICTED: Install canceled by user`.
- The actual blocker was unstable CI debug signing + MIUI install authorization, not Tailscale connectivity.

## CI optimizations committed
- Commit `61d17c5581e52f291ea0d827c7290ba728ed84f5`: bounded ADB connect retries with backoff, one Tailscale join reused for peer discovery, conditional Android tooling installation, removed duplicate Gradle cache (setup-gradle owns Gradle User Home caching), SDK packages installed only when missing, 30-second push debounce to avoid multiple rapid AI commits each launching a full build.
- Commit `a5086c6c233280805085967da5a1bd46461a607e`: Tailscale retry/timeout raised and auth mode selected from explicit step outputs; stable debug keystore cache step is present.
- Commit `fdb1b64f0605f906bfa294e6095bc2b28997eec2`: add non-streaming ADB install fallback; do not silently uninstall user app/data; record signature and MIUI permission failures distinctly.
- Latest validation run: https://github.com/explorelearningvisit-boop/productionreadymembercard/actions/runs/43722419265 (check live result before claiming pass).

## Remaining one-time device action
Because previous builds were signed with ephemeral runner debug keys, the installed Xiaomi app may still have a different signature. The workflow now caches the CI debug keystore for future builds, but first transition may require a one-time clean reinstall:
1. On Xiaomi 11i, enable Developer options > Install via USB (and USB debugging security settings if MIUI exposes it).
2. Keep phone unlocked and approve any install confirmation.
3. If result is `SIGNATURE_MISMATCH_NEEDS_STABLE_SIGNING`, ask user before uninstalling; do not erase app data automatically.
4. Once the first APK signed with the cached CI key is installed, later CI builds should retain that signing identity as long as the cache survives. For production distribution, replace this QA-only cached debug key with a protected release keystore stored as GitHub Actions secrets.

## Device QA implementation rules
- Tailscale is joined once per QA job. Do not re-run `tailscale up` per Android peer.
- Retry `tailscale ping` and `adb connect` with bounded backoff; distinguish tunnel failure, stale wireless-debug port, ADB authorization, install signature mismatch, and MIUI user restriction.
- Wireless ADB port is dynamic. Use `ANDROID_DEVICE_PORTS_JSON`; never hardcode 5555.
- Never auto-uninstall a member app or wipe its data on signature mismatch.
- Upload tailnet inventory, per-device ADB connection logs, install logs, screenshot and logcat even on failure.
- Do not claim a fresh screenshot/install unless current run artifacts prove it.

## Efficiency policy
- Use one logical commit for a batch of related edits.
- Let the 30-second debounce cancel superseded push runs before toolchain setup.
- Gradle cache is managed by `gradle/actions/setup-gradle@v4`; do not add a second cache for the same Gradle User Home.
- Flutter SDK cache is managed by flutter-action; pub cache uses its own lockfile-keyed cache.
- Android SDK components are installed only when missing.
- Device QA tools are installed only if absent.
- Skip unnecessary build/test/device steps for docs-only changes (docs are already excluded from push path filters).

## Credential security
- A base64 ADB private key was exposed in ChatGPT chat and is compromised; never reuse it.
- Never commit or print ADB private keys, Tailscale auth keys, OAuth secrets, keystores or passwords.
- Use GitHub encrypted Actions secrets only.
- For long-term stable production signing, use a dedicated protected keystore. The cached CI debug key is QA-only.

## Current project/device
- Repository: `explorelearningvisit-boop/productionreadymembercard`, branch `main`.
- Application ID: `com.badgym.bad_gym`.
- Xiaomi 11i 5G (21091116I), Android 13, Tailnet IP `100.123.18.54`.
- Device wireless ADB port must be discovered/refreshed; it is not permanently fixed.
