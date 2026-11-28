---
name: vengeance-ui
description: >
  Use Vengeance UI as a reference for high-craft animated buttons, text
  transitions, hover feedback, tooltips, bento layouts and subtle interaction
  patterns. Trigger when the user mentions Vengeance UI or requests a
  distinctive interaction. Translate into Flutter for BAD GYM; do not install
  React/Tailwind registry code in the Flutter app.
---

# Vengeance UI

## Source identity
- Official website/catalogue: https://www.vengenceui.com/
- Public GitHub repository: https://github.com/Ashutoshx7/VengeanceUI
- Upstream agent skill: https://github.com/Ashutoshx7/VengeanceUI/tree/main/.cursor/skills/vengeance-ui
- Upstream source is MIT licensed. Retain the MIT copyright and licence notice
  when copying or adapting any source code. A component's third-party
  dependencies keep their own licences.
- The upstream skill and registry primarily target React, Tailwind, shadcn/ui,
  Framer Motion, GSAP and web components. They are not directly installable in
  this Dart/Flutter app.

## Upstream workflow for a compatible web project
1. Search the live component catalogue.
2. Inspect the exact component's props, source and dependencies.
3. Install by its componentName, not its documentation slug.
4. Keep accessibility and reduced-motion behaviour from the source.
5. Never guess a registry component name or dependency list.

Registry base: https://www.vengenceui.com/r
Example web install:
```bash
npx shadcn@latest add https://www.vengenceui.com/r/animated-button.json
```
Do not run this command in the Flutter project.

## Flutter translation
- Tactile button feedback: InkWell / GestureDetector + AnimatedScale or
  AnimatedContainer with small motion only
- Text count changes: TweenAnimationBuilder
- Tooltip/menu interactions: Tooltip, MenuAnchor, PopupMenuButton
- Focus/hover: FocusableActionDetector; keep touch behaviour as the baseline
- Background effects: CustomPainter only when a static, low-cost Flutter
  equivalent materially improves comprehension

## BAD GYM constraints
- No web-only npm dependencies in the Flutter app.
- No cursor-tracking effects on touch-first screens.
- No perpetual shimmer, glow, bounce, blur or particle loops.
- Respect reduced motion and keep transitions within 160–220ms by default.
- Preserve current palette, content, PulseVault artwork and member actions.
- Test semantics, focus, touch hit area and 320/360/390dp layouts.

## Workflow
1. Search the catalogue only when a concrete component need exists.
2. Read the source and dependency list before selecting it.
3. Port the interaction into an existing Flutter component where possible.
4. Keep upstream attribution/licence notices for any copied source.
5. Add a focused widget test and record the upstream URL.
