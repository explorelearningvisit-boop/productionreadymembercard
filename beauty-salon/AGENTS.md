# Agent Operating Rules

## Mission
Ship a reliable, secure, maintainable Flutter Android salon-management product. Work only inside `beauty-salon/` unless changing the root workflow that invokes this project.

## Roles and ownership
- Product/Orchestrator: owns scope, priorities, acceptance criteria and cross-agent handoffs.
- UX/UI Agent: owns design tokens, navigation, accessibility, responsive layouts and visual QA.
- Flutter Engineer: owns Dart architecture, state, routing, forms, error/loading/empty states and tests.
- Backend/Data Agent: owns API contracts, auth/RBAC, persistence, migrations, sync and audit trails. Never invent production credentials.
- Graphics Agent: owns original icons/illustrations, asset manifests, PNG/SVG exports, transparent backgrounds, crop bounds and optimization. Do not copy third-party protected assets.
- QA/Release Agent: owns static analysis, unit/widget/integration tests, APK build, device install, screenshots, logcat and release evidence.
- Security Reviewer: checks authorization boundaries, secrets, PII, storage rules and payment handling.

## Required workflow
1. Read this file, `docs/AI_CONSTITUTION.md`, `docs/PROJECT_CONTEXT.md`, `docs/DECISION_LOG.md` and `docs/WORK_QUEUE.md` before making changes.
2. Claim one task in WORK_QUEUE; record owner, status, files and acceptance criteria.
3. Inspect existing code before editing. Do not overwrite unrelated files or silently change product decisions.
4. Keep changes small, typed, testable and scoped. Add/update tests with every behavior change.
5. Run formatter, analyzer and tests. CI must build an APK before claiming build success.
6. Update PROJECT_CONTEXT, DECISION_LOG and WORK_QUEUE in the same change.
7. Handoff with changed files, commands run, results, known risks and next task.
8. QA failures must be reproduced from logs; classify as code, environment, device/offline or secret/configuration failure. Fix code failures, retry transient infrastructure failures once, then report blocked dependencies.
9. Never claim physical-device install, screenshot capture, release signing or production readiness without matching CI evidence.

## Collaboration protocol
Agents do not edit the same file concurrently. Orchestrator assigns non-overlapping files, integrates changes, resolves conflicts and records decisions. All generated work must be attributable to a task/commit. No agent may delete another agent's work without an explicit decision-log entry.

## Security
Secrets only in GitHub Actions Secrets/Variables. No tokens, passwords, pairing codes, private keys, customer data or production exports in Git. Use least-privilege permissions and masked logs. Payments must use a compliant provider; never store raw card data.
