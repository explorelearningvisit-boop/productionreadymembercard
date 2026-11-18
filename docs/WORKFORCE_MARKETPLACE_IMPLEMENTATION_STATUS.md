# Workforce marketplace implementation baseline

## Product scope
One marketplace for workers, customers/property owners, contractors, site managers, companies, suppliers and platform operations. It is not limited to construction labour.

## Product rules carried into implementation
- Flutter/Dart; Android and iOS.
- Hindi-first with English language option; plan for Bhojpuri/Awadhi voice guidance.
- Low-end device performance, large touch targets, low-data mode and offline-first capture.
- Worker experience: emerald/orange, visual-first navigation, nearby jobs, skills, applications, attendance, verified task progress and earnings.
- Provider experience: purple/blue, job creation, applicants, team assignment, site/project progress, quality review, wage ledger and supplier requests.
- No fabricated worker identities, ratings, job counts, payments, attendance, reviews or analytics.
- Never equate time at site with completed work. Use agreed task/milestone acceptance criteria, evidence, and authorized review.
- Construction quantities and safety-critical work must be approved by a competent site/structural professional; do not optimize speed at the expense of safety.
- Before assignment, show approximate location only; share precise location only when required and consented to for an active job.
- Ads and sponsored listings must be clearly labelled and separated from organic matching.
- Local device cache is not cloud sync and is not a production backend.

## Repository baseline inspected
Branch: `rebuild/kaamverse-platform`
App: `apps/arjun_flutter`
Current UI at baseline was a single-file demo with hard-coded sample workers, jobs, payments and metrics. Job posting only modified in-memory state. Attendance, KYC, messaging, payments and matching were explicitly demo-only. These are not production workflows.

## Implemented in this increment
- Typed domain models for jobs, applications, worker profiles, attendance, payment ledger entries and verified work milestones.
- Explicit paise-based money representation and typed units/statuses.
- Offline local persistence adapter using SharedPreferences.
- Tests for model round-trip and milestone verification semantics.
- Documentation of product invariants and remaining production blockers.

## Production blockers (must not be represented as complete)
1. Authentication, account recovery, consent and role-based authorization.
2. Secure server-side database, APIs, migrations, row-level access controls and audit logs.
3. Worker/owner KYC and fraud/safety review processes.
4. Real job discovery, geospatial matching, applications, assignment and replacement workflows.
5. Attendance verification and dispute process; GPS/QR alone is not proof of work quality.
6. Task/milestone evidence, quality acceptance, change orders, delay reasons and fair dispute resolution.
7. Payment gateway/escrow or regulated payout partner, reconciliation, refunds and tax/accounting records.
8. Supplier catalog, stock/quote/order/delivery and invoice workflows.
9. Notifications, voice guidance, localization and offline conflict resolution.
10. Privacy/security review, legal review, accessibility and abuse reporting.
11. Android/iOS release signing, device matrix QA, crash monitoring, backup/restore and operational support.
12. Production data, support/admin console, moderation, analytics and incident response.

## Verification status
No production backend credentials or payment/KYC provider configuration are present in the checked-out project. The current increment is a domain/offline foundation, not a complete production release. CI must pass before claiming this increment builds.
