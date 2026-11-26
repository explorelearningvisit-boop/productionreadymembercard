# BAD GYM AI Agent Handoff Protocol

This repository uses GitHub as the shared handoff channel between ChatGPT-assisted work and external coding agents.

## Project identity
- Repository: explorelearningvisit-boop/productionreadymembercard
- Working branch: grok/purple-neon-member-dashboard
- Primary specification: docs/BADGYM_FINAL_APPROVED_DASHBOARD_MASTER_PROMPT.md
- Guardrails: AGENTS.md

## Task handoff
1. ChatGPT or the project owner writes a task in a GitHub Issue or in `ai-handoff/INBOX.md`.
2. The task must include the target branch, objective, acceptance criteria, files/components in scope, and validation commands.
3. A coding agent reads the task and repository instructions before editing.
4. The agent works on a separate task branch and opens a focused pull request. It must not merge protected branches or publish production releases.
5. The agent posts a completion report with commit/PR links, root cause, files changed, tests and build results, and unresolved risks.
6. ChatGPT can retrieve the issue/PR/workflow results through the connected GitHub integration when the owner asks to fetch or review them.

## Task format
Use this structure:
- Task ID:
- Requested by:
- Target branch:
- Objective:
- Context/specification:
- Acceptance criteria:
- Allowed scope:
- Prohibited actions:
- Required validation:
- Result/PR link:

## Security
- Never paste API keys, access tokens, passwords, signing keys, or service-account JSON into repository files, Issues, PR comments, commit messages, or chat.
- Store API credentials only in GitHub Actions Secrets or an approved secret manager.
- The Jules API credential is referenced by the neutral GitHub Actions secret name `CODE_AGENT_BRIDGE_KEY`.
- Secret names are labels, not security controls. The value must remain secret.
- Do not assume that an external agent can read ChatGPT conversation history. Put necessary task context and acceptance criteria in the GitHub handoff.
- Human approval is required before merging protected branches, changing credentials/settings, or releasing production builds.

## Current service limitation
Jules' web interface may be read-only during its announced shutdown period. If Jules cannot create sessions or execute tasks, do not claim that API automation is operational. Use GitHub Issues/PRs and CI as the durable handoff channel, and select an actively supported coding agent if execution is required.
