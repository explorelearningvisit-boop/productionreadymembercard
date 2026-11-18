# ARJUN Workforce Marketplace — Product & Engineering Plan

This plan is derived from the uploaded ARJUN phone screens (files 1000320164–1000320171 and 1000320375–1000320405), the uploaded multi-screen concept boards (including the ARJUN ecosystem, owner/worker portal, marketplace, task/progress and supplier panels), and the user's requirements recorded on 17–18 Nov 2026. It is not a claim that every concept-board card is already implemented.

## 1. Product definition

A cross-platform Flutter app for Android and iOS that moves local work from informal phone calls/cash coordination into a trusted digital work network. It serves workers and service professionals, customers/property owners, contractors, site managers, companies/builders, suppliers and platform operations. Construction is an important vertical, not the only vertical.

## 2. Source-derived UX inventory

### Existing uploaded phone-screen flow
1. ARJUN welcome / sign-in entry.
2. Role selection: worker or customer/provider; profile also exposes role switching.
3. Worker home: greeting, primary "find work" action, quick categories, nearby jobs.
4. Worker job search: search, category chips, job cards with rate/unit and location.
5. Worker attendance: check-in affordance and weekly attendance view.
6. Worker earnings: balance summary, withdraw affordance, transaction list.
7. Worker profile: language, KYC, rating/reviews, help/SOS, privacy.
8. Provider home: create a job, workforce/project KPIs, quick actions.
9. Provider job listing and post-job flow: category, title, site, rate, unit, headcount and urgency.
10. Provider team: member list, skills and ratings.
11. Project progress: stage progress and milestone payment placeholder.

### Concept-board extensions to carry into the product
- Separate worker and provider visual languages, green/emerald worker and purple provider.
- Role-specific dashboards, quick action tiles, task and attendance states, wallet/payment and notification surfaces.
- Supplier/product marketplace and promoted listings for cement, steel, paint, plumbing, wiring, lights, tools and safety products.
- Location/map views for nearby jobs, available workers and suppliers.
- Work progress, evidence and quality review rather than a simplistic percentage-only progress bar.
- Admin and manager operations surfaces, moderation, support and analytics.

### Explicit exclusions from references
Some images in the upload batch are unrelated advertisements, gym UI or generic design inspiration. They are not ARJUN product requirements and must not be copied into this app. Concept-board sample names, balances, ratings and counts are placeholders, not real user data.

## 3. Hard product rules from user requirements

- Flutter cross-platform Android/iOS; not a website-first rewrite.
- Hindi-first, with English toggle and future Bhojpuri/Awadhi voice guidance. Use visual/icon-led flows and short labels for low-literacy users.
- Small screens, low RAM and intermittent connectivity are first-class constraints. Offline capture and queued sync are required.
- Role-wise access and role switching for worker, owner/customer, contractor, site manager, supplier and admin.
- Use real market rates/reference rates; do not create a bidding race or race-to-the-bottom auction.
- Owner/customer pays through the app; workers receive app-mediated payment. Do not depend on owner handing out cash on site.
- Site manager handles deployment, attendance, materials, quality verification and replacement coordination.
- QR/GPS are evidence signals, not conclusive proof of attendance or completed work. Use consent, anti-spoofing controls, audit trail and dispute path.
- A large work package must be decomposed into measurable tasks. Example: planned 16 pillars vs 4 accepted is a measurable shortfall, not a reason to blindly penalize workers.
- Task record must include scope, unit, target quantity, agreed time window, responsible lead, helpers/substitutes, evidence, acceptance criteria and authorized verifier.
- Fair contributor-level pay: attribute accepted quantity/contribution to the responsible people; do not pay only the team lead by default.
- Record delay causes separately: weather, missing materials, design change, equipment failure, absent worker, access/site hold and owner-caused hold.
- Construction safety and quality approval must be explicit. Structural/engineering-sensitive tasks require competent professional approval; no unsafe speed incentives.
- Supplier/product listing and sponsored ads must be clearly labelled; do not disguise advertising as neutral recommendations.
- Exact location is privacy-sensitive: show approximate area before assignment; reveal exact site details only to authorized assigned people when needed.

## 4. Role journeys and modules

### Worker
Onboarding + language + phone verification + consent; skills/experience/availability; optional KYC; nearby jobs; transparent rate/unit/scope; apply/accept; assigned job details; QR/GPS check-in/out with fallback; task updates and photo evidence; earnings ledger; payout status; replacement request; safety/SOS; ratings and dispute/help.

### Customer / owner
Create service or work request; select category; describe scope and location; view market-rate guidance; choose fixed unit/rate; review applications or matching shortlist; fund/authorize app payment; monitor team and task progress; approve quality evidence; handle change orders and disputes; download invoices/ledger.

### Contractor
Create work packages; recruit team; assign lead/helpers/substitutes; plan task dependencies; request materials; track accepted output; submit evidence; manage change orders and wage allocation.

### Site manager
Daily roster; check-in exceptions; task assignment; material receipt/shortage; site diary; weather/equipment/design-delay reasons; safety checklist/toolbox talk; quality inspection; approve/reject with reason and evidence; replacement workflow.

### Supplier / brand
Catalog, verified business profile, stock/availability, location radius, quote at displayed/reference rate, order, delivery proof, invoice, returns and sponsored listing disclosure.

### Admin / operations
KYC and abuse review; worker/owner/supplier verification; complaints and disputes; payment reconciliation; fraud signals; sponsored content moderation; audit log; support SLA; service/category/rate-card configuration; analytics.

## 5. Work completion and wage model

Do not treat attendance hours as completed output. Each task needs:
- Scope + measurable unit + target quantity.
- Agreed price basis and milestone schedule.
- Task owner and named contributors.
- Start/end time and delay codes.
- Evidence before/after, inspection checklist and verifier.
- Accepted/rejected/partially accepted quantity with reason.
- Change order for scope changes.
- Per-contributor accepted work allocation and transparent earnings ledger.
- Dispute hold only on the disputed portion; undisputed accepted work should not be silently withheld.

## 6. Architecture

### Client
Flutter feature-first architecture:
- app shell / role-aware navigation
- design system / localization
- auth and identity
- profiles / KYC
- marketplace / search / maps
- jobs / applications / assignment
- site operations / attendance
- task plans / milestones / evidence
- materials / suppliers
- wallet / payment ledger / payout
- notifications / chat / support / disputes
- admin operations
- local database / outbox / background sync

### Data
Typed domain models already added under `lib/domain`. SharedPreferences adapter currently provides a small local cache only; before production, move operational records and outbox to a transactional local database (SQLite/Drift or equivalent), with schema migrations and encrypted secrets.

### Server
Use Firebase-ready service boundaries, but do not treat Firebase client security as sufficient. Production requires server-enforced authorization, verified identity, auditable payment state transitions, secure file rules, rate limiting, idempotency and backups. No production credentials have been found in the checked-in project so far.

### Sync
Outbox pattern with stable IDs, idempotency keys, retry/backoff, conflict resolution, server timestamps and explicit sync status. Never overwrite a newer server state with stale offline data.

## 7. Security, privacy and trust
Least-privilege role and job/site-scoped access; OTP/session controls; consent and data minimization; encrypted transport and secure token storage; server-side validation; signed/expiring media URLs; location precision policy; append-only financial audit trail; idempotent payouts; abuse report/block; moderation and dispute evidence retention; account deletion/export process.

## 8. Delivery gates (no false production claims)

P0 — stabilize foundation: remove hard-coded demo identities/metrics, design tokens, localization, navigation, validation, accessibility and tests.
P1 — authentication/profile/roles + server schema and authorization.
P2 — job create/search/apply/shortlist/assign/cancel/replacement.
P3 — task plan, site diary, attendance evidence, delays, quality and milestone approval.
P4 — ledger, owner funding, worker payout, refunds/disputes and reconciliation.
P5 — supplier catalog, stock/quotes/orders/delivery/invoices and sponsored ads.
P6 — maps, notifications/chat, voice guidance, offline transactional sync.
P7 — admin console/operations, analytics, moderation, audit and support.
P8 — security review, legal/payment-provider review, load tests, Android/iOS device matrix, signed release, crash reporting, backups, staged rollout and rollback.

A release is production-ready only when CI tests pass, no fabricated demo data remains in live flows, backend security rules are verified, payment sandbox and reconciliation tests pass, offline conflict tests pass, Android and iOS release builds are signed, and real-device acceptance tests are documented.
