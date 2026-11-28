# BAD GYM — Flutter UI/UX Skill Application

This project uses a project-owned Purple Neon / Gold design system. External skills are guidance for engineering quality; they do not override the approved dashboard reference or the 360 dp mobile-first product constraints.

## Selected skill sources

- Flutter official architecture skill: https://github.com/flutter/agent-plugins/tree/main/skills/flutter-apply-architecture-best-practices
- Flutter responsive/adaptive guidance: https://docs.flutter.dev/ui/adaptive-responsive
- Flutter accessibility guidance: https://docs.flutter.dev/ui/accessibility
- Flutter design-polish and Android emulator skills: https://github.com/ChunkyTofuStudios/flutter-skills
- Flutter custom design system and accessibility skills: https://github.com/TheSimpleApp/flutter-app-skills
- Existing project UI/UX Pro Max skill: `.agents/skills/ui-ux-pro-max/SKILL.md`
- Existing project verification gate: `.agents/skills/verification-before-completion/SKILL.md`

## Project routing

1. Use the custom-design-system route. Preserve `MemberTheme`, the Pearl Glass / Purple Neon / Gold design tokens, approved typography hierarchy, bright glass content field, semantic per-card color zoning, and PulseVault asset authority. Purple is reserved primarily for the frame, rail and selected accents. Do not replace the interface with default Material 3 styling.
2. Use responsive/adaptive layout practices for 320, 360, and 390 dp widths and short/tall phone viewports. Respect parent constraints and SafeArea.
3. Use design-polish review for hierarchy, readable labels, spacing, image aspect ratios, and elimination of accidental overlap.
4. Use accessibility review for semantic labels, contrast, minimum practical touch targets, text scaling, and TalkBack behavior. Never use color as the only status signal.
5. Use Android emulator screenshots for repeatable visual checks, then verify touch behavior and final rendering on a physical Android phone.
6. Keep UI rendering separate from data access. Demo data must remain visibly marked until a real repository/API is connected.
7. Do not add runtime dependencies merely to apply a skill. Prefer Flutter SDK widgets and the existing design system.
8. A skill recommendation is not evidence of a fix. Every fix needs a regression test or a recorded manual verification step.

## Dashboard-specific quality gates

- The attendance panel must consume the available vertical space rather than leaving an unexplained blank region.
- The Gold Plan and Active pills must render each label once; decorative image assets must not duplicate live text.
- Transparent product/person cutouts use `BoxFit.contain`; do not stretch source imagery.
- The full-screen reference image is visual guidance only and must never be a runtime background.
- Preserve the six approved in-card navigation destinations and avoid adding app-level navigation inside this component.
- No unverified "LIVE" status; demo/sample data must be labelled.
- No completion claim until formatting, analysis, widget tests, ARM64 build, signature, and artifact checks have fresh passing evidence. Physical-device verification is reported separately.

## Change log

- 2026-11-26: Removed the fixed 290 dp cap from the outer dashboard content region; the attendance panel now expands when the phone has spare height and only scales down on short viewports.
- 2026-11-26: Removed decorative badge-background images from the Gold Plan/Active pills to prevent graphic text from overlapping the live Flutter label.
- 2026-11-26: Updated widget tests to check adaptive attendance-panel sizing and compact viewport visibility.
