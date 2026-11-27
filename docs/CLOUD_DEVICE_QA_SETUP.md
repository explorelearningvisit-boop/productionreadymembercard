# Cloud Device QA Setup

Workflow: .github/workflows/cloud-device-qa.yml

The workflow always runs Flutter checks, builds an ARM64 QA APK, verifies its signature and uploads a GitHub artifact. Firebase lanes are conditional and skip until the Firebase project is configured.

## Required GitHub Actions secrets
| Secret | Purpose |
|---|---|
| GCP_PROJECT_ID | Google Cloud / Firebase project ID |
| GCP_SERVICE_ACCOUNT_JSON | Service account JSON for Firebase Test Lab |
| FIREBASE_APP_ID | Android app ID registered in Firebase |
| FIREBASE_TOKEN | Firebase App Distribution CLI token |

Configure in repository Settings -> Secrets and variables -> Actions. Never commit these values or paste them into chat. Prefer workload identity federation / short-lived credentials over long-lived service-account keys.

## Firebase prerequisites
1. Create or select Firebase project.
2. Enable Firebase Test Lab API and required billing.
3. Register Android package com.badgym.bad_gym_member_intelligence.
4. Create App Distribution tester group bad-gym-qa.
5. Grant CI identity minimum required IAM roles.
6. Add google-services.json only when Firebase Android SDKs are integrated. The current app does not contain this file or Firebase SDK config.

GitHub artifact is the fallback delivery path. Firebase Test Lab tests cloud devices; it does not control the owner's physical Xiaomi. Physical control requires the opt-in companion, secure broker, pairing, MediaProjection consent and Accessibility opt-in.
