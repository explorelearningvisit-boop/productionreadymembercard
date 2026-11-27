# BAD GYM Companion

Architecture scaffold only; this folder is not yet a runnable Android application.

Planned opt-in companion for the owner's Xiaomi:
- explicit pairing and revocation;
- model, Android version, resolution and density diagnostics;
- user-approved MediaProjection screenshot sessions;
- AccessibilityService gestures limited to tap/swipe;
- visible stop/disconnect control;
- private upload of approved screenshots and bounded logs.

It will not offer arbitrary shell, unrestricted gallery/file access, silent installation, background screen recording or public ADB.

See ../docs/CLOUD_XIAOMI_COMPANION_ARCHITECTURE.md. Firebase provisioning and native Android implementation remain outstanding.
