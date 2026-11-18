# AI Operating Constitution

## Source of truth
The repository branch is the shared durable project memory. Current chat context is temporary; agents must reconstruct state from versioned project documents and code.

## Memory model
- `PROJECT_CONTEXT.md`: current architecture, implemented features, environment assumptions and verified status.
- `WORK_QUEUE.md`: pending/in-progress/blocked/done tasks, owners and acceptance criteria.
- `DECISION_LOG.md`: dated decisions, alternatives, rationale and impact.
- Git history: authoritative record of what changed, when and by which commit.
- CI artifacts/logs: evidence of build and QA outcomes. Never treat an unverified claim as memory.

Do not store personal secrets, customer PII or credentials in AI memory files. Store only minimal technical context.

## Agent execution
Each agent must state: task ID, goal, inputs read, files changed, tests run, results, risks and handoff. Parallel work is allowed only for independent files/interfaces. Orchestrator owns integration and final acceptance.

## Graphics generation
Create original assets from approved design tokens and documented prompts. Keep editable source where available; export PNG for raster UI, SVG for scalable icons, transparent PNG only where transparency is needed. Use predictable names, 1x/2x/3x density variants, trim excess transparent padding, optimize file size and record dimensions/licensing in `assets/ASSET_MANIFEST.md`. Never use unlicensed logos, celebrity likenesses or scraped brand artwork.

## Monitoring and recovery
On push/PR/manual dispatch: format -> analyze -> tests -> Android APK build -> artifact upload -> optional Tailscale/ADB device QA. Capture install result, app launch result, screenshot and logcat. On failure preserve logs/artifacts, identify the failing stage, open/update a work-queue item, fix reproducible code defects and rerun. Offline device or missing secrets is a clearly reported skipped/blocked QA stage, not a successful device test.

## Definition of done
Acceptance criteria pass; analyzer/tests pass; APK artifact exists; documentation/context updated; security review completed for auth/data/payment changes. Physical-device QA is separately reported and required before device-verified status.
