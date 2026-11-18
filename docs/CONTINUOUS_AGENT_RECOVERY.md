# Continuous Agent Recovery Loop

Status: mandatory for every AI coding session on this repository.

## Non-negotiable loop

Do not stop after reporting a failed check and do not ask the user to copy logs or commands when the connected GitHub tools can inspect them.

1. Identify the active branch, latest commit and newest Actions run. Fetch job/step summaries and the complete failed job log.
2. Classify the first causal failure: formatting, analyzer, unit/widget/integration test, Android build, artifact, device discovery, ADB, install/signature, launch/runtime, or visual QA.
3. Fetch the exact failing source, tests, workflow and relevant caller. Reproduce with the narrowest relevant test when a local execution tool exists; otherwise use CI as the authoritative execution environment.
4. Make the smallest source-level repair and add/update regression coverage. Never weaken, delete, skip or loosen a meaningful test just to turn CI green. A test expectation may be corrected only when it demonstrably contradicts the actual intended UI contract (for example, a RichText composed of separate spans).
5. Commit to the active feature branch. Do not touch main, merge PRs, force-push, reset other agents' work, or overwrite concurrent edits.
6. Observe the newly triggered workflow by polling run/job status and fetching logs after completion. Do not stop at the first failure. Repeat diagnosis and repair.
7. After formatter, analyzer, all tests and release APK build pass, fetch and verify artifact metadata. Device QA is a separate gate; inspect fresh device/ADB evidence and preserve installed app data.
8. Update AI_SYNC_STATE.json, append an evidence-based entry to AI_SHARED_COMMUNICATION_HUB.md, and keep ANTIGRAVITY_TASK.md aligned.

## Bounded retry policy

- Maximum 5 source-fix/CI cycles per autonomous session for the same unresolved failure family.
- Never retry an unchanged failing commit just to get a different result unless logs identify a transient infrastructure failure.
- For transient runner/network/tool setup failures, allow at most 2 bounded reruns with backoff, without changing app code.
- After the budget, stop safely with the complete diagnostics, exact blockers and next action. Do not loop indefinitely or hide failures.
- Do not claim persistent/second-by-second monitoring. GitHub Actions runs are finite; the agent must actively poll while the session is running. If the session ends, resume from the recorded run/commit on the next session.

## Completion gates

- Dart format: PASS
- Flutter analyze: PASS
- Full Flutter test suite: PASS
- Android release APK build: PASS
- Artifact name, run ID and SHA-256 recorded: PASS
- Physical-device install/launch/screenshot: report separately; never infer from cloud build success
- No uninstall, app-data wipe, signing bypass, secret disclosure or public ADB exposure.

## Required handoff fields

Record branch, commit, run ID and URL, failed job ID, failing step, first causal error, changed files, fix commit, test outcomes, artifact evidence, device QA evidence, retry count and remaining blockers.
