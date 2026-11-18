# Scratch Visual Rebuild — Execution Log

Branch: `chatgpt/member-intelligence-visual-rebuild-v2`
Base: `main` (clean branch created; no direct main writes).
Approved reference: `1000320298.png`, 691×1536.
Comparison capture: `1000320408.jpg`, 691×1536.

## Phase 0 — Reset and source-of-truth
- [x] Create isolated v2 branch from main, avoiding the previous failed feature branch.
- [x] Confirm reference is glossy crimson/red + metallic gold + pearl white (not ice blue).
- [x] Preserve installed screenshot as a comparison artifact, not a design reference.
- [ ] Record source hashes and measured section geometry in a machine-readable manifest.

## Phase 1 — Forensic inventory
- [x] Enumerate all assets recursively; record path, file size and Git blob hash (257 assets; 246 PNG, 6 TTF, 4 SVG, 1 README).
- [ ] Map every asset reference in Dart to widget/screen (not yet complete).
- [ ] Generate contact sheets for review only (not yet complete).
- [x] Initial classification policy and suspicious families documented; individual asset approvals remain pending.

## Phase 2 — Material/theme pack
- [x] Define initial color, typography, spacing, radii, border, bevel, glow and shadow tokens in `lib/core/theme/reference_design_tokens.dart` (requires screenshot QA calibration).
- [ ] Produce separate background and gold ribbon overlays only if needed; responsive gradients remain native Flutter.
- [ ] Validate at 360dp against source proportions.

## Phase 3 — Brand/icon/illustration packs
- [ ] Brand mark: isolated transparent PNG/SVG; preserve exact brand lettering as native text if logo source is unavailable.
- [ ] Icons: consistent vector set; no emoji artwork.
- [ ] Isolated 3D artwork: extract/regenerate only source-visible illustrations.
- [ ] Portrait: preserve identity; clean extraction/upscale only after edge QA.
- [ ] Promo banners: source-accurate artwork and editable native typography where possible.

## Phase 4 — Component reconstruction
- [ ] Theme + base scaffold.
- [ ] Header.
- [ ] Member identity/membership card.
- [ ] Festival banner.
- [ ] Four KPI cards.
- [ ] Attendance intelligence workspace, rail, chart, status table, calendar and footer.
- [ ] Protein burger banner.
- [ ] Full-screen responsive composition.

## Phase 5 — Quality assurance
- [ ] Asset validation.
- [ ] Dart format, Flutter analyze and tests.
- [ ] APK build and signing verification.
- [ ] Xiaomi device install/launch/screenshot (requires device online).
- [ ] Reference overlay/difference and iterative corrections.
- [ ] Release only after acceptance gates.

## Current honest status
- Clean v2 branch created from main.
- Approved reference and installed screenshot compared at identical 691×1536 dimensions (mean absolute RGB difference about 66.95/255; this is a coarse global difference, not a perceptual score).
- Source-derived visual specification committed.
- Recursive inventory found 257 asset files and 21 duplicate-content groups; 76 files are in extracted_new and 80 in images. Berries/fruit assets are present but are not part of this approved screen.
- Asset forensic audit committed.
- Initial design token layer and reusable pearl/gold material surfaces committed.
- Generated red/gold dumbbell artwork was cut out from the generated checkerboard background, alpha-verified, and upscaled 2× as a candidate asset pack; it is not yet integrated or approved.
- No fresh APK, integrated production asset pack, device QA, or pixel-perfect claim is made. Continue only through the explicit gates above.
