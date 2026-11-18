# Android Device QA

The workflow builds an APK on every qualifying push. Physical-device QA runs only when the required secrets are configured and the device is reachable over the Tailnet.

## GitHub Actions secrets
- `TAILSCALE_AUTHKEY`: ephemeral/restricted auth key for the runner.
- `ANDROID_DEVICE_HOST`: current Tailscale IP or MagicDNS name of the Android device.
- `ANDROID_DEVICE_PORT`: current ADB wireless-debugging connect port.
- Optional pairing: `ANDROID_ADB_PAIRING_PORT` and `ANDROID_ADB_PAIRING_CODE`.

Never place these values in committed files or logs. Wireless debugging ports can change after reconnect/reboot; verify current values on the phone. Keep Android Wireless Debugging enabled and approve the runner's ADB connection. If the device is offline, CI reports device QA as skipped/blocked while preserving the APK artifact.

## Evidence
The job uploads APK, screenshot (when captured), logcat and install/launch report. A skipped device stage is not counted as a device pass.
