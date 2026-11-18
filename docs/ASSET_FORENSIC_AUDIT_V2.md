# Asset Forensic Audit — Clean Visual Rebuild v2

Branch: `chatgpt/member-intelligence-visual-rebuild-v2`
Base snapshot: `main`
Audit source: Git tree `main` (recursive), inspected 18 Nov 2026.

## Inventory totals
- Total files under assets/: 257
- PNG: 246
- TTF: 6
- SVG: 4
- Markdown: 1
- Duplicate-content groups by Git blob SHA: 21
- Important: duplicate names/identical blobs do not imply the asset is visually correct for the approved reference.

## Folder counts
| Folder | Files |
|---|---:|
| backgrounds | 6 |
| badges | 42 |
| cards | 1 |
| decorations | 10 |
| extracted_new | 76 |
| fonts | 6 |
| graphics | 8 |
| hero | 6 |
| icons | 4 |
| images | 80 |
| promo | 6 |
| themes | 11 |
| assets root README | 1 |

## Immediate audit findings
1. Repository contains 257 asset files, but no complete, approved manifest linking each asset to the approved red/gold reference and a target widget.
2. There are 21 groups of duplicate-content files (same Git blob SHA under multiple names/paths).
3. Asset families include berries, blackberries, blueberries, strawberries, currants and mint. These are not visible in the approved Member Intelligence screenshot and must not be used on this screen unless the user later explicitly approves them.
4. `assets/extracted_new/` contains experimental composites, test exports, row/sprite-like compositions and individual candidates. These are not automatically production-ready.
5. There are duplicate logo/crest, dumbbell, trophy, flame, waves, profile/avatar, badge and promo assets. Visual inspection is mandatory before selecting one.
6. Existing app source on main launches `MemberCheckInScreen`; previous failed feature branch launched a separate crimson reference dashboard. The v2 branch is based on main to avoid inheriting the failed branch's screen composition.

## Initial asset disposition rules
- **Candidate:** source might match reference; not approved until visual inspection.
- **Keep:** source is exact/high quality and maps to an approved reference element.
- **Extract:** isolate from source only if edge and resolution quality permit.
- **Regenerate:** source is missing/low quality or visual material needs a fresh isolated export.
- **Retire:** irrelevant, duplicate, experimental, sprite sheet or mismatched theme.

## Explicitly flagged for review (not yet approved)
- `assets/backgrounds/*`: inspect actual pixels and alpha before choosing background layer.
- `assets/graphics/bad_gym_crest.png`, `assets/graphics/bad_gym_logo_hq.png`: same content hash; inspect which, if either, matches the approved logo.
- `assets/graphics/dumbbell_3d.png`, `assets/extracted_new/dumbbell_halo_perfect_clean.png`: same content hash; inspect edge quality and color match.
- `assets/badges/best_trophy*.png`: same content hash across variants; inspect true dimensions and alpha.
- `assets/badges/streak_flame*.png`: same content hash across variants; inspect true dimensions and alpha.
- `assets/extracted_new/target_avatar.png`, `assets/images/avatar_ashwini.png`, `assets/images/member_avatar.png`: same content hash; identity/crop must be checked against reference.
- `assets/decorations/*berries*`, `assets/decorations/*strawberries*`, `assets/decorations/*blueberries*`: irrelevant to approved screen unless proven otherwise; default disposition RETIRE for this screen.
- `assets/extracted_new/*row*`, `*full_card*`, `*sec_main*`, `*sec_card*`: treat as composite/experimental, never ship as standalone widget artwork without inspection.

## Next forensic actions
1. Download selected candidate assets in original resolution and inspect a contact sheet.
2. Extract dimensions, color mode, alpha extrema, alpha coverage, edge halos and file hashes.
3. Map all Dart asset references on main to their owning widgets.
4. Produce `assets/manifest.json` with provenance, target widget and approval status.
5. Only then select/extract/upscale/regenerate the material, logo, icon and illustration packs.
