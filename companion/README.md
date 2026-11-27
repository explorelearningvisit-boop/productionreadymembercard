# BAD GYM Companion

A standalone Android Companion application is not implemented yet.

## Current physical-device testing path

The current workflow uses the Xiaomi's explicitly authorized Android Debug Bridge (ADB) endpoint over Tailscale. It can install and launch the QA APK, capture one screenshot and collect bounded diagnostics. See [Cloud Device QA Setup](../docs/CLOUD_DEVICE_QA_SETUP.md).

## Possible future companion

A native companion may later add explicit pairing/revocation, device diagnostics, user-approved MediaProjection screenshot sessions, narrow AccessibilityService gestures and a visible stop/disconnect control.

It must not offer arbitrary shell, unrestricted gallery/file access, silent background recording, silent installation or public ADB.
