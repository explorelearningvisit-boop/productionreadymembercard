---
name: skiper-ui
description: >
  Use Skiper UI as a reference for refined interface components, card
  interactions, dynamic-island patterns, image reveals, drag/scroll gestures
  and Apple-like motion. Trigger when the user mentions Skiper UI or asks for
  a polished interaction pattern. In BAD GYM, implement a native Flutter
  equivalent instead of installing React components.
---

# Skiper UI — component and interaction reference

## Source identity
- Official component library: https://skiper-ui.com/
- Official quick start: https://www.skiper-ui.com/docs/quick-start
- The official catalogue advertises 100+ reusable components. Some components
  are premium; check the component's badge before selecting it.
- The official free-version terms require attribution to Skiper UI. Preserve
  attribution when a free component or its source is actually used.
- Do not treat third-party GitHub clones as the official source.

## Use it for
- Compact card and panel interactions
- Dynamic-island / status feedback patterns
- Image reveal and layered artwork transitions
- Drag/scroll storytelling, card stacks and parallax
- Refined menus, tooltips and micro-interactions

## Flutter translation
- Card state: AnimatedContainer / AnimatedSwitcher
- Drag and swipe: GestureDetector with bounded velocity and clear affordances
- Scroll-linked changes: ScrollController or slivers; never trap the user in
  scroll-jacking
- Dynamic-island-like status: a small, accessible AnimatedContainer that
  expands only in response to a real state change
- Image reveals: ClipRect + Align/ShaderMask only when needed; preserve the
  original PulseVault image and aspect ratio
- Tooltips and menus: native Tooltip, MenuAnchor or PopupMenuButton

Do not add Next.js, React, Tailwind, shadcn, Framer Motion or npm packages to
this Flutter app. The official registry's web components are not Flutter
widgets; translate the interaction and visual principles natively.

## BAD GYM constraints
- Keep the lilac pearl glass shell and current product information hierarchy.
- Maintain compact 360dp layout, verify 320/360/390dp and 560–800dp heights.
- Motion should explain a state change, not decorate every surface.
- Respect reduced motion, TalkBack semantics, keyboard focus and touch targets.
- No fake data, invented offers or unverified live states.

## Workflow
1. Identify the exact UI component and interaction being improved.
2. Check whether the official component is free or premium.
3. If using free source, preserve the required attribution.
4. Map the interaction to existing Flutter widgets before adding dependencies.
5. Implement one component at a time; add responsive and semantics tests.
6. Record the official component/page URL in the implementation notes.
