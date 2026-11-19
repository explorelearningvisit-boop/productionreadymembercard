# ARJUN — Unified Product & UX Blueprint

Status: product specification / implementation map. A listed screen or workflow is not considered live until its backend, permissions, persistence and tests are connected.

## One coherent visual system

- Product: ARJUN — “काम • हुनर • भरोसा”; Rooted in Kashi. Built for the World.
- Visual direction: modern, bright, image-led marketplace; warm off-white surfaces, deep forest-green primary actions, saffron/orange urgency accents, violet discovery/promotional accents, restrained blue information states.
- Avoid dense text, tiny controls, crowded dashboards and decorative gradients that reduce contrast.
- Use large illustrated category tiles, photography for real work/materials, clear status icons, short Hindi labels and optional audio guidance.
- Common primitives: 20–28dp rounded cards, 48–56dp minimum touch targets, clear hierarchy, bottom navigation, skeleton/loading/empty/error/offline states, reduced-motion support.
- Responsive baseline: compact Android first (360dp width), scrollable content, no fixed-height dashboard assumptions. Validate larger text and TalkBack.
- Language: Hindi-first with English toggle. Icons supplement labels; they do not replace accessible names.

## Consolidated screen inventory

### Shared entry and account
1. Splash / brand introduction.
2. Welcome / how ARJUN works (visual 3-step).
3. Role selection: customer, worker/karigar, field manager/inspector, supplier.
4. Login / phone entry / OTP verification.
5. Debug-only one-tap demo login (pre-filled synthetic tester identity).
6. Profile basics, language, location permission and notification permission.
7. Role switcher restricted to roles granted to the signed-in account.

### Customer / owner
1. Customer home with one dominant “काम पोस्ट करें” action, service categories and nearby work.
2. Visual service/category browser (construction, masonry, plumbing, electrical, painting, carpentry, appliance repair, driver, loading, delivery, agriculture, manufacturing and other local services).
3. Job composer step 1: work type and visual examples.
4. Job composer step 2: description by text or voice, photos/video, optional reference.
5. Job composer step 3: location/map pin, date/time, duration and urgency.
6. Team size, rate/budget, per-hour/day/job/unit and transparent estimate.
7. Review and publish confirmation.
8. Matching results with worker cards, skills, distance, availability, verified status and ratings.
9. Worker profile, work samples, quote and terms.
10. Compare quotes and select worker/team.
11. Booking confirmation and cancellation terms.
12. Live job status, worker ETA and safe contact.
13. Milestone timeline, progress photos/video and customer approval.
14. Payment checkout, receipt/invoice and refund status (provider integration required).
15. Completion rating, review, rehire and dispute/help.

### Worker / karigar
1. Worker home: availability switch, nearby work, earnings snapshot and next action.
2. Skill selection with pictorial categories and experience.
3. Work area, travel radius and preferred schedule.
4. KYC/profile verification status.
5. Nearby job feed with filters for distance, category, rate and urgency.
6. Job detail, customer requirements, site photos and transparent terms.
7. Quote / accept / decline with reason.
8. Confirmed job and navigation.
9. Site arrival check-in using server-verified QR/OTP and timestamp.
10. Work start, pause/wait reason and work-progress update.
11. Evidence capture: camera/gallery/video/voice note.
12. Milestone completion and customer approval.
13. Earnings ledger, pending/cleared amounts and payout history.
14. Payout onboarding and settlement status.
15. Reviews, safety, support and dispute.

### Field manager / inspector
1. Manager home: assigned sites, pending inspections and alerts.
2. Assigned site list/map and route.
3. Site/job detail, scope and team.
4. Worker identity/attendance verification.
5. Material/part verification with photos, quantity and source.
6. Quality checklist and safety checklist.
7. Site progress capture and issue reporting.
8. Customer walkthrough / milestone recommendation.
9. Inspection report and evidence timeline.
10. Escalations, disputes and audit history.

### Supplier / building-material marketplace
1. Supplier onboarding, business profile and KYC.
2. Supplier dashboard with orders, stock alerts and campaign performance.
3. Storefront with location, delivery radius and opening hours.
4. Product categories: cement, steel/rebar, bricks, sand, aggregate, tiles, pipes, electrical, paint, tools and other building materials.
5. Product detail with brand, grade/specification, unit, stock, price and delivery estimate.
6. Add/edit product, images and inventory.
7. Quote request / bulk order and negotiated price.
8. Cart, delivery address, freight and taxes shown before confirmation.
9. Order processing and dispatch.
10. Delivery tracking and proof of delivery.
11. Invoice, returns, damaged/short shipment and supplier support.

### Advertising and monetization
1. Sponsored supplier storefront card in discovery.
2. Sponsored material banner in relevant category pages.
3. Promoted product tile in search results, clearly labelled “विज्ञापन”.
4. Local supplier offer card based on service area.
5. Sponsored job/training promotion where relevant and clearly labelled.
6. Supplier campaign manager: audience area, budget, duration, creative preview, impressions, clicks and leads.
7. Ad reporting and moderation.
Rules: ads must never imitate system actions, hide the primary task CTA, interrupt attendance/safety/payment confirmation, or use deceptive countdowns. Frequency caps and user reporting are required. Ad targeting must avoid sensitive personal data.

### Shared services and operations
1. In-app chat, voice note, masked call / contact policy.
2. Notification inbox and notification preferences.
3. Help centre, safety emergency flow and support ticket.
4. Dispute intake, evidence upload, status and appeal.
5. Cancellation, reschedule, waiting-time and force-majeure policy.
6. Offline drafts, upload queue, retry and sync conflict state.
7. Privacy, consent, data export/deletion, terms and grievance contact.
8. Admin dashboard, user/role management, KYC review, job moderation, ad moderation, rate cards, dispute desk, refunds, payout reconciliation, fraud flags, audit logs and analytics.

## Critical domain rules

- One account may hold multiple roles, but server-side permissions decide which roles can be activated.
- A job has an explicit lifecycle: draft → published → matching → quoted → assigned → accepted → en route → checked in → in progress → milestone review → completed → payment settled; cancellation/dispute paths are separate states.
- Every state transition is authorized, timestamped, idempotent and auditable on the server.
- QR/OTP attendance is not a UI toggle: it needs a short-lived server challenge, verified location policy, trusted timestamp and replay protection.
- No fake wallet balances. Customer payments and worker payouts require a compliant payment provider, signed webhooks, reconciliation and reviewed marketplace settlement terms.
- Supplier stock and price are time-stamped; quote/checkout must revalidate stock and disclose delivery/tax/fees.
- Disputes require evidence, human review and an appeal route. Avoid disproportionate automatic forfeiture for minor timing deviations.
- Media must have size/type validation, resumable uploads, access-controlled storage, retention rules and deletion workflows.
- Location, identity and contact details are private by default; reveal only what a role needs at a justified workflow stage.

## Authentication and testing

- Demo identity is synthetic: tester@arjun.demo / +91 90000 00000. It is not a real verified account.
- One-tap demo login is allowed only when Flutter is in debug mode. Release builds cannot activate it through a Dart define.
- Production authentication must use verified phone/email identity and server-issued sessions. Do not ship demo credentials or bypass code as a production sign-in method.
- Keep demo data separate from production data and mark all demo transactions as non-financial.

## Definition of done

A screen is complete only when: responsive UI exists; loading/empty/error/offline states exist; accessibility labels and touch targets are checked; navigation is wired; role authorization is enforced server-side; data persists; analytics/events are privacy-reviewed; unit/widget/integration tests pass; and the feature is verified on a real Android device. Payment, KYC, messaging, maps, push, ads and uploads must not be called live before their external services and security controls are validated.


## 2026-11-19 — Approved KaamVerse visual implementation direction
The user approved the KaamVerse three-role UI concept. The current implementation target is the `rebuild/kaamverse-platform` branch and this Flutter app directory.
- Customer types: Individual and Business/Contractor.
- Hiring units: Hourly, Daily and Project/Contract quote.
- Primary journeys: Customer discovery/booking/tracking; Worker onboarding/job requests/work/earnings; Admin operations/KYC review/bookings/payments/commission/support.
- Blend the approved reference's soft white surfaces, rounded cards, purple discovery/promotional elements and green primary actions with existing ARJUN Hindi-first marketplace functionality. Prefer existing components when they are clearer and accessible.
- Use only individual transparent PNG assets for raster illustrations; validate PNG alpha before committing. Do not embed screen collages as app backgrounds. Use native Flutter for text, charts, maps placeholders, buttons, icons and status.
- Work one screen at a time. Current screen: Customer Home. Next screens: service discovery, worker list, worker profile, booking composer (hour/day/project), booking confirmation, booking detail/tracking, customer bookings, chat, payment preview and profile.
- This remains a non-production UX prototype until authentication, server persistence, KYC, location, messaging and payment integrations are independently implemented and verified.
