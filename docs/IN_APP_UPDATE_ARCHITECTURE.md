# BAD GYM — In-App Update Center Architecture

Status: ACCEPTED ARCHITECTURE — implementation and production release signing pending.

## Product behaviour
- BAD GYM checks for a newer stable release at app startup (with cooldown) and on demand from Settings/About > Updates.
- Show installed version, latest version, release date, concise changelog, download size and Update button. Do not interrupt normal use with forced updates unless a future explicit minimum-supported-version policy is adopted.
- User taps Update; app downloads APK over HTTPS, verifies SHA-256, checks package/version metadata and stages the file in app-private cache.
- Android PackageInstaller / official package installer receives the staged APK. Android/MIUI may show confirmation or require the user to allow installs from BAD GYM. This is expected OS security behaviour. Never bypass it.
- Same package id com.badgym.bad_gym, monotonically increasing versionCode, same protected release signing certificate. Update in place; preserve app data. Never uninstall, clear data, downgrade, or install on signature mismatch.
- After Android completes update, launch the updated app when platform permits; otherwise show a clear Open button/notification.

## Release manifest
Publish a stable JSON manifest in GitHub Releases or a versioned repository path. Suggested schema:

```json
{
  "schemaVersion": 1,
  "channel": "stable",
  "versionName": "1.2.0",
  "versionCode": 10200,
  "minimumSupportedVersionCode": 10000,
  "releaseDate": "2026-11-16T12:00:00Z",
  "apkUrl": "https://github.com/OWNER/REPO/releases/download/v1.2.0/app-release.apk",
  "sha256": "64-lowercase-hex-characters",
  "sizeBytes": 12345678,
  "changelog": ["Compact dashboard", "Attendance calendar-first navigation"],
  "commit": "full-git-commit-sha"
}
```

Never use an Actions artifact URL as permanent production update URL; artifacts expire. Publish immutable APK assets in a GitHub Release and update stable manifest only after tests and signing pass. Validate HTTPS, expected GitHub release host/repository, schema, SHA-256, package id, versionCode and signature before offering install.

## Flutter/native boundary
- Flutter handles update check, changelog UI, progress, retry/cancel and error messaging.
- Android native Kotlin MethodChannel handles PackageManager version/signature inspection, app-private staged file and ACTION_INSTALL_PACKAGE / PackageInstaller handoff. Use FileProvider/content URI and temporary read permission. Never expose a public filesystem path.
- iOS is separate: use App Store/TestFlight distribution; do not attempt to sideload IPA through this Android updater.
- Remote config may update data-driven theme tokens/content only if explicitly designed and validated. It cannot replace arbitrary compiled Dart/Flutter code or widget logic. UI and logic changes require a new signed APK.

## Signing and security gates
- Installed app signing certificate is not yet verified against a protected production release key. Current CI build is QA/debug signed. It must not be advertised as an in-app production update until signing continuity is proven.
- Establish protected release keystore custody (GitHub encrypted secrets or dedicated signing service), rotate exposed credentials, and keep secrets out of repository, logs and artifacts.
- Release workflow: tests -> release APK -> inspect package/version/signature -> SHA-256 -> publish GitHub Release -> publish/update manifest -> verify manifest and asset download.
- Reject downgrade, hash mismatch, malformed manifest, non-HTTPS URL, wrong package, wrong certificate, unsupported channel, or missing asset.
- Android/MIUI user confirmation is mandatory for ordinary non-privileged apps. No silent install promise.

## Cross-agent history contract
Every AI/Antigravity/IDE agent must read this file and docs/UI_COMPACT_WORKSPACE_SPEC.md at task start. Every release appends (never overwrites) a changelog entry with UTC timestamp, agent, issue/task, commit SHA, changed files, rationale, tests, artifact/release URL, SHA-256, signing fingerprint identifier (never private key), known issues and next steps. Keep AI_SHARED_COMMUNICATION_HUB.md append-only and synchronize AI_SYNC_STATE.json and ANTIGRAVITY_TASK.md. Preserve historical entries and screenshots; no destructive cleanup.

## Acceptance tests
- Manifest schema/version/channel validation.
- HTTPS/host allowlist and JSON size/timeouts.
- SHA-256 correct and mismatch rejection.
- Package id/signing fingerprint match; mismatch stops safely.
- Downgrade and duplicate version rejected/no-op.
- Download progress, cancel, retry and interrupted-download recovery.
- Installer handoff uses content URI; user cancel leaves installed app/data untouched.
- Successful update preserves app data and returns to app/open action.
- GitHub release publication only after build/test/signature/hash validation.
