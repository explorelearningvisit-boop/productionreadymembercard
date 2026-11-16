# BAD GYM — Ten-Reference Unified Gold Design System

Status: ACTIVE — user supplied ten portrait dashboard references on 2026-11-17. This specification unifies their reusable visual language under the already-approved Gold Luxury direction. It does not create ten separate selectable themes.

## Source interpretation

All ten references are inputs to one cohesive BAD GYM Member Intelligence experience. They contain repeated information architecture and several treatments: white/crimson athletic, crimson/gold festive, white/neon-green, black/neon-lime, white/red minimal, ice-blue glass, and dark-emerald premium. Preserve the strongest composition, component hierarchy, gym artwork, member imagery, and data presentation patterns. Do not reproduce their conflicting palettes as separate themes.

## Master identity

- Master direction: Gold Luxury — warm ivory / pearl-white surfaces, premium gold highlights, controlled crimson BAD GYM identity, charcoal typography, restrained glass depth.
- Background: warm ivory-to-cream, never black as the default page canvas.
- Primary: premium gold / amber (#D9A521, #F4C84A, #FFF0B3).
- Brand accent: crimson (#B51F31) for BAD GYM identity, key actions and selected emphasis.
- Surfaces: pearl white (#FFFEFA) and warm ivory (#FFF8E8).
- Ink: charcoal (#24211D) with warm-grey secondary labels.
- Semantic status only: green = present/active/success; amber = late/warning; crimson = absent/due/error; neutral grey = Sunday/off/holiday/disabled. Do not use purple or cyan as independent theme colours.
- Poppins for headings and strong numeric labels; Inter for supporting copy and metadata. Keep the repository's bundled font files.
- Consistent 1px warm-gold borders, soft warm shadows, 14–20dp radii, restrained highlights and clear contrast. Avoid over-glossy bevels, thick neon glow and excessive gradients.

## Shared mobile information architecture

1. Brand header: BAD GYM wordmark, Member Intelligence label, search, notifications and QR actions.
2. Member context: check-in status + date/time, avatar, member name/ID/age/gender, active and plan pills, QR, payment due, expiry countdown and membership progress.
3. Four equal compact intelligence tabs in fixed order: Attendance, Workout, Payment, Body.
4. Bounded intelligence workspace: narrow contextual rail plus one selected workspace. The rail must not sit beside the profile header. Switching tabs/rail destinations replaces the current content; it must not stack cards or create a second vertical page.
5. Optional promotional art only where the existing layout has reserved space and the asset is available; do not allow advertising to displace member-critical information.

## Four workspaces

- Attendance: compact calendar default; day chips use green present, amber late, crimson absent and neutral grey OFF/holiday. Include Trend, History and Insights as rail destinations. Keep dates/text native Flutter widgets, not baked into artwork.
- Workout: session snapshot, duration/change, exercise/program/history destinations and existing dumbbell artwork where it fits. Do not show the word CHECK-IN twice or repeat the same metric in adjacent cards.
- Payment: outstanding/paid state, next due date, plan status, payment history/offers. Crimson communicates due/action required; gold highlights plan/premium details. Payment actions must retain existing handlers.
- Body: current weight and change, composition/measurement/progress/goals destinations and existing body-related art. No invented medical values; clearly identify sample/demo values if no live source exists.

## Assets and graphics

- Reuse the repository's existing assets/hero, assets/graphics, assets/promo, assets/badges, assets/backgrounds, assets/cards, and theme assets after inspecting dimensions, alpha, crop and actual usage.
- Preserve the same member portrait/hero art and coherent gym illustration family across workspaces. Avoid swapping in unrelated people, products or illustration styles.
- Use raster art only for isolated complex illustrations. Keep all headings, metrics, charts, calendar dates, buttons, status labels and QR controls as native Flutter widgets.
- Never stretch a complete screenshot into a background. Never use a sprite sheet/contact sheet as a production image. Preserve aspect ratios and safe crops.
- Do not generate replacement graphics while matching assets already exist.

## Pixel and responsive acceptance

- Primary target: 360dp logical width; Xiaomi 11i 5G reference device is 1080×2400 physical pixels at 2.75x density, Android 13 / MIUI.
- Account for system status/navigation bars; measure the available SafeArea viewport, not the full physical display.
- Keep the four tabs visible at 360dp, no horizontal overflow, no clipped text, no overlapping controls, no repeated labels/metrics, no unbounded vertical content.
- Use LayoutBuilder / bounded constraints for compact-height layouts. Any workspace content must scale or reflow within its assigned viewport; clipping must not hide actionable controls.
- Validate at 360×780 logical dp and a short-height variant. Run dart format, flutter analyze, flutter test, and release APK build in GitHub Actions.
- Pixel-perfect status is not earned by a successful compile alone. Require a fresh Xiaomi screenshot artifact and visual comparison against the ten supplied references.

## Functionality and release safety

- Preserve authentication, navigation, database/API bindings, member identity, payment/renewal handlers, QR, notifications, update center, and existing business logic.
- Do not replace live data with hardcoded presentation values. Keep explicit demo fallbacks visibly distinguishable.
- Work only on the isolated design branch until CI and visual QA are complete. Do not write to production main or merge without separate verification.
- Never uninstall the installed app, clear app data, bypass signing checks, or expose ADB/Tailscale credentials.
