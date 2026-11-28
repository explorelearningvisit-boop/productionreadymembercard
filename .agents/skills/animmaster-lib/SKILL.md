---
name: animmaster-lib
description: >
  Use Animmaster Lib as a reference for high-quality motion systems, page
  transitions, scroll effects, sliders, hover interactions and animated
  backgrounds. Trigger when a BAD GYM UI task needs a distinctive animation
  or the user explicitly mentions Animmaster. For this Flutter repository,
  translate concepts into native Flutter; do not import its Vite/JS stack.
---

# Animmaster Lib — motion reference

## Source identity
- Official product: https://animmasterlib.dev/
- Public documentation repository: https://github.com/Animmaster/docs
- Public docs: https://animmaster.github.io/docs/
- The GitHub repository is documentation for an Animmaster Vite template; it is
  not the full component source repository.
- The product advertises a paid PRO/Premium library. Do not copy protected
  component source, assets or paid content unless the owner has a valid licence.

## Use it for
- Scroll and reveal choreography
- Page/module transitions
- Gesture-driven sliders and carousels
- Hover/mouse interactions (only where pointer input exists)
- SVG and vector motion
- Carefully scoped background and hero motion

## Flutter translation
Prefer the smallest native implementation:
- Implicit state: AnimatedContainer, AnimatedOpacity, AnimatedSwitcher,
  TweenAnimationBuilder
- Explicit timelines: AnimationController + CurvedAnimation + Tween
- Gestures: GestureDetector / InkWell with touch-safe hit areas
- Scroll choreography: ScrollController, Sliver widgets and visibility
  observation; avoid web-style scroll hijacking
- Custom vector/data motion: CustomPainter only when a normal widget cannot
  express the visual clearly

Do not add a web runtime, Vite, React, GSAP, Three.js or JavaScript packages to
the Flutter app. Add a Flutter package only when a specific implemented
component needs it and its maintenance/licence/performance are checked.

## BAD GYM constraints
- Preserve the 360dp phone-first design and test 320/360/390dp.
- Keep transitions short and purposeful (normally 160–220ms); no perpetual
  loops, autoplay carousels, continuous spins or expensive blur/shader effects.
- Honour MediaQuery.disableAnimations and reduced-motion settings.
- Never animate layout dimensions when opacity/transform can achieve the same
  feedback. Do not animate every card independently.
- Keep touch targets usable and do not hide important values behind motion.

## Workflow
1. Name the exact component and the user-visible purpose of its motion.
2. Inspect the current Flutter implementation and existing animation utilities.
3. Choose the simplest native Flutter primitive.
4. Implement one component at a time with a reduced-motion fallback.
5. Add a widget test for state/semantics and verify 320/360/390dp layouts.
6. Report any source-library feature that cannot be ported without a paid
   source licence or web runtime.
