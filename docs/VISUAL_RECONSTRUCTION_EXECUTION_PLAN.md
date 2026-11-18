# BAD GYM — Visual Reconstruction & Asset Production Execution Plan

Status: IN PROGRESS — authoritative user reference received and measured.
Target branch: chatgpt/member-intelligence-mobile-rebuild
Base branch: main (do not modify directly).

## 0. Source of truth
- Authoritative reference: user-uploaded `1000320298.png`, 691×1536 px, RGB.
- SHA-256: `694278b5a4c8aa76a4a3306bfe978f36d9aaaef897495965d31170785d4e59c6`.
- The reference is crimson/burgundy red + gold + white glass, not ice-blue. Any earlier ice-blue specification is superseded.
- Preserve both visible promotional surfaces: Amazon Great Indian Festival banner and Protein Burger banner. They are part of the supplied reference; do not remove them.
- Native Flutter elements: all text, numbers, QR, calendar, charts, controls, pills, progress indicators and borders. Raster artwork only for isolated photographic/complex promotional art.
- User requests slightly larger typography while preserving the same layout, color relationships, hierarchy and content.

## 1. Verified repository baseline
- `lib/main.dart` launches `ReferenceMemberDashboard`.
- `lib/presentation/reference_member_dashboard.dart` already uses burgundy/crimson/gold tokens and includes member pass, Amazon banner, KPI row, attendance intelligence workspace, contextual rail and Protein Burger banner.
- `lib/presentation/widgets/reference_ad_banners.dart` draws both promo banners in Flutter and references `assets/hero/hero_weights.png`, `assets/promo/promo_model.png`, and `assets/promo/promo_burger.png`.
- `lib/core/theme/member_dashboard_palette.dart` already defines a crimson/gold palette consistent with the reference family; final token calibration and typography sizing remain to be verified against device capture.
- Current branch has historical/experimental asset folders; perform usage mapping before deletion.
- The current implementation has not yet been proven pixel-equivalent to the newly uploaded reference. CI success alone is not visual acceptance.

## 2. Phase-by-phase execution

### Phase A — Reference intake and measurement (source received)
1. Preserve original image unchanged and record SHA-256/dimensions.
2. Exclude Android status and navigation bars when comparing app viewport.
3. Measure header, member pass, sponsor banner, KPI row, workspace/rail, attendance calendar, streak strip and lower promo banner.
4. Record geometry, color samples, typography hierarchy, border radii, double gold outlines, highlights, shadows and safe areas.
5. Map screenshot pixel geometry to dp using target Xiaomi 11i display density; do not equate pixels with dp.
6. Freeze all visible text/content and disallow unrequested additions.

### Phase B — Repository and asset forensics
1. Enumerate every asset: dimensions, format, byte size, alpha, color mode and SHA-256.
2. Map every asset reference to Dart widget/screen.
3. Classify duplicates, stale, test, composite, sprite-sheet and unused assets.
4. Preserve source artwork; stage derivatives separately.
5. Create an asset disposition ledger: keep, extract, regenerate, replace or retire.

### Phase C — Extraction and cleanup
1. Profile portrait extracted from the member card using GrabCut and exported as RGBA PNG at 3×.
2. Portrait cutout is an automated first pass; inspect hair, face, shoulder and clothing edges for red spill/halos before production approval.
3. Amazon and Protein Burger banners are cropped as exact RGB PNG source artwork because their red gradients, text and decorative elements are intrinsic to each banner; do not force transparent backgrounds.
4. For isolated art inside banners, use object-level segmentation only where edges can be validated. Keep full-banner crops as fallback.
5. Extract gold borders/glass highlights only when a clean independent layer exists. Otherwise implement borders/highlights natively in Flutter to avoid screenshot artifacts.
6. Export transparent PNG (RGBA) for isolated foreground art; preserve RGB for full composite banners.
7. Tight-crop alpha bounds, document padding, inspect alpha on light and dark preview backgrounds.
8. Never fabricate unseen pixels from cropped source areas.

### Phase D — Upscaling and regeneration
1. Upscale only isolated assets that need it; portrait was enlarged 3× with Lanczos after segmentation.
2. Do not upscale the full screenshot and pass it off as original asset art.
3. Regenerate only isolated artwork that cannot be cleanly extracted.
4. Maintain the screenshot's crimson/gold/white lighting and visual treatment.
5. Validate sharpness, alpha fringe, color spill, aspect ratio and scale behavior.

### Phase E — Flutter reconstruction
1. Match crimson/burgundy background, gold outlines/highlights, white/ivory glass surfaces, black/dark text and semantic green/red/purple/yellow status colors.
2. Preserve exact screen hierarchy: header; member pass with QR and payment/expiry; membership progress; Amazon banner; four KPI cards; left rail + Attendance Intelligence; streak/best strip; Protein Burger banner.
3. Keep both banners; their presence is explicitly required by the supplied reference.
4. Keep text, metrics, calendar, chart, QR and controls native and data-driven.
5. Increase text modestly (target +1 to +2 logical px at compact sizes, responsive) without overflow or collapsing the layout.
6. Preserve gold double borders, rounded corners, soft white/glass cards, glossy red background and shadows.
7. Validate 360dp width and Xiaomi 11i viewport, including short-height behavior.
8. Avoid duplicating payment, due-date, attendance or progress metrics.

### Phase F — Asset integration and validation
1. Add approved production assets only, with stable filenames.
2. Maintain machine-readable manifest with source, dimensions, alpha, purpose, hash, processing and license.
3. Validate every referenced asset exists; detect duplicate hashes and unexpected non-alpha transparent exports.
4. Remove unused asset declarations only after a complete source-reference audit.
5. Run formatter, analyzer, unit/widget tests and asset checks.

### Phase G — Visual QA and release
1. Build fresh release APK on the feature branch.
2. Install only when Xiaomi 11i is online in Tailscale and its current Wireless Debugging endpoint is available.
3. Capture screenshot/logcat from the exact artifact.
4. Crop reference and device screenshot to the same app viewport and scale.
5. Produce overlay/difference images and inspect geometry, colors, text, crop, shadows and border fidelity.
6. Fix mismatches and repeat; report CI, signing, install, launch and visual match separately.
7. Do not claim pixel-perfect or production-signed without evidence.

## 3. Asset extraction package generated
- `reference_full_691x1536.png`: unchanged source.
- `member_portrait_cutout_3x.png`: RGBA, 336×489, alpha channel.
- `sponsored_amazon_banner.png`: RGB, 666×123.
- `protein_burger_banner.png`: RGB, 671×193.
- `asset_manifest.json`: SHA-256, dimensions, alpha, bytes and source notes.
- ZIP: `bad_gym_reference_asset_pack.zip` (generated in the current ChatGPT workspace; not yet committed as repository binary assets).

## 4. Acceptance criteria
- Uploaded reference is sole visual authority.
- Both promo banners remain in their specified positions.
- Portrait alpha has no visible red halo or missing hair/clothing edges.
- Full banner artwork remains crisp; no unwanted transparency.
- Borders are crisp, aligned and consistent.
- Text is slightly larger but readable at 360dp with no clipping/overflow.
- All dynamic text/data/chart/calendar/QR remain native Flutter UI.
- CI passes and a fresh Xiaomi screenshot is compared with the reference.
