# Continuous Agent Observability & Recovery Contract

**Status:** REQUIRED operating contract; persistent watcher implementation is tracked separately.  
**Applies to:** ChatGPT, Antigravity, Claude, IDE agents, GitHub Actions, local BAD GYM agent, and future MCP/API workers.

## 1. Objective

Operate BAD GYM as a continuously observable engineering workflow, not as isolated prompt/response coding sessions. Every agent must inspect the live state available through its authorized connectors, detect changes and failures, diagnose from evidence, make the smallest safe repair, validate it, and leave a durable handoff.

GitHub `main` is the durable source of truth. This document defines required behaviour; it does **not** claim that a persistent watcher, second-by-second telemetry, or autonomous repair daemon already exists.

## 2. Startup and live observation

At the start of each work session, and before each consequential write:
1. Fetch the latest `main` ref and recent commits; inspect changed paths and authors.
2. Read `docs/AI_CONTEXT_BOOTSTRAP.md`, `AGENTS.md`, `AI_SYNC_STATE.json`, `CURRENT_DESIGN_SPEC.md`, `ANTIGRAVITY_TASK.md`, `docs/NETWORK_ARCHITECTURE.md`, `docs/DECISION_LOG.md`, this contract, `AI_SHARED_COMMUNICATION_HUB.md`, and relevant workflows.
3. Inspect current workflow runs, job/step conclusions, logs, artifacts, PRs/issues, and commit checks through available authorized connectors.
4. For a live local agent/runner, inspect health, active task/run ID, process status, current file operation, changed-file list, stdout/stderr, timestamps, and latest structured events **only through explicit supported MCP/API tools**.
5. Keep an observation ledger: UTC timestamp, source, run/task ID, observed event, files affected, severity, diagnosis, action, and verification evidence.

Do not claim "live", "every second", "currently editing", "watching", or "monitoring continuously" unless the underlying connected service actually returns fresh telemetry with timestamps. If a connector only returns snapshots, describe them as snapshots and report their timestamp.

## 3. Event loop for a persistent watcher (implementation requirement)

The local runner/agent or hosted workflow should implement an event-driven observer:
- Subscribe to process/task lifecycle events and filesystem changes; use GitHub Actions run/job webhooks or polling as a fallback.
- Capture structured events for task_started, command_started, command_finished, file_created, file_modified, file_deleted, test_failed, build_failed, device_online/offline, adb_connected/disconnected, install_result, launch_result, screenshot_created, task_completed.
- Include run ID, correlation ID, UTC timestamp, command/tool name, exit code, duration, file path, before/after SHA-256 where safe, and redacted output excerpt.
- Never capture secret values, environment dumps, access tokens, auth keys, pairing codes, private keys, passwords, or personal data. Redact before persistence.
- Debounce file events and group rapid writes; don't report temporary build/cache churn as meaningful source changes.
- Expose read-only status/log/file-diff tools to connected agents. Mutations must be separate, least-privilege, approval-gated operations with expected hashes and backups.
- Persist event cursors/checkpoints so a restarted watcher resumes without losing or duplicating work.
- Use bounded retries with exponential backoff and jitter, a maximum attempt count, cooldown, and a dead-letter/failure state. Never create overlapping builds or installs for the same device/commit.
- Trigger on GitHub push/workflow completion and device online transitions where supported. A powered-off phone cannot be contacted; queue the install and resume only after a verified online + authorized ADB state.
- Avoid infinite loops: a failed fix must not auto-commit/retry indefinitely. After the configured retry budget, stop, preserve diagnostics, and request human review.

## 4. Failure diagnosis and repair policy

For every failure:
1. Fetch the complete relevant log and identify the first causal error, not merely the final failed step.
2. Classify: source/test, dependency/toolchain, CI configuration, secrets/authentication, network/Tailscale, ADB transport/authorization, Android install/signature/MIUI restriction, launch/runtime, or screenshot/artifact.
3. Reproduce with the narrowest relevant test/command where possible.
4. Inspect the exact source and surrounding callers/tests before editing.
5. Make the smallest coherent fix; add/update regression coverage when appropriate.
6. Run formatter, static analysis, targeted tests, full tests, build, and device QA as applicable.
7. Re-read the latest branch before committing to avoid overwriting another agent. Never force-push, reset other work, or commit unreviewed generated noise.
8. If a fix requires destructive action, secret rotation, permission change, or device data loss, stop and obtain explicit user approval.

## 5. Android/Tailscale safety and evidence

- Tailscale Online is not proof of ADB reachability or authorization. Verify peer, TCP endpoint, ADB handshake and `adb get-state` independently.
- Wireless Debugging port is dynamic; pairing port and connect port differ. Never hardcode a transient port.
- Support USB, Wi-Fi, cellular, hotspot, USB tethering, Ethernet and changing uplinks. Do not assume same LAN, DHCP address, or mDNS.
- Never expose ADB to the public internet or add router port-forwarding.
- Never automatically uninstall the app or wipe user data to fix `INSTALL_FAILED_UPDATE_INCOMPATIBLE`. Preserve the installed app and report signature mismatch.
- Report build, install, launch, smoke test, screenshot and log artifact as separate outcomes. No physical-device claim without fresh device evidence.

## 6. Required durable write-back

After each meaningful task, update:
- `AI_SYNC_STATE.json`: current status, active run/task, last observation time, changed files, diagnosis, fix commit, test/build/QA results, retry count, blockers and next action.
- `AI_SHARED_COMMUNICATION_HUB.md`: timestamped handoff with evidence links and concise summary.
- `ANTIGRAVITY_TASK.md`: current actionable task and exact acceptance criteria when work is handed to another agent.
- `docs/DECISION_LOG.md`: accepted changes to architecture, security, product behaviour or workflow.

Never store secrets or secret-derived values in these files. Use commit/run/job/artifact URLs and redacted summaries.

## 7. Agent handoff and coordination

Before editing, check recent commits and the shared handoff for other agents' active work. If another agent is running:
- Observe its run and file changes read-only where supported.
- Do not edit the same files concurrently unless changes are coordinated.
- Record ownership/lock metadata for high-risk shared operations (build/install/device control).
- Reconcile by fetching latest main and reviewing diffs; never blindly overwrite.

Every fresh AI tool/agent must read this contract via `AGENTS.md` and the bootstrap before taking action.

## 8. Capability honesty and current limitation

A chat model cannot keep executing after the conversation ends unless a separately deployed persistent agent/automation is running. A GitHub Actions runner exists only for the lifetime of its job. Scheduled automation is not second-by-second filesystem observation. MCP connector availability does not itself grant access to an unrelated local Antigravity process, terminal, filesystem, or Tailscale control plane.

Before claiming access, enumerate the actual connected tools and call them. If no Antigravity task/log/file-watch connector is exposed, say so; do not simulate telemetry or invent file activity. The intended implementation is a local persistent observer/agent connected through a secure, authenticated MCP transport plus GitHub Actions event ingestion. The existing `tools/badgym_local_agent/` is currently a diagnostic/control agent with opt-in constrained writes; verify its present code before assuming it already implements this event stream.

## 9. Definition of done for the watcher implementation

- [ ] Authenticated persistent observer service with start/stop/health and restart recovery.
- [ ] Live task/process state, current command, timestamps, stdout/stderr tail and exit status.
- [ ] Debounced filesystem watcher with changed-file list and safe diffs/hashes.
- [ ] GitHub Actions run/job/step/log/artifact event ingestion.
- [ ] Redaction and allowlisted read-only telemetry by default.
- [ ] Explicit approval + expected hash + backup for file mutations.
- [ ] Bounded retry state machine and per-device/per-commit concurrency lock.
- [ ] Device online recovery and deferred APK install without uninstall/data wipe.
- [ ] Persistent event journal and AI_SYNC_STATE/handoff updates.
- [ ] Unit/integration tests for restart, duplicate events, redaction, retries, overlapping runs, offline device and signature mismatch.
- [ ] End-to-end evidence from a real Antigravity/local agent session and a real GitHub Actions run.
