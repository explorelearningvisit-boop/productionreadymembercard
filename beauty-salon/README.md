# Beauty Salon App

An isolated Flutter Android application workspace inside this repository. All product code, assets, documentation and app-specific automation live under `beauty-salon/`; the GitHub Actions entrypoint lives at the repository-required `.github/workflows/beauty-salon-android.yml`.

## Product scope
Three role-based experiences: Customer, Owner and Staff. Initial vertical slice: role selection, premium salon visual system, responsive dashboard shell and build/QA automation. Booking, service catalogue, CRM, POS, inventory, payroll/commission and analytics will be delivered in subsequent increments.

## Local build
```bash
cd beauty-salon
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

## CI secrets for optional physical-device QA
Configure repository Actions secrets: `TAILSCALE_AUTHKEY`, `ANDROID_DEVICE_HOST`, `ANDROID_DEVICE_PORT`. Optional wireless pairing: `ANDROID_ADB_PAIRING_PORT`, `ANDROID_ADB_PAIRING_CODE`. Never commit credentials or signing keys. See [device QA guide](docs/DEVICE_QA.md).
