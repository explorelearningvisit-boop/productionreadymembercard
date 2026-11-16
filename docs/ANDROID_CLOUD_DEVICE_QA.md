# Android Cloud Build & Multi-Device Tailnet QA

GitHub Actions builds and tests the Flutter app in the cloud. On a manual run, a temporary GitHub runner joins the Tailnet, discovers visible peers, inventories all devices, and attempts APK QA on every online Android device that has an ADB port configured and an authorized ADB host key.

## Automatic cloud build

Pushes to `main` and `setup/flutter-member-intelligence` (for configured source paths), and pull requests targeting those branches:

1. Resolve Flutter dependencies.
2. Check Dart formatting.
3. Run `flutter analyze --no-fatal-infos` (warnings/errors fail; informational notices remain visible).
4. Run `flutter test`.
5. Build a release APK using the checked-in Android Gradle project.
6. Upload the APK as a 14-day workflow artifact.

The workflow does not run `flutter create`; it preserves checked-in platform project configuration.

## Multi-device behavior

The manual workflow input `run_device_test` defaults to true. It:

- joins Tailscale as an ephemeral `tag:ci` runner;
- saves `tailscale status --json` and a peer inventory;
- lists online/offline Tailnet peers of all operating systems;
- runs APK installation and launch checks only on Android peers;
- skips offline devices;
- reports Android peers without a configured ADB port as `ADB_PORT_NOT_CONFIGURED`;
- reports unreachable or unpaired ADB endpoints without stopping tests on other devices;
- for Xiaomi 11i only, tries the configured current port first and then the previously user-reported port `37337` as a bounded fallback; the fallback is not treated as a guaranteed current endpoint;
- uploads per-device install output, launch output, screenshots, Logcat, inventory, and a result table.

A Tailnet peer being visible/online does not itself mean it is ADB-paired or ready to install an APK. iOS, Windows, Linux, and macOS peers are inventory-only in this Android workflow; they cannot receive this Android APK through ADB.

## One-time Tailscale setup

Use Tailscale workload identity federation (OIDC), not a long-lived reusable auth key.

1. In Tailscale admin, create a `tag:ci` tag for the ephemeral GitHub runner.
2. Create a GitHub Actions federated identity for this repository, with the `auth_keys` scope, restricted to `tag:ci`.
3. Configure Tailscale access controls so `tag:ci` can reach only the approved Android QA devices on the required ADB TCP ports. Do not grant unrestricted Tailnet access.
4. Add these GitHub repository Actions secrets:

| Secret | Value |
| --- | --- |
| `TS_OAUTH_CLIENT_ID` | Tailscale federated identity client ID |
| `TS_AUDIENCE` | Matching audience |
| `DEVICE_ADB_PRIVATE_KEY_B64` | Base64-encoded private key for the CI ADB host identity, paired on each Android device |
| `ANDROID_DEVICE_PORTS_JSON` | JSON object mapping exact Tailnet hostnames to each device's current ADB connect port |

Example `ANDROID_DEVICE_PORTS_JSON` (replace ports with values from each phone; this is a configuration example, not live device data):

```json
{
  "xiaomi-11i": 5555,
  "oppo-a53": 5555,
  "as-tab-a9": 5555
}
```

Do not add device IPs in this map; the workflow discovers peer IPs from Tailscale. Hostname keys must exactly match Tailscale machine names. Add only Android devices that you authorize for app installation.

Never paste credentials, pairing codes, private keys, or auth keys into chat or commit them to this repository.

## Pair each Android device

Each target Android device must be configured once:

1. Keep the device signed in to the same Tailnet and enable Developer options → Wireless debugging.
2. On a trusted workstation, use the CI ADB host keypair. Pair it with each phone using **Pair device with pairing code**. The same CI public key must be authorized on every target device.
3. Keep the matching private key protected and store its Base64 encoding in `DEVICE_ADB_PRIVATE_KEY_B64`.
4. Record the device's current Wireless debugging connect port (not the pairing port) in `ANDROID_DEVICE_PORTS_JSON`.
5. Ensure the device remains online and Wireless debugging stays enabled.

Android Wireless Debugging ports may change, especially after reboot or reconnect. The Xiaomi workflow currently tries the configured port and one previously user-reported fallback (`37337`); if neither is active, the live connect port still needs to be re-registered. Do not assume port 5555 unless the device actually reports it. If using a stable ADB-over-TCP port, enable it only after pairing and restrict that port to the CI tag in Tailscale access controls; Android may reset this mode after reboot.

## Run fleet QA

1. Open **Actions → Android Cloud Build & Multi-Device QA**.
2. Select **Run workflow**.
3. Leave `run_device_test` enabled.
4. Start the workflow.

No laptop or local runner is needed during a workflow run. The phone must be powered on, connected to Tailscale, reachable under Tailnet policy, and ADB-authorized.

## Release-signing note

The current `android/app/build.gradle.kts` signs release builds with the debug signing configuration. The uploaded APK is suitable for QA, not Play Store production distribution. Configure a protected production keystore and signing secrets before publishing.

## Troubleshooting

- **Peer missing from inventory:** confirm the device is connected to the same Tailnet and visible to the CI node under Tailscale policy.
- **ADB port not configured:** add the exact Tailscale hostname and current connect port to `ANDROID_DEVICE_PORTS_JSON`.
- **ADB connection refused:** verify the phone's current Wireless debugging connect port and Tailscale ACL.
- **unauthorized / offline:** pair the CI ADB host public key on that device; ensure the stored private key matches.
- **APK install fails:** check storage and whether an existing install uses an incompatible signing identity.
- **App launch fails:** inspect that device's Logcat artifact and verify the application ID remains `com.badgym.bad_gym`.
