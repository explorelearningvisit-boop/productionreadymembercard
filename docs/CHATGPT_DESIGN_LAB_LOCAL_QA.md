# Local evaluation — ChatGPT Design Lab

Run this in PowerShell from the existing local clone. A separate worktree avoids switching the branch used by Antigravity.

```powershell
git fetch origin
git worktree add ..\productionreadymembercard-chatgpt-design-lab origin/chatgpt/design-lab-yellow-festive
Set-Location ..\productionreadymembercard-chatgpt-design-lab
flutter pub get
flutter analyze --no-fatal-infos
flutter test --reporter expanded
flutter build apk --release
```

APK path: `build\app\outputs\flutter-apk\app-release.apk`.

The evaluation app package is `com.badgym.designlab`; production remains `com.badgym.bad_gym`. These package IDs are intentionally distinct, so the evaluation build can coexist with the production app. Install only the Design Lab APK:

```powershell
adb devices -l
adb install -r .\build\app\outputs\flutter-apk\app-release.apk
adb shell am start -W -n com.badgym.bad_gym/.MainActivity
```

For the Design Lab launch, query the package's launch activity first (the Android namespace remains `com.badgym.bad_gym` in this first branch revision); do not assume a component name if Android reports a different resolved activity. Never uninstall or clear production app data.

If using the GitHub Actions artifact, download it from the successful run for this branch. Check the workflow run and artifact SHA before installation. Android/MIUI may show a normal install confirmation; approve it on the phone.

## Tailscale / ADB

Use the existing documented `tools/badgym_local_agent/` and `docs/NETWORK_ARCHITECTURE.md` from the checked-out branch. The branch does not contain or copy Tailscale auth keys, ADB private keys, pairing codes, passwords, or fixed wireless-debugging ports. Verify the current peer and current Wireless Debugging connect port, then verify `adb get-state`. USB ADB remains preferred. Never expose ADB publicly.
