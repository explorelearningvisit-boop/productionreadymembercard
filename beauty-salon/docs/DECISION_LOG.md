# Decision Log

## 2026-11-18 — Isolated project workspace
- Decision: place the salon application in `beauty-salon/` on branch `feature/beauty-salon-app`.
- Rationale: isolate this app from unrelated repository projects while reusing the linked GitHub repository and its Actions capability.
- Impact: app code/docs/assets remain in the subfolder; workflow file must be at root `.github/workflows/` because GitHub Actions only discovers workflows there.

## 2026-11-18 — Flutter Android-first
- Decision: Flutter/Dart for the native Android application.
- Rationale: user explicitly requested an Android APK and a runner-driven build/install/QA loop.

## Pending decisions
- Final product/brand name.
- Backend provider, hosting and data residency.
- Authentication/OTP provider and RBAC model.
- Payment gateway and tax configuration.
- Production application ID, signing keystore and release process.
