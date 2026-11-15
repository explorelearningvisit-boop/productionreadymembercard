> **CURRENT DESIGN AUTHORITY (2026-11-15):** Read [CURRENT_DESIGN_SPEC.md](CURRENT_DESIGN_SPEC.md) first. The latest approved UI is the user's red/crimson/gold/white BAD GYM reference. Royal Purple / Neon-Glow is historical and superseded. Member profile card must use a coordinated red treatment including payment, expiry and membership progress; vertical rail is burgundy/red. Do not hardcode the old purple design. Device verification is 100% automated via Tailscale CI artifacts.

# BAD GYM — Production Project Execution Rules & Device Connection Protocol

## 🎯 MAIN PROJECT SOURCE OF TRUTH
- **Sole Primary Project**: `C:\Users\User\AndroidStudioProjects\productionreadymembercard`
- **Remote Repository**: `https://github.com/explorelearningvisit-boop/productionreadymembercard.git`
- **Active Branch**: `main`
- **Application ID**: `com.badgym.bad_gym`
- **Main Launcher Activity**: `com.badgym.bad_gym/.MainActivity`
- *Note*: `badnewgym` is deleted and obsolete. All work, commits, builds, tests, and deployments occur strictly in `productionreadymembercard`.

---

## 📱 LIFETIME DEVICE CONNECTION PROFILE

| Parameter | Value | Details |
| :--- | :--- | :--- |
| **Model** | **Xiaomi 11i 5G** (`21091116I`) | Android 13, MIUI, 1080×2400 @ 2.75x |
| **Channel A (Wired USB)** | `zxdada69gunb7ls4` | Fast direct ADB debugging |
| **Channel B (Tailscale Wireless)** | `100.123.18.54` | Private mesh VPN network |
| **Wireless Port** | `5555` | Target: `100.123.18.54:5555` |
| **Tailscale Hostname** | `Xiaomi 11i` | Configured in Tailscale network |

---

## ⚡ AUTOMATIC DUAL-CHANNEL FALLBACK WORKFLOW

Whenever installing, testing, debugging, or taking screenshots:
1. **Check Wired Connection**:
   - Check `adb devices`.
   - If `zxdada69gunb7ls4` is connected as `device`:
     - Keep TCP mode enabled: `adb -s zxdada69gunb7ls4 tcpip 5555`.
     - Target commands directly with `-s zxdada69gunb7ls4`.
2. **Fallback to Tailscale Wireless**:
   - If wired is not connected, immediately connect to Tailscale:
     `adb connect 100.123.18.54:5555`
   - Target commands directly with `-s 100.123.18.54:5555`.
3. **Screen Wake & Screenshot Verification**:
   - Wake display and dismiss keyguard:
     `adb -s <target> shell input keyevent 224`
     `adb -s <target> shell wm dismiss-keyguard`
     `adb -s <target> shell am start -n com.badgym.bad_gym/.MainActivity`
   - Capture live screenshot:
     `adb -s <target> shell screencap -p /sdcard/bad_gym_live.png`
     `adb -s <target> pull /sdcard/bad_gym_live.png docs/screenshots/`

---

## 🏗️ BUILD & TEST COMMANDS
- Static Analysis: `flutter analyze` (Strict 0 errors/warnings)
- Test Suite: `flutter test`
- Build APK: `flutter build apk --debug`

---

## ☁️ ZERO-LAPTOP CLOUD CI/CD & AI AUTOMATION PIPELINE

### 1. Fully Autonomous Workflow
1. **AI / ChatGPT Development**: AI agent writes/modifies Flutter code and pushes commits directly to `main` branch on GitHub.
2. **Cloud Runner Build (GitHub Actions)**:
   - Ubuntu Linux Cloud Runner sets up Java JDK 17 & Flutter SDK.
   - Runs `flutter analyze`, `flutter test`, and Gradle build (`flutter build apk --release`).
   - Generates release APK artifact in the cloud.
3. **Over-The-Air Install & Live Screenshot (Tailscale)**:
   - Cloud Runner connects to user's phone via Tailscale: `adb connect 100.123.18.54:5555`.
   - Installs the latest APK (`adb install -r`).
   - Launches app: `am start -n com.badgym.bad_gym/.MainActivity`.
   - Captures live screenshot and automatically commits it to `docs/screenshots/bad_gym_live.png` with `[skip ci]`.
4. **AI Visual Verification**:
   - ChatGPT / AI agent directly inspects `docs/screenshots/bad_gym_live.png` from the repository.
   - Zero manual screenshots from user; zero laptop dependencies.
