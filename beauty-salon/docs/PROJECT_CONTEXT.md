# Project Context

## Product
Working title: Beauty Salon App (final brand/name not yet approved). Native Flutter Android app for a salon business with Customer, Owner and Staff roles.

## Product areas
- Customer: discovery, service catalogue, pricing, booking, staff choice, home/online service, offers/coupons, membership, payment, rewards, history, reviews and support.
- Owner: dashboard, appointments, staff, services, campaigns, CRM, POS, expenses, inventory, profit/loss, memberships, reports, branches and permissions.
- Staff: assigned appointments, service workflow, shifts/attendance, leave, commission and feedback.
- Billing: itemized invoices, discounts, membership redemption, tax, advance/balance, split tender, refunds/cancellations and shareable receipts.
- Finance: gross sales less discounts/refunds = net sales; separately track COGS, product consumption, commissions, operating expenses, tax and cash flow.

## UX direction
Premium salon aesthetic: blush pink, ivory/cream, champagne gold, clean typography, generous spacing and accessible contrast. Mobile-first. Do not assume the working title is the final brand.

## Technical direction
Flutter/Dart Android-first. Keep presentation, domain and data layers separated. Use repository interfaces for data access; do not hardwire a backend or production keys before provider selection and security rules are reviewed.

## Verified implementation status
- [x] Dedicated branch created: `feature/beauty-salon-app`
- [ ] Flutter app shell
- [ ] Role-based navigation and auth
- [ ] Booking/service workflows
- [ ] Owner operations and POS
- [ ] Staff workspace
- [ ] Backend integration
- [ ] Physical-device QA
- [ ] Production signing/release

## Environment
GitHub Actions is the build/QA orchestrator. Tailscale and ADB are optional device-QA stages requiring repository secrets and an online paired Android device.
