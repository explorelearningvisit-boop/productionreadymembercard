# ARJUN — Workforce Marketplace (working product name)

Mobile-first, Hindi-first role-based marketplace prototype for Varanasi. Brand and trademark availability are not checked.

## Current implementation

This workspace is isolated under `apps/kaamsetu/`; it does not modify the existing application.

- Role switcher: Customer/Owner, Worker, Site Manager.
- Customer: browse service categories, post a job, set worker count, rate/unit, location and priority.
- Worker: browse nearby demo jobs, search, accept/join and see joined state.
- Site manager: view sample site visits and trigger demo inspection feedback.
- Demo wallet: local-only balance display and simulated add-funds action.
- Hindi by default, simple English toggle.
- Responsive mobile-first UI, large controls, semantic icons and status colors.
- Demo jobs and localStorage persistence for jobs, joined work and demo wallet.

## Run locally

Requires Node.js 20+.

```bash
cd apps/kaamsetu
npm install
npm run dev
```

Production bundle check:

```bash
npm run build
npm run preview
```

## Important: not production-ready for real customers yet

This is an interactive front-end prototype with local demo data. It is **not** connected to Firebase, a real identity/KYC service, maps/geocoding, notifications, a payment gateway, bank/UPI transaction verification, payroll, or a production admin backend. No real payment is initiated and no worker is actually dispatched.

Before a public launch, complete at minimum:

1. Firebase project setup, Auth, Firestore/Cloud Functions, Storage, App Check, Security Rules and role-based authorization.
2. Server-authoritative job/rate/dispatch state machine; idempotent acceptance and replacement logic.
3. Real city/skill/unit rate cards validated through field research; no worker bidding above the published base rate. Any urgency bonus must be explicit and customer-funded.
4. Manager onboarding, qualifications, background checks, contracts, visit evidence, audit trail and quality review. Do not collect a recruitment deposit as a condition of getting work.
5. Payment provider and legally reviewed marketplace settlement model. Separate customer funds, worker earnings and platform revenue in the ledger. Do not claim P2P transfers avoid tax. UPI screenshots/typed UTRs are not authoritative payment proof.
6. Labour-law review for worker classification, wage deductions, cancellation/penalty policy, safety, insurance, grievance and social-security obligations.
7. Hindi/English localization QA, accessibility testing with real workers, low-end Android and poor-network testing.
8. Automated tests, security review, monitoring, backups, privacy policy, terms, incident response and staged Varanasi pilot.

## Product principles

- The worker sees the full rate, unit, scope, site, timing and conditions before accepting.
- Market rate is centrally published by location, skill and unit; no auction/bidding race.
- Urgency premium is a separately disclosed incentive, not a hidden change to the base rate.
- Replacement after abandonment is an operations workflow with reason codes and human review, not automatic wage confiscation.
- Site managers record attendance, progress, material checks and evidence; disputes require both sides' responses.
- Use color plus icon plus text; never communicate status through color alone.
- The app must remain usable with large type, voice support and simple Hindi.

## Suggested next steps

1. Build backend contracts and Firestore schema.
2. Add authenticated customer/worker/manager accounts and role permissions.
3. Implement the job lifecycle and operations console.
4. Integrate a regulated payment provider in sandbox, then complete legal and tax review.
5. Run a supervised Varanasi pilot before general release.
