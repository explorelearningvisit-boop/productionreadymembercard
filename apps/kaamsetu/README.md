# KAAMSETU — On-Demand Labour & Skilled Work Marketplace

> Working product name only. Brand/trademark/domain availability has not been checked.

KAAMSETU is a separate product workspace inside this repository. It must remain isolated from the existing BAD GYM application and all existing product code.

## Product thesis

Connect households, contractors and small businesses with verified local workers and skilled tradespeople. Convert well-defined jobs into measurable, safely executable work packages; dispatch suitable workers; verify completion; and release payment transparently.

## User surfaces

1. **Worker app** — onboarding/KYC, skills and experience, service area, availability, nearby jobs, clear scope and rate before acceptance, check-in/out, task evidence, earnings ledger, payout status, ratings, support and disputes.
2. **Customer app** — post a job, choose skill/category, quantity/unit, location, deadline and budget; see estimate and worker plan; fund escrow/prepayment; track progress; review evidence; approve milestones; request extra work through a priced change order; raise a dispute.
3. **Operations/Admin web** — live job queue and map, worker verification, dispatch and reassignment, task templates, city/skill rate cards, escrow and payout ledger, disputes, safety incidents, fraud/risk review, service-area controls and analytics.

## Initial service taxonomy

- Construction helpers and material handling (sand, bricks, cement, debris)
- Masonry / rajmistri
- Electricians and wiring
- Plumbers
- Digging / excavation
- Concrete / casting support
- Grass cutting and farm labour
- Household and other locally validated services

## Non-negotiable task model

Every assignment must specify: measurable scope and unit, worksite, prerequisites/materials/tools, expected duration, rate, acceptance criteria, evidence required, safety/PPE requirements, and what is explicitly out of scope. A customer cannot silently add work onsite; extra scope requires an in-app change order accepted by the worker and repriced.

Do not assume every job can safely be split into 5–15 minute independent tasks. Task templates must be validated for sequencing, access, hazards, travel/setup time, quality dependencies and minimum viable work units. Dispatch must not create unsafe crowding or expose workers to uncontrolled sites.

## Payment and fairness model

- Customer funds the job (or an agreed milestone) before dispatch; funds are held in a compliant payment/escrow flow.
- Workers see the exact rate, milestone amount, completion criteria and deductions before accepting.
- Release each completed milestone promptly after objective verification; maintain a transparent transaction ledger and payout status.
- Do not apply automatic 40–60% forfeitures merely because a worker misses a timer. Use proportionate, disclosed rules, documented evidence, worker response/appeal, and human review for disputed or partially completed work.
- Include travel/setup, waiting, site access failure, customer cancellation, weather/material delays, injury and force-majeure handling in the policy.
- Validate payment-provider, labour, tax, worker-classification, insurance and local compliance requirements before real-money launch.

## MVP boundary

Launch in one tightly bounded Varanasi service area with a small set of validated job templates and manually supervised dispatch. Start with customer job posting, worker onboarding, rate cards, job acceptance, check-in/out, milestone evidence, escrow/payment ledger, ratings and dispute handling. Expand trades and automated task splitting only after field pilots establish reliable unit rates and completion times.

## Suggested implementation sequence

1. Product discovery and field validation; define task templates and local rate cards.
2. UX flows and design system for Worker, Customer and Admin.
3. Data model, authentication, role-based access and service-area model.
4. Job lifecycle, dispatch queue and milestone ledger.
5. Evidence, customer approval, change orders and disputes.
6. Payment-provider integration in test mode; compliance review before live payouts.
7. Pilot instrumentation, safety review and operational dashboards.

## Isolation rule

All KAAMSETU work stays under `apps/kaamsetu/` on branch `feature/kaamsetu-workforce-marketplace`. Do not modify, rename, delete, or merge existing BAD GYM files or branches as part of this project.
