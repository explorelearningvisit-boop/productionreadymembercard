# BAD GYM — Visual Reconstruction & Asset Production Execution Plan

Status: IN PROGRESS — baseline audit started; authoritative final reference image required before pixel-level extraction.
Target branch: chatgpt/member-intelligence-mobile-rebuild
Base branch: main (do not modify directly).

## 0. Non-negotiable source-of-truth gate
- The final approved visual reference is documented as the 17 Nov 2026 ice-blue glass Member Intelligence screenshot, 1024×1536.
- The referenced source file `1000320035.jpg` is not present in the currently mounted working files and was not found in the Library search.
- Several earlier design images exist, but they are not interchangeable with the final reference. Do not use an older variant as the authority.
- Pause pixel-accurate extraction and final layout implementation until the user re-uploads the exact approved reference.
- Once received, record its exact file identity, dimensions, color profile, and SHA-256 in the asset manifest.

## 1. Baseline findings (verified from current feature branch)
- `lib/main.dart` launches `ReferenceMemberDashboard`.
- `lib/presentation/reference_member_dashboard.dart` hard-codes a burgundy/crimson dashboard background and old theme styling.
- The screen includes `ReferenceProteinBanner` at the bottom, which conflicts with the latest reference specification's compact AI Insights strip.
- `lib/presentation/widgets/reference_ad_banners.dart` implements legacy Amazon and Protein Burger promo surfaces and references legacy artwork.
- `lib/core/theme/member_dashboard_palette.dart` defines burgundy/crimson/gold tokens, inconsistent with the latest ice-blue reference.
- Existing repository contains many historical/experimental asset folders and duplicate exports, including `assets/extracted_new/`, `assets/images/extracted/`, old theme folders, and multiple variants of similar badges/artwork.
- Existing `assets/README.md` correctly requires transparent isolated art, verified alpha, dimensions, source/license and intended usage; this policy will be expanded into a strict asset manifest and validation workflow.

## 2. Phase-by-phase implementation

### Phase A — Reference intake and measurement
1. Obtain the exact final approved screenshot from the user.
2. Preserve the original unchanged; compute SHA-256 and dimensions.
3. Separate OS status/navigation bars from the app viewport for comparison.
4. Build a geometry sheet: screen bounds, safe areas, section bounds, card radii, border widths, spacing, typography scale, colors, shadows and artwork bounds.
5. Derive dp layout from the actual target device density; do not treat screenshot pixels as dp.
6. Record all reference-visible content and explicitly prohibit unrequested UI additions.

### Phase B — Repository and asset forensics
1. Enumerate every asset with dimensions, format, byte size, alpha presence, color mode and SHA-256.
2. Search Dart source for every asset reference and map asset -> widget -> screen.
3. Identify duplicate, stale, test, sprite-sheet, composite and unused assets.
4. Render contact sheets for human review, but never ship contact sheets or sprite sheets as production art.
5. Inspect source screenshots at full resolution before extracting any element.
6. Create an asset disposition table: keep, extract, regenerate, replace, or retire.
7. Preserve originals; all processing outputs go into a versioned staging folder.

### Phase C — Transparent extraction and cleanup
1. Extract only isolated elements that are actually visible in the approved reference.
2. Remove backgrounds with edge-aware masks; inspect hair, fine edges, glass reflections and semi-transparent highlights manually.
3. Extract card borders, glass highlights, wave overlays and isolated 3D objects as separate layers where source quality permits.
4. Export transparent PNG (RGBA); use lossless WebP only after visual comparison if it materially reduces size.
5. Tight-crop transparent bounds while retaining a documented safe padding.
6. Never infer hidden pixels or invent missing pieces from a low-resolution crop; regenerate those assets instead.
7. Record alpha bounding box, dimensions, crop padding, source and processing steps for every output.

### Phase D — Regeneration and upscaling
1. Generate only isolated artwork that cannot be cleanly extracted or whose source resolution is inadequate.
2. Keep all text, numbers, charts, calendars, QR codes, controls and borders as native Flutter elements unless the reference clearly uses a raster illustration.
3. Generate transparent, tightly cropped assets with consistent cool ice-blue lighting and material treatment.
4. Upscale only assets that need it; do not upscale screenshots and then treat the result as original source art.
5. Verify alpha channel, edge halos, color fringing, sharpness and scale behavior on light and cool-blue surfaces.
6. Maintain a stable naming convention and asset manifest.

### Phase E — Design system and Flutter reconstruction
1. Replace the incorrect crimson palette with measured reference tokens: ice-blue/cyan, pearl-white glass, cool-blue edge highlights, navy text and semantic status colors.
2. Rebuild reusable glass surfaces, double-edge borders, elevation/shadows, typography and spacing tokens.
3. Rebuild the exact approved hierarchy: brand header; single member pass; compact sponsored banner; four KPI cards; bounded intelligence workspace with contextual rail; compact AI Insights strip.
4. Remove Protein Burger banner and all other elements absent from the reference.
5. Do not duplicate payment/expiry/progress data across cards.
6. Keep calendar, chart, text and controls native and data-driven.
7. Increase typography modestly only where it remains consistent with the reference and fits at 360dp.
8. Use actual profile photo source and correct crop; never AI-regenerate member identity.
9. Ensure 360dp width, target Xiaomi 11i and short viewport behavior without clipping or horizontal/vertical overflow.

### Phase F — Asset integration and quality controls
1. Add only approved production assets to pubspec.
2. Add a machine-readable asset manifest (path, source, dimensions, alpha, purpose, hash, license).
3. Add a validation script/test for missing references, duplicate hashes, invalid alpha exports and oversized assets.
4. Remove unused asset declarations only after a repository-wide reference audit.
5. Run formatter, analyzer, unit/widget tests and asset validation.

### Phase G — Visual QA and delivery
1. Build a fresh release APK from the feature branch.
2. Install on Xiaomi 11i only when Tailscale and current Wireless Debugging endpoint are online.
3. Capture a fresh screenshot and logcat from that exact build.
4. Align reference and capture to the same app viewport and scale.
5. Produce overlay and difference images; inspect geometry, colors, typography, crop, shadows and edge treatment.
6. Fix every visible mismatch and repeat until acceptance criteria pass.
7. Report CI, APK build, signing status, device installation, launch, screenshot and visual-match status separately.
8. Do not call the app pixel-perfect or production-ready without fresh device evidence.

## 3. Acceptance criteria
- Approved reference is the only visual authority.
- No unrequested promo banners or invented graphics.
- All raster artwork is isolated, tightly cropped, correctly transparent and documented.
- No sprite sheets/contact sheets used as final app assets.
- Borders are crisp and consistently visible; no clipped or distorted imagery.
- Text is comfortably readable at 360dp without overflow.
- Flutter-native data, calendar, chart, QR and controls remain functional.
- CI passes and fresh Xiaomi device screenshot is compared to the approved reference.

## 4. Current blocker / required user input
The exact final 17 Nov 2026 approved screenshot (documented as 1024×1536, previously referenced as `1000320035.jpg`) is missing from the current working files and Library search. User must re-upload that exact final design image. Do not substitute the installed red screenshot or older blue/green/purple variants.
