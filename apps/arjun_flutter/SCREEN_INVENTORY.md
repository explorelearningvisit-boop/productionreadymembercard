# ARJUN Flutter screen and workflow inventory

## App shell
- Splash/brand entry: planned; current app opens dashboard directly.
- Role mode selector: implemented locally for Customer, Worker, Field Manager, Supplier.
- Bottom navigation: Home, Explore, Activity, Profile.
- Language toggle: Hindi/English label mode (partial localization only).

## Customer
- Dashboard and service categories: UI implemented.
- Create job sheet: local in-memory demo only.
- Job lifecycle: demo milestones in Operations.
- Worker match/quote/booking: not connected to a real dispatch backend.
- Checkout and payment confirmation: not implemented.

## Worker
- Browse local demo jobs and record interest: UI only.
- Availability, verified skills, KYC, attendance, earnings, payout and dispute flows: incomplete.
- Attendance module: demo check-in toggle only.

## Field Manager
- Inspection checklist: local UI only.
- Evidence capture/upload, assignment, approval permissions and audit events: incomplete.

## Supplier
- Sample inventory catalogue: UI only.
- Supplier onboarding, live stock sync, pricing API, purchase order, delivery tracking and invoice: incomplete.

## Shared
- Activity and notification screens: sample data only.
- Support/dispute intake: preview only, no server submission.
- Profile: role/language controls; identity verification not connected.

## Release gates
1. Backend schema, authenticated APIs and server-enforced role permissions.
2. Durable local persistence, offline queue, retries, conflict resolution and sync.
3. KYC provider, consent, data minimization and privacy/legal review.
4. Geocoding, location permissions, dispatch and messaging.
5. Payment provider sandbox, webhook verification, ledger reconciliation and marketplace settlement review.
6. Push notifications, observability, crash reporting, backups and incident response.
7. Unit, widget, integration, security and accessibility test suites.
8. Real-device QA on 320dp/low-memory Android and iOS devices; poor-network and app-upgrade tests.
9. Production Android signing and iOS signing/provisioning; store compliance review.

A successful compilation alone is not a production-readiness certification.
