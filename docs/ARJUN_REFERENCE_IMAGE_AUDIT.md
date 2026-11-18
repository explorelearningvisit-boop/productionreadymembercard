# ARJUN reference-image audit (18 Nov 2026)

## Source recovery
The active conversation runtime contains 88 uploaded image files under /mnt/data. The ARJUN screen sequence is identifiable by Android status-bar capture times around 09:20–09:21 and filenames 1000320375–1000320406. This audit is based on direct inspection of those mounted image files and OCR of the screenshots, not on inferred filenames alone.

## Core ARJUN screens recovered
| Screenshot range | Screen / evidence | Implementation requirement |
|---|---|---|
| 1000320375 | Role selection; ARJUN brand; role cards | Persist selected role and provide role switching |
| 1000320376–0378 | Worker home; greeting; nearby job cards; quick actions | Real job feed, search/filter, worker skill matching |
| 1000320379 | Attendance screen; QR/GPS verification demo | Real job-bound check-in/out, consent, audit and offline queue |
| 1000320380 | Earnings; available and pending amounts; history | Ledger-derived balances, approved work only, payout states |
| 1000320381 | Worker profile; rating; KYC, help/SOS, privacy | Verified identity, consent, support and safety escalation |
| 1000320382–0383 | Provider dashboard; project/job KPIs; shortcuts | Server-derived metrics, role permissions, no fabricated counters |
| 1000320384 | Job listings and job cards | Published job records, status, location and applicant counts |
| 1000320385 | Worker/team rating summaries | Review provenance, verified-job-only reviews, moderation |
| 1000320386 | Project progress; assigned crew; quality check; milestone payment | Task evidence, acceptance criteria, approval, change/dispute history |
| 1000320406 | Job posting fields: category, details, duration, rate, workers | Validated job schema, attachment upload, draft/publish lifecycle |
| 1000320164–0171 | Earlier prototype / operations / form and Firebase upload notes | Retain useful workflow requirements; replace demo placeholders |

Several later screenshots (1000320387–0405) are repeated captures of the same worker profile, dashboard, listings, ratings and project-progress flows, likely representing navigation and UI checks rather than additional unique modules.

## Design language visible in references
- Role-aware visual treatment: worker experience uses green/emerald accents; provider screens use purple/blue accents.
- Light backgrounds, rounded cards, clear iconography, bottom navigation, large Hindi-first labels.
- Worker-facing information is compact and task-oriented.
- Provider dashboard prioritizes active work, team count, applications and monthly spend.
- The screens explicitly label some features as demo state; demo data must not be shown as real production data.

## Additional concept-board images
The mounted upload set also contains large composite concept boards with multiple phone screens and product flows. These should be treated as design exploration/reference, not as proof that all shown features already exist in source. Some other uploads in the same mount are unrelated generic assets or unrelated screenshots; they are excluded from the ARJUN source-of-truth set.

## Implementation mapping and acceptance criteria
1. **Role & identity**: role picker, language preference, phone OTP, account recovery, KYC states, account switching.
2. **Worker marketplace**: worker profile, skill tags, availability, location radius, search, filters, saved jobs, job detail, application lifecycle, cancellation and replacement.
3. **Job provider**: create/edit draft, attach images/docs, publish, pause/close, applicants, shortlist, accept, crew assignment, site contact.
4. **Attendance**: job-scoped QR/GPS with anti-replay, geofence tolerance, consent, check-in/out, correction request, offline queue and audit trail. GPS alone is not proof of completed work.
5. **Work execution**: tasks and measurable milestones, before/after evidence, acceptance criteria, quality reviewer, rework, change orders, delay reasons, safety checklist.
6. **Earnings & payments**: agreed rate/unit, verified quantity, approved payable, deductions only with transparent lawful basis, pending/approved/paid/disputed ledger, payout reconciliation and downloadable statement.
7. **Team & ratings**: verified engagement history, fair two-way reviews, dispute/moderation, report/block.
8. **Operations**: supplier quotes/orders/delivery, notifications, support/SOS escalation, admin moderation, fraud review, privacy controls and audit logs.
9. **Accessibility**: Hindi-first, English toggle, plan for Bhojpuri/Awadhi voice prompts, large tap targets, low bandwidth and offline-first drafts.

## Integrity rules
- Never invent worker counts, ratings, job counts, earnings or project progress.
- Never expose a worker's precise location publicly; use approximate distance until a job is accepted and exact sharing is consented/necessary.
- Do not equate attendance duration with productivity or wages for output-based work.
- Quality and safety approval must not be bypassed to meet a numeric target.
- Local device cache is not cloud sync. A screen must say when an action is local-only or queued.
- Sponsored listings must be labelled and must not silently outrank organic matching.

## Status
The existing Flutter app remains a prototype. Typed models and local cache were added in the rebuild branch, but server authentication, cloud persistence, real payments, KYC, notifications, security rules, operational tooling and release/device QA are not yet complete. This image audit is now recorded so the implementation can be traced to the uploaded source screens.
