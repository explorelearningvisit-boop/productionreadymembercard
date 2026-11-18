# BAD GYM Member Intelligence — Approved Visual Specification

Reference source: user-uploaded `1000320298.png` (approved original), 691×1536 px.
Installed comparison capture: user-uploaded `1000320408.jpg`, 691×1536 px.
Target branch: `chatgpt/member-intelligence-visual-rebuild-v2` (created from `main`).
Do not modify `main` directly.

## 1. Visual identity (source-derived)
- Primary visual language: glossy crimson / deep ruby red + metallic gold + pearl white.
- Not ice-blue. Do not use the earlier mistaken ice-blue palette.
- Background: deep red-to-crimson gradient with subtle radial illumination and restrained glossy gold wave accents.
- Cards: pearl/ivory white surfaces, crisp metallic-gold outer edge, fine inner highlight, controlled warm shadow; clear edge separation from background.
- Header: red glossy surface, gold swoosh/ribbon, white brand text, yellow/gold emphasis for GYM.
- Typography: bold, high-contrast, compact but readable; modestly increase body/metric size where reference and 360dp constraints allow. Use existing Poppins/Inter only after glyph and weight audit.
- Status colors: present green, late amber, absent red, holiday purple. These are semantic, not theme replacements.
- Avoid random purple/pink gradients, unrequested glass-blue treatment, flat beige substitutions, generic emoji art and mismatched icon packs.

## 2. Approved screen hierarchy
1. Brand header with dumbbell mark, BAD GYM / Member Intelligence, Search, Notifications badge, QR.
2. Member identity card: portrait frame, checked-in/date pills, name, member ID, age, gender, QR, Active and Plan pills, Payment and Expiry rows, membership progress and percentage.
3. Amazon Great Indian Festival sponsored banner (as shown in approved reference).
4. Four KPI cards: Attendance, Workout, Payment, Body.
5. Attendance Intelligence workspace: vertical rail (Calendar, Trend, History, Insights, Goal), title/month selector, donut summary, status counts and percentages, weekday headings, date capsules, legend, streak/best footer.
6. Protein Burger promotional banner at bottom (as shown in approved reference).
7. Android system status/navigation areas are not part of the Flutter artwork and must be respected via safe areas/system UI styling.

## 3. Layout and measurement rules
- Screenshot dimensions are 691×1536 px. Do not mistake screenshot pixels for dp.
- Target logical width: 360dp. Derive scale from actual device density and compare the app viewport, not Android system bars.
- Use bounded layout, explicit constraints and responsive sizing. No FittedBox shrink-to-tiny typography.
- Match major vertical section boundaries and relative widths before polishing decoration.
- Keep calendar, donut/chart, labels, text, QR and controls native Flutter widgets. Do not bake them into raster images.
- Portrait image must use the real approved source identity; do not synthesize or alter the member's face.
- Preserve reference-visible banner content. Do not add new ads or remove these two reference banners.

## 4. Asset production policy
- First inspect all existing assets and create an asset-to-widget inventory. No blind reuse.
- Build a material pack: red/ruby background textures and gold ribbon/shine overlays only where separate raster layers materially improve fidelity.
- Build a brand pack: isolated dumbbell/logo mark with transparent background if original logo artwork is unavailable.
- Build a 3D artwork pack only for actual raster illustrations visible in the reference (e.g. gym dumbbell artwork and promo subject cutouts).
- Build icons as consistent SVG/vector assets or Flutter icons, not rasterized emoji.
- Extract from source only when subject boundaries and resolution permit. Remove backgrounds with alpha-aware edge cleanup; preserve fine hair/edge detail. Do not claim a crop is a clean transparent cutout without visual inspection.
- Upscale only isolated art, never upscale the whole screenshot and treat it as source artwork.
- All transparent exports must be PNG RGBA, tight-cropped, halo-free, with alpha verified. Maintain originals separately.
- Native card borders, bevels, shadows, glows and gradients should be Flutter decorations when they need to scale responsively.
- Banners are composed layouts; retain source artwork where available, but reconstruct text and controls as native content when editable/required.
- Maintain `assets/manifest.json`: asset id, path, source, dimensions, alpha, hash, license/provenance, target widget, status (candidate/approved/rejected).

## 5. Implementation sequence (gates)
A. Freeze reference and derive geometry/color/type tokens.
B. Inventory and classify every existing asset: keep / extract / regenerate / retire.
C. Produce and inspect background/material, brand/logo, icon and illustration packs.
D. Implement theme tokens and reusable surfaces (background, gold edge, inner highlight, shadow, pills, buttons, typography).
E. Build components in isolation: header; member card; promo banner; KPI cards; attendance rail; attendance summary/calendar; bottom banner.
F. Compose full screen and compare same viewport.
G. Run formatter, analyzer, widget tests, asset validation, APK build.
H. Install on target Xiaomi only after device is online; capture screenshot; generate overlay/difference; fix mismatches; repeat.

## 6. Acceptance gates
- No phase is silently skipped.
- No unapproved assets or UI elements.
- No asset enters production without dimensions, alpha/provenance and visual inspection.
- No layout is called pixel-perfect based on source review alone.
- 360dp layout has no overflow, clipped text or tiny FittedBox text.
- Fresh device screenshot is compared against approved reference.
- CI, APK creation, signature, installation, launch and visual match are reported as separate outcomes.

## 7. Explicit exclusions
- Do not use ice-blue palette from a previous mistaken plan.
- Do not use the latest installed screenshot as the design authority; it is the failed implementation under test.
- Do not blindly reuse historical assets just because they exist in the repo.
- Do not add unrequested gradients, promo artwork, decorative stickers or invented data.
