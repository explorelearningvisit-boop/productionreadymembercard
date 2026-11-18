# BAD GYM — Universal AI Engineering Constitution

**Status:** Mandatory operating contract  
**Applies to:** ChatGPT, Gemini, Google Antigravity, Cursor, Claude, GitHub Copilot, IDE agents, local agents, automation workers, and human contributors.  
**Repository:** https://github.com/explorelearningvisit-boop/productionreadymembercard  
**Current isolated workstream:** `chatgpt/member-intelligence-mobile-rebuild`  
**Base branch:** `main` (read-only for this workstream unless the user explicitly changes the instruction)  
**Last authored:** 2026-11-18

> This repository is the durable shared memory for the project. A new chat or a different AI must reconstruct context from these files and the live repository, not ask the user to repeat decisions that are already recorded.

---

## 1. The first rule: understand before changing anything

Do not start coding from a one-line instruction, voice transcript, screenshot, or assumption.

For every task:

1. Interpret the user's actual outcome, not only the literal words.
2. Resolve the context: which app, screen, feature, branch, user-provided reference, existing behaviour, and acceptance criteria are involved?
3. Inspect the repository and current implementation. Do not assume a feature is missing or implemented based on a prior chat.
4. Compare the requested outcome with the current code, assets, tests, workflow, and device evidence.
5. Identify implicit requirements that are necessary to achieve the stated outcome (responsive behaviour, accessibility, data integrity, security, error states, loading states, offline behaviour, tests, etc.).
6. Separate facts, user decisions, engineering recommendations, assumptions, and unknowns.
7. Write a short internal implementation plan before making edits. If the user asks for a plan/prompt first, show that plan and wait for approval. Otherwise, make routine engineering decisions autonomously within this constitution.
8. Ask one focused question only when an unknown blocks safe or correct progress. Do not ask the user to repeat information already in this repository.

A rough voice command is a problem statement, not a complete technical specification. Improve it into a complete implementation brief while preserving the user's intent. Add supporting engineering details when they are necessary; do not add unrelated features or change the product direction.

## 2. Mandatory startup protocol for every new chat / agent

Before any code edit, build, device action, or claim about project status:

1. Identify the exact repository and fetch its latest remote state.
2. Identify the active branch from the user's current task and remote refs. **Never assume `main` is the working branch.**
3. Read, in this order:
   - `docs/AI_AGENT_OPERATING_CONSTITUTION.md` (this document)
   - `AGENTS.md`
   - `docs/AI_CONTEXT_BOOTSTRAP.md`
   - `AI_SYNC_STATE.json`
   - `CURRENT_DESIGN_SPEC.md`
   - `docs/ANTIGRAVITY_MEMBER_INTELLIGENCE_REBUILD.md`
   - `ANTIGRAVITY_TASK.md`
   - `docs/DECISION_LOG.md`
   - the latest relevant entries in `AI_SHARED_COMMUNICATION_HUB.md`
   - `docs/CONTINUOUS_AGENT_OBSERVABILITY.md`
   - `docs/CONTINUOUS_AGENT_RECOVERY.md`
   - `.github/workflows/android-cloud-device.yml` and any workflow relevant to the task.
4. Read any additional feature-specific specification linked by those documents.
5. Inspect recent commits, open PRs, latest Actions runs, jobs, logs and artifacts for the active branch.
6. Inspect the actual source files and assets involved. Read surrounding code and tests, not isolated snippets only.
7. Check for concurrent agent changes before writing. Re-fetch the branch immediately before a consequential write.

If a required file is missing, report that fact and use the closest current source; never pretend it was read. Do not ask the user to restate repository context.

## 3. Source-of-truth and conflict-resolution order

Use this order when documents or agents disagree:

1. The user's latest explicit instruction in the current task.
2. The latest accepted, dated user decision in `docs/DECISION_LOG.md`.
3. The latest approved visual reference and specification in `CURRENT_DESIGN_SPEC.md` and the feature-specific design handoff.
4. The actual current source code, tests, asset usage, and workflow configuration for implementation facts.
5. `AI_SYNC_STATE.json` for the latest recorded status (verify against live GitHub before relying on it).
6. The newest timestamped handoff in `AI_SHARED_COMMUNICATION_HUB.md`.
7. Older documentation, screenshots, stale prompts, prior assistant claims, and chat memory.

A screenshot of the app currently running is **output evidence**, not automatically the desired design reference. Do not confuse an implementation screenshot with the user's approved target image. The latest target reference is the one identified by the user and recorded in the current design specification.

When sources conflict:
- Do not silently combine incompatible designs.
- Identify which source is newer and whether it is an approved user decision.
- Preserve historical records; append a correction/supersession note rather than erasing history.
- Update all active documents that would otherwise mislead the next agent.

## 4. Project identity and boundaries

- Product: BAD GYM Member Intelligence.
- Repository: `explorelearningvisit-boop/productionreadymembercard`.
- Current independent implementation branch: `chatgpt/member-intelligence-mobile-rebuild`.
- Base branch: `main`; do not push this workstream to `main`, merge it, or change its protection without explicit user direction.
- Framework currently used by this workstream: Flutter / Dart. Confirm the current `pubspec.yaml`, Android Gradle configuration and entrypoint before changing architecture.
- Android package historically recorded as `com.badgym.bad_gym`; verify the actual `applicationId` before installing.
- The product direction includes Android and iOS, but the currently available cloud workflow may only verify Android. Never claim iOS build/device QA unless a macOS/Xcode signing and test run actually proves it.
- Do not mix this app with `badnewgym`, another app, another repository, or another APK output. Keep package IDs, artifact names, paths and release channels distinct.
- Do not copy unverified source from abandoned or broken branches.

## 5. Current visual and product requirements

The latest approved Member Intelligence reference and its full hierarchy are documented in `CURRENT_DESIGN_SPEC.md` and `docs/ANTIGRAVITY_MEMBER_INTELLIGENCE_REBUILD.md`. Read both before visual work.

Current reference recorded on 2026-11-17:
- Ice-blue / pale cyan water-glass visual language, pearl-white translucent cards, cool blue borders/highlights and soft blue shadows.
- Navy typography; vivid blue primary controls.
- Semantic green = present/active/checked-in; amber = late/warning/gold plan; red = absent/payment due; neutral grey = holiday/Sunday/off.
- Compact BAD GYM header with logo, search, notification badge and QR action.
- One integrated member pass with portrait, identity, ID, age/gender, checked-in time, Active/Gold Plan, real QR, payment due, expiry/days-left and membership progress.
- Compact sponsored Amazon festival banner.
- Four equal-width KPI tiles: Attendance, Workout, Payment, Body.
- Bounded intelligence workspace with narrow contextual rail; Attendance > Calendar is the default, with month selector, weekday/date grid, status semantics, attendance donut/counts/legend and relevant streak/insight context as defined by the current spec.
- Compact AI Insights footer only if it fits without breaking the fixed viewport.

**Important screenshot distinction:** the image the user shared on 2026-11-18 showing the app running on the phone is a screenshot of the current implementation to audit. It is not, by itself, a replacement for the approved 2026-11-17 ice-blue reference. Compare output against the approved target; do not relabel the burgundy/red output as the target design.

Responsive rules:
- Mobile-first. Design and test at 360dp width.
- The compact stress viewport is 360 × 600dp. Test it explicitly.
- Also verify on the actual target phone when available; use logical constraints, MediaQuery and LayoutBuilder, not hard-coded screenshot pixels.
- No horizontal overflow, RenderFlex overflow, clipped content, illegible text, tiny tap targets, or unintentional vertical scrolling on the primary dashboard.
- Compress spacing and decorative chrome before making important text unreadable.
- Keep the approved information hierarchy and relative visual weight. Do not invent extra modules, replace the visual language, or remove useful content without a user decision.
- Tabs and rail controls should replace bounded workspace content in place rather than stack more widgets vertically.
- Sunday/off should be disabled/neutral; present green; absent red; late amber; holiday neutral grey unless the latest approved spec explicitly changes this.
- Use real, data-driven Flutter widgets for text, metrics, charts, calendars, progress and interactive controls. Use raster assets only for isolated illustrations/decorative artwork.
- Do not use a static screenshot as the whole UI or bake dynamic labels/charts into images.

## 6. Asset and visual-quality rules

Before creating or replacing graphics:
1. Inventory assets and inspect actual dimensions, transparency/alpha, crop, file size, visual quality, licensing/source and current references in code.
2. Reuse a suitable existing approved asset rather than drawing a placeholder icon or emoji.
3. Do not assume an asset is used merely because it exists in a folder.
4. Do not use sprite sheets, contact sheets, debug exports, or intermediate extraction files as final individual UI assets.
5. Preserve image aspect ratio. Avoid stretching/cropping faces, logos or text.
6. Record new asset source, licence and purpose in `assets/README.md` where appropriate.
7. Compare the rendered screen against the approved screenshot at the same logical viewport and inspect spacing, hierarchy, colors, typography, edge treatments and image scale—not just whether widgets exist.

A gradient with the right colors is not a substitute for the reference's visual language. A row of icons and text is not equivalent to a designed graphic banner. Do not declare visual parity from source inspection alone.

## 7. Engineering and implementation standards

- Read the actual source architecture before selecting patterns or dependencies. Do not add Riverpod, Bloc, GoRouter, a chart package, database, or other dependency merely because it is common; justify it against the current codebase and task.
- Keep widgets focused, composable, testable and responsive.
- Keep business logic and data models separate from presentation where the existing architecture supports it.
- Avoid magic numbers scattered across widgets. Use shared design tokens and named layout constants where useful.
- Do not hardcode member identities, attendance results, payment values, dates or analytics in production UI. Use fixtures only in tests/demo states and label them clearly.
- Handle loading, empty, error, offline and permission-denied states where the feature depends on external data/device services.
- Preserve existing working functionality, data, navigation, package identity and integrations unless the user explicitly asks to change them.
- Do not add decorative interactions that do nothing. Every button, tab, rail item, search, QR action and update control must have a real, tested behaviour or be clearly disabled.
- Accessibility: semantic labels, adequate contrast, sensible text scaling, keyboard/focus support where relevant, and practical tap targets.
- Keep dependencies minimal and update lockfiles consistently.

## 8. Required workflow for every user request

### Phase A — Understand and plan
- Restate the outcome in engineering terms.
- Identify target files, screens, dependencies, data paths and side effects.
- Compare current state with target reference and acceptance criteria.
- Identify risks and tests.
- Decide whether the request is a design-only, implementation, CI, device, release or documentation task.

### Phase B — Inspect
- Fetch latest active branch and recent commit history.
- Inspect current source, tests, assets, workflow and run artifacts.
- Inspect relevant current device state if physical QA is requested.
- Never edit from stale chat snippets when current source can be fetched.

### Phase C — Implement
- Make the smallest coherent set of changes that fully satisfies the task.
- Do not overwrite unrelated agent changes.
- Do not change the visual source of truth without explicit user direction.
- Add/update regression tests for defects and new behaviour.
- Keep changes on the agreed feature branch.

### Phase D — Validate
Run the applicable commands (the CI workflow is authoritative when no local execution environment exists):
```bash
flutter pub get
dart format --output=none lib test
flutter analyze --no-fatal-infos
flutter test --reporter expanded
flutter build apk --release
```
Run targeted tests and the full suite. Do not suppress analyzer errors, weaken assertions, skip failing tests, or change expected values simply to make CI green.

### Phase E — Inspect the result
- Inspect actual workflow logs and APK artifact metadata.
- For visual work, compare a fresh rendered screenshot against the approved reference.
- For device work, separately verify peer/network, ADB transport, package/signature compatibility, install, launch, runtime, screenshot and logcat.
- Fix the actual root cause, not just the final symptom in the log.

### Phase F — Persist context and hand off
Update the relevant files:
- `AI_SYNC_STATE.json`: current branch/commit, task status, run IDs, changed files, test/build/device evidence, blockers and next action.
- `AI_SHARED_COMMUNICATION_HUB.md`: append a timestamped, evidence-based entry. Never erase previous entries.
- `ANTIGRAVITY_TASK.md`: update the current actionable handoff and acceptance criteria.
- `docs/DECISION_LOG.md`: append accepted decisions that affect product, design, architecture, security or workflow.
- Relevant design/bootstrap docs: update when the approved source of truth changes.
Commit and push only to the agreed branch.

## 9. CI failure diagnosis and bounded recovery

CI green is a gate, not a formality. For each failure:
1. Fetch the complete failed job log and locate the first causal error.
2. Identify the failing file, line, test, step and actual constraint.
3. Classify the failure: format, analyzer, widget/unit/integration test, Gradle/toolchain, dependency, artifact, Tailscale, ADB, install/signature, launch/runtime or screenshot.
4. Inspect the relevant source and caller/test/workflow.
5. Implement the smallest fix and add regression coverage.
6. Commit to the active branch and monitor the new run until completion while the session remains active.
7. Repeat within the retry budget in `docs/CONTINUOUS_AGENT_RECOVERY.md`. Stop safely at the budget with exact evidence and blocker; never loop indefinitely.

Do not ask the user to relay routine GitHub logs when authorized GitHub tools can retrieve them. Do not claim continuous/second-by-second monitoring if only finite workflow snapshots are available.

## 10. Android, Tailscale and device safety

Primary historically used device: Xiaomi 11i 5G, model 21091116I, Android 13 / MIUI. Verify current connectivity and serial/IP at runtime.

- Prefer authorized USB ADB when available; otherwise use verified Tailscale + current Android Wireless Debugging endpoint.
- Laptop and phone may be on different Wi-Fi, cellular, hotspot, USB tethering or Ethernet networks. Never assume same LAN, stable DHCP, mDNS, fixed Tailscale IP or fixed ADB port.
- Tailscale Online does not prove ADB TCP reachability or authorization. Verify TCP endpoint, ADB handshake and `adb get-state` separately.
- Pairing port and Wireless Debugging connect port are different. The connect port is dynamic. Never assume 5555 or reuse an old port.
- Android may disable Wireless Debugging after phone power-off. Do not promise connection while the phone is off or debugging is unavailable.
- Never expose ADB publicly or add router port forwarding.
- Never automatically uninstall the app, clear app data, bypass signing or defeat Android/MIUI confirmation to fix installation.
- Check application ID, version code and signing certificate before in-place install. On signature mismatch, stop and report; preserve the existing installation/data.
- Android PackageInstaller may require the user to approve the system confirmation. Do not promise silent installation.

## 11. Security and privacy

Never commit, print, quote or put into a handoff:
- GitHub tokens, OAuth secrets, Tailscale auth keys, ADB private keys, keystores, passwords, pairing codes, recovery codes or secret values.
- Personal data from device logs or screenshots that is not needed for the task.

Use encrypted GitHub Actions secrets or an approved secret manager. A previously exposed credential/key must be rotated or revoked; do not reuse it. Redact logs before persistence. Follow least privilege. Destructive operations, secret rotation, account changes, signing-key changes, data migrations and irreversible device actions require explicit user approval.

## 12. Cross-agent collaboration

- All agents work from the same GitHub repository but may have different local checkouts, tools, permissions and live context.
- Before writing, inspect recent commits and latest handoff. Re-fetch before each consequential write.
- Avoid simultaneous edits to the same files. If another agent has newer work, reconcile diffs; never blindly overwrite, reset or force-push.
- A local Antigravity session is not automatically visible to ChatGPT. GitHub commits, workflow logs, artifacts and documented handoffs are the shared bridge.
- A new AI must not assume it can access the user's laptop, local filesystem, Android phone, Tailscale control plane or another AI's session. Discover and use only actually connected tools.
- If a tool is unavailable, state the boundary and use the best authorized alternative. Never fabricate tool output or telemetry.

## 13. Completion report — required evidence

Every completion report must distinguish:

- Repository, branch and exact commit SHA.
- Files changed and what changed.
- Formatting result.
- Static analysis result.
- Test result and count.
- Android build result and exact APK artifact/run.
- Device network/Tailscale status.
- ADB status.
- Install result.
- Launch/runtime result.
- Fresh screenshot/logcat result and location.
- Visual comparison result against the approved reference.
- Remaining blockers and one next action.

Use these labels precisely: `PASS`, `FAIL`, `PENDING`, `NOT RUN`, `NOT AVAILABLE`. A successful APK build does not prove installation. Installation does not prove launch. Launch does not prove visual correctness. A source-code review does not prove pixel-perfect output. Never call a build production-ready or pixel-perfect without the corresponding fresh evidence.

## 14. Current branch handoff — 2026-11-18

The active branch at the time this constitution was added is `chatgpt/member-intelligence-mobile-rebuild`. The latest UI changes in this session were:
- `790cfb5`: responsive layout sizing adjustment.
- `17c0ec7`: advertisement artwork adjustment.
- `c11e709`: calendar readability regression test.

These changes triggered GitHub Actions runs #283 and #284. At the time of writing, their completion/artifact state must be re-fetched; do not assume success.

**Review warning:** the previous implementation patch made layout and asset changes quickly, but it has not yet been visually accepted against the approved ice-blue reference. In particular, the current branch's burgundy/red appearance and protein-burger promotional treatment conflict with the 2026-11-17 approved ice-blue screen specification. Treat those as implementation gaps to audit and correct—not as new approved design decisions. Do not preserve a wrong visual choice merely because it exists in the latest commit.

The next agent must:
1. Re-read the approved reference and the current phone screenshot as separate target/output artifacts.
2. Inspect the latest branch code and runs #283/#284.
3. Verify the breakpoint and compact viewport behaviour with tests.
4. Compare every section's hierarchy, proportions, colors, text and artwork with the approved reference.
5. Correct visual mismatches without inventing features.
6. Rebuild and obtain fresh phone screenshot evidence before claiming completion.

---

## 15. Copy-ready prompt for a fresh AI chat

You are continuing the BAD GYM Member Intelligence project. Do not ask the user to repeat prior context.

Repository: https://github.com/explorelearningvisit-boop/productionreadymembercard  
Work branch: `chatgpt/member-intelligence-mobile-rebuild`  
Base branch: `main` (do not modify/merge main unless explicitly instructed).

First fetch the latest remote branch and read, in order:
1. `docs/AI_AGENT_OPERATING_CONSTITUTION.md`
2. `AGENTS.md`
3. `docs/AI_CONTEXT_BOOTSTRAP.md`
4. `AI_SYNC_STATE.json`
5. `CURRENT_DESIGN_SPEC.md`
6. `docs/ANTIGRAVITY_MEMBER_INTELLIGENCE_REBUILD.md`
7. `ANTIGRAVITY_TASK.md`
8. `docs/DECISION_LOG.md`
9. the latest entries of `AI_SHARED_COMMUNICATION_HUB.md`
10. `docs/CONTINUOUS_AGENT_OBSERVABILITY.md`, `docs/CONTINUOUS_AGENT_RECOVERY.md`, and the relevant GitHub workflow.

Inspect latest commits, PRs, CI runs, logs and artifacts, then inspect actual source/assets/tests. The approved visual reference is the 2026-11-17 ice-blue/cyan glass screenshot described in CURRENT_DESIGN_SPEC.md. The user's 2026-11-18 phone screenshot is the current app output to compare, not a replacement target. Understand the full task, produce a complete implementation plan, and then execute autonomously within the documented safety limits. Keep work on the feature branch, preserve other agents' work and user data, test 360dp × 600dp, diagnose CI failures from full logs, and write back state + append-only handoff records. Never claim a build, install, screenshot or pixel match without fresh evidence.

Current task: [insert the user's new task here].
