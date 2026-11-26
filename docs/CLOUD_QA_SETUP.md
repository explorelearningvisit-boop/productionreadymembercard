# BAD GYM cloud QA setup (laptop-free)

This repository has cloud workflow wiring for:
- GitHub-hosted Flutter/Android builds (no developer laptop required).
- Firebase Test Lab Robo runs on one virtual and one physical device when Google Cloud credentials are configured.
- Firebase App Distribution delivery when its app ID and token are configured.
- Guarded Jules repair invocation after a failed build, creating changes for human review only.

## Branch and safety model
- Working branch: `grok/purple-neon-member-dashboard`.
- Jules must not merge to `main`, change production configuration, or distribute a production release.
- The Jules workflow listens for failed `BAD GYM Android APK` runs on the working branch. GitHub's `workflow_run` event requires the workflow file to exist on the repository's default branch before automatic failure-triggered runs execute. Until this workflow is merged to `main`, test it manually using Actions > BAD GYM guarded AI repair > Run workflow.
- Review every AI-created PR before merging.

## Required GitHub Actions secrets

Add these under Repository Settings > Secrets and variables > Actions. Never put values in source files.

| Secret | Purpose |
|---|---|
| `GCP_PROJECT_ID` | Google Cloud project ID |
| `GCP_SERVICE_ACCOUNT_JSON` | Dedicated service-account JSON for Test Lab |
| `JULES_API_KEY` | Jules API key from jules.google |
| `FIREBASE_APP_ID` | Android Firebase App ID |
| `FIREBASE_TOKEN` | Firebase CLI CI token for App Distribution |

### Google Cloud / Firebase preparation
1. Create/select a Google Cloud project and link it to Firebase.
2. Enable Google Cloud Testing API and Cloud Tool Results API.
3. Create a dedicated CI service account. Grant only the roles required to submit Test Lab runs, consume project services, and access the configured test-results bucket. Do not use a personal account key.
4. Register the Android app in Firebase using the app's actual Android application ID, then enable App Distribution.
5. Create the tester group alias `bad-gym-qa` and add the owner's tester email.
6. Create a Firebase CLI CI token and store it as `FIREBASE_TOKEN`.
7. Add all five secrets above. Test Lab steps are skipped until GCP secrets exist; App Distribution is skipped until its app ID and token exist; Jules is skipped until its API key exists.

## Device matrix
The workflow currently requests:
- Virtual: `MediumPhone.arm`, API 34.
- Physical: `redfin` (Google Pixel 5), API 30.

Confirm these model/version combinations in the selected project's current Test Lab device catalog before relying on the matrix. Update the workflow if the catalog changes. Usage beyond the free quota may be billed.

## Jules setup
1. Open https://jules.google.com and connect the target GitHub repository.
2. Generate a Jules API key in Jules Settings.
3. Add it as `JULES_API_KEY`.
4. For automatic failure-triggered repair, merge `.github/workflows/jules-ci-repair.yml` and this document to the default branch after review.
5. Jules receives the failed run URL and recent commit context, diagnoses the failure, and is instructed to create a focused PR. Human review/merge remains required.

## Limitations
- No Firebase project ID, Android Firebase App ID, Google service-account credential, Firebase CLI token, or Jules API key was present in the inspected repository. Workflow wiring is committed, but cloud integrations cannot authenticate or run until these secrets are configured.
- Test Lab Robo tests explore app navigation/screens; they do not replace Flutter widget/unit tests or dedicated instrumentation tests.
- App Distribution delivers a tester release link and notification; it does not silently install an APK on the owner's phone. The owner opens the release link and approves Android installation.
- Firebase Test Lab uses Google-hosted devices and provides test artifacts/reports; it does not control the owner's physical phone or pull screenshots from it.
- ChatGPT is not a persistent background process. Jules is the independent cloud coding agent; ChatGPT can review resulting PRs and reports when asked.

## Test Lab lifecycle note
Google's current documentation marks the legacy Firebase Test Lab gcloud command group as deprecated, with full shutdown announced for 30 September 2027. This integration is a near-term bridge. Plan migration to Google Cloud Developer Device Platform before that date; do not build a long-term device-testing dependency on the legacy Test Lab CLI.
