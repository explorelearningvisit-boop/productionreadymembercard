# Android Cloud Build & Xiaomi Wireless QA

This repository uses GitHub Actions for Flutter validation and Android APK builds. Optional physical-device QA connects a GitHub-hosted runner to the phone over Tailscale and Android Wireless Debugging.

## Automatic checks

Pushes to `main` and `setup/flutter-member-intelligence` (for configured source paths), and pull requests targeting those branches:

1. Resolve Flutter dependencies.
2. Check Dart formatting.
3. Run `flutter analyze --no-fatal-infos` (warnings/errors fail; informational notices remain visible).
4. Run `flutter test`.
5. Build a release APK using the checked-in Android Gradle project.
6. Upload the APK as a 14-day workflow artifact.

The workflow deliberately does **not** run `flutter create`; it must not regenerate checked-in Android/iOS project configuration.

## One-time Tailscale setup

Use Tailscale workload identity federation (OIDC), not a long-lived reusable auth key.

1. In Tailscale admin, create the `tag:ci` tag and allow it to access only the phone's ADB wireless-debugging endpoint.
2. Create a GitHub Actions federated identity for this repository. Grant the `auth_keys` scope and bind it to `tag:ci`.
3. Add these repository Actions secrets:

| Secret | Value |
| --- | --- |
| `TS_OAUTH_CLIENT_ID` | Tailscale federated identity client ID |
| `TS_AUDIENCE` | Matching audience |
| `DEVICE_TAILSCALE_IP` | Phone's current Tailscale IPv4 address |
| `DEVICE_ADB_PORT` | Current **Wireless debugging IP address & port** shown on the phone |
| `DEVICE_ADB_PRIVATE_KEY_B64` | Base64-encoded private key for the ADB host identity paired with the phone |

Never paste credentials, pairing codes, private keys, or auth keys into chat or commit them to this repository.

## Pair the ADB host identity

Android 11+ Wireless Debugging uses a pairing port and a separate connect/debug port. The connect port can change; do not assume TCP 5555.

For a persistent CI host identity, generate an ADB RSA keypair on a trusted workstation, pair that host with the phone from **Developer options → Wireless debugging → Pair device with pairing code**, then store the private key as the GitHub secret above. Encode the private key file as a single-line Base64 value before adding it to GitHub Actions secrets. Keep the matching public key and workstation private key protected.

If the phone's Wireless debugging connect port changes, update `DEVICE_ADB_PORT`. Keep Wireless debugging enabled and the phone online in Tailscale.

## Run physical-device QA

1. Open **Actions → Android Cloud Build & Device QA**.
2. Select **Run workflow**.
3. Enable `run_device_test`.
4. Start the workflow.

The device job downloads the APK, joins Tailscale as an ephemeral `tag:ci` node, connects to the configured ADB endpoint, installs and launches `com.badgym.bad_gym`, then uploads a screenshot and recent Logcat output.

## Release-signing note

The current `android/app/build.gradle.kts` signs release builds with the debug signing configuration. The uploaded APK is suitable for QA, not Play Store production distribution. Configure a protected production keystore and signing secrets before publishing.

## Troubleshooting

- **Tailscale ping/connect fails:** verify the phone is online in the same tailnet, the `tag:ci` ACL permits the phone's ADB endpoint, and the Tailscale IP is current.
- **ADB connection refused:** update `DEVICE_ADB_PORT` from the phone's Wireless debugging screen. Do not use the pairing port.
- **unauthorized / offline:** re-pair the restored ADB host public key with the phone and confirm the private-key secret corresponds to that paired identity.
- **APK install fails:** check storage and whether an existing install uses an incompatible signing identity.
- **App launch fails:** inspect the Logcat artifact and verify the application ID remains `com.badgym.bad_gym`.
