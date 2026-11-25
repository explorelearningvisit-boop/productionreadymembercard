# Project Agent Skill Pack

Curated, project-local workflow guidance for the Flutter member dashboard.

## Installed playbooks
- `ui-ux-pro-max`: multi-platform UI/UX design intelligence (MIT upstream).
- `frontend-design`: distinctive interface design guidance (Anthropic skills repository; see upstream license before redistribution).
- `verification-before-completion`: evidence-first verification (MIT upstream Superpowers).
- `dispatching-parallel-agents`: decomposition and independent workstream coordination (MIT upstream Superpowers).
- `accessibility-engineering`: WCAG-oriented accessibility audit (MIT upstream Agent Skills).
- `incremental-implementation`: thin-slice implementation and verification (MIT upstream Agent Skills).

## Project execution rules
1. Preserve the supplied dashboard screenshot as the visual acceptance reference.
2. Keep the mobile viewport compact; do not redesign unrelated product flows.
3. Inventory every source asset before deriving it. Never overwrite source packs.
4. Every derived icon must have a source reference, dimensions, format, transparency status, and processing note in the asset manifest.
5. Sprite sheets are preserved in the master source library; extracted icons go to the icon collection as individual transparent PNGs.
6. Use deterministic names: `YYYYMMDD_HHMMSS_IST_CONTEXT_ASSETTYPE_ASSETNAME_vNN.ext`.
7. Do not claim a build, test, or APK is successful without recorded command/CI evidence.
8. Keep third-party skill instructions scoped to this repository and review upstream changes before updating.

## Upstream sources
- ui-ux-pro-max: https://raw.githubusercontent.com/nextlevelbuilder/ui-ux-pro-max-skill/main/.claude/skills/ui-ux-pro-max/SKILL.md
- frontend-design: https://raw.githubusercontent.com/anthropics/skills/main/skills/frontend-design/SKILL.md
- verification-before-completion: https://raw.githubusercontent.com/obra/superpowers/main/skills/verification-before-completion/SKILL.md
- dispatching-parallel-agents: https://raw.githubusercontent.com/obra/superpowers/main/skills/dispatching-parallel-agents/SKILL.md
- accessibility-engineering: https://raw.githubusercontent.com/addyosmani/agent-skills/main/skills/accessibility-engineering/SKILL.md
- incremental-implementation: https://raw.githubusercontent.com/addyosmani/agent-skills/main/skills/incremental-implementation/SKILL.md

Imported on 2026-11-23. The source repositories may change; these copies are pinned snapshots.
