# BAD GYM — UI skills router

Project-level skills live in `.agents/skills/` and are version-controlled with
the repository. They are instructions/reference workflows, not runtime
Flutter packages.

| Need | Skill | Default use |
|---|---|---|
| UI audit, spacing, colour, type, layout and motion quality | `unslop` | Required for every visual audit or UI implementation |
| Advanced motion, transitions, gesture/scroll animation | `animmaster-lib` | Use as a licensed design reference; native Flutter port |
| Cards, dynamic-island patterns, image reveals, drag/scroll interactions | `skiper-ui` | Check free/premium badge and attribution; native Flutter port |
| Buttons, text motion, tooltips, hover/focus effects | `vengeance-ui` | MIT source reference; native Flutter port |

## Repository policy
- This repository is Flutter/Dart. Never add React, Next.js, Tailwind,
  shadcn, Vite, Framer Motion, GSAP or npm dependencies to the Android app
  solely because a web component library uses them.
- Use web registry install commands only in a separate web app that actually
  exists in the repository and has the required framework/toolchain.
- Inspect each component's source, dependencies, licence and reduced-motion
  behaviour before reuse.
- Prefer existing Flutter primitives and dependencies; avoid redundant
  animation packages.
- Skills are committed at project level so branches created from the shared
  integration base inherit them. Existing long-lived branches must rebase or
  cherry-pick the skill-install commit to receive later additions.
- The default `main` branch is not modified by this skill-install pass.
