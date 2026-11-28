# PulseVault — Stage 2 asset audit (2026-11-28)

**Source:** Build #722 artifact `bad-gym-pulsevault-asset-audit`  
**Branch:** `grok/purple-neon-member-dashboard`  
**Auditor:** `tools/audit_pulsevault_assets.py` (Pillow; read-only)  
**Manifest entries:** 16 | **Audited:** 16 | **Missing:** 0

> This is a metadata/alpha audit, not yet a visual crop approval. Alpha bounding-box contact with a canvas edge means no transparent breathing margin exists on that edge; it does **not** prove the visible object is already clipped. Inspect the source pixels before calling any crop final.

## Measured inventory

| File | Actual px | Ratio | Format | Alpha | Transparent px | File size | Initial role decision |
|---|---:|---:|---|---|---:|---:|---|
| `01_member_bodybuilder.webp` | 920×960 | 0.9583 | WebP | True alpha | 40.55% | 94,934 B | Reuse candidate; inspect head/arm silhouette and add padding in optimized derivative |
| `03_whey_protein_tub.webp` | 778×1024 | 0.7598 | WebP | True alpha | 9.24% | 67,786 B | Reuse candidate; add padding, check label edges |
| `04_purple_shaker.webp` | 653×960 | 0.6802 | WebP | True alpha | 22.16% | 59,332 B | Palette conflict; replace or recolor only after visual review, preferable new Emerald/ice cut-out |
| `05_blinkit_grocery_bag.webp` | 960×869 | 1.1047 | WebP | True alpha | 26.66% | 124,574 B | Demo illustration only; partner/logo rights not verified |
| `06_creatine_tub.webp` | 926×960 | 0.9646 | WebP | True alpha | 5.05% | 67,652 B | Reuse candidate; little transparency, add safe padding |
| `08_gold_profile_badge_panel.webp` | 900×578 | 1.5571 | WebP | True alpha | 3.72% | 44,982 B | Backplate/panel candidate; compare with native Flutter surface |
| `10_gold_photo_backplate.webp` | 900×830 | 1.0843 | WebP | True alpha | 1.77% | 85,118 B | Portrait backplate candidate; compare with native clipped surface |
| `15_purple_progress_bar.webp` | 900×73 | 12.3288 | WebP | True alpha | 1.09% | 20,796 B | Retire from progress; native emerald Flutter progress |
| `21_gold_plan_badge_background.webp` | 1200×623 | 1.9262 | WebP | True alpha | 3.62% | 90,496 B | Badge plate candidate; native gradient + text preferred if fidelity is equal |
| `22_green_active_badge_background.webp` | 1200×644 | 1.8634 | WebP | True alpha | 9.84% | 88,250 B | Badge plate candidate; native emerald pill preferred if fidelity is equal |
| `23_freeze_snowflake_graphic.webp` | 915×960 | 0.9531 | WebP | True alpha | 15.15% | 181,922 B | Potential Freeze detail; check if native snowflake icon is sufficient |
| `25_calendar_graphic.webp` | 900×786 | 1.1450 | WebP | True alpha | 11.34% | 67,082 B | Prefer native Material calendar icon unless reference requires the graphic |
| `27_dumbbell_promo_graphic.webp` | 827×1200 | 0.6892 | WebP | True alpha | 15.38% | 99,888 B | Recovery/workout banner art candidate; check subject orientation/crop |
| `28_protinex_tub.webp` | 882×960 | 0.9187 | WebP | True alpha | 7.16% | 105,940 B | Attendance KPI product candidate; add transparent padding |
| `29_sbi_payment_card_graphic.webp` | 960×731 | 1.3133 | WebP | True alpha | 9.25% | 79,600 B | Payment KPI candidate; check card corners/label bounds |
| `fat_loss_support_tub.png` | 1536×1024 | 1.5000 | PNG | True alpha | 0.37% | 2,077,063 B | Body KPI candidate, but huge and nearly opaque; optimize to padded alpha WebP/PNG after inspection |

## Alpha and crop findings

- All 16 manifest entries decoded successfully and have an alpha channel.
- All 16 have visible alpha pixels touching at least one canvas edge in the measured alpha bounding box. For cut-outs this gives no guaranteed 5–8% safety margin. It is a crop-risk flag, not proof that an arm/product is visibly truncated.
- The bodybuilder has the largest clear-pixel proportion (40.55%); the creatine, badge/backplate and Fat Loss art have little clear-pixel area.
- Fat Loss PNG is 2,077,063 bytes; it is the first compression candidate, but silhouette and alpha must be visually reviewed before conversion.
- The purple shaker and purple progress bar conflict with the new Emerald/Pearl visual language. Keep originals in source history; replace their UI usage, do not delete them.
- Badge plates and progress art should be considered native Flutter shapes/widgets first; use raster only if it is a distinctive product visual that cannot be reproduced cleanly.
- Grocery/Blinkit branding is illustrative Demo art until partnership/brand usage is verified.

## Decisions before reuse

1. **Visual review still required:** get the actual 16 source images into a contact sheet and inspect edge-touching silhouettes. This report alone cannot certify the crop.
2. **Cut-out derivatives:** for member portrait, whey, creatine, Protinex, SBI, Fat Loss, dumbbell and any retained shaker/partner art, create an optimized derivative with 5–8% transparent padding and the measured slot aspect ratio. Keep the original file untouched.
3. **Native Flutter replacements:** progress bar, calendar icon, badge backplates and active state should use Flutter shapes/gradients unless a visual comparison proves the raster artwork is superior.
4. **Palette:** purple shaker/progress are not used in the Emerald/Pearl target. A new Freeze bottle should be ice/neutral/emerald, not purple.
5. **Campaign integrity:** the grocery bag is Demo illustration only; no live Blinkit partnership claim unless owner verifies permission/relationship.

## New-art target slot sizes (not measured original dimensions)

Export at 3× the actual logical slot, preserve natural aspect and keep the whole subject visible:

| Asset proposal | Display dp | Export px @3x |
|---|---:|---:|
| 01_member_portrait_cutout.webp | 84×88 | 252×264 |
| 02_checkin_mascot_cutout.webp | 54×48 | 162×144 |
| 03_freeze_bottle_ice_cutout.webp | 46×48 | 138×144 |
| 04_whey_promo_cutout.webp | 76×52 | 228×156 |
| 05_attendance_product_cutout.webp | 60×54 | 180×162 |
| 06_workout_product_cutout.webp | 60×54 | 180×162 |
| 07_payment_card_cutout.webp | 64×48 | 192×144 |
| 08_body_product_cutout.webp | 60×54 | 180×162 |
| 09_grocery_partner_cutout.webp | 44×34 | 132×102 |
| 10_recovery_banner_cutout.webp | 66×42 | 198×126 |

These are target export canvases for new derivatives; first compare them with real measured Flutter slot sizes. Transparent breathing margin is 5–8%. Display with `BoxFit.contain`.

## Next audit action

Build #723 should export a read-only ZIP of the 16 source files as a temporary GitHub Actions artifact so the visual contact sheet and edge crops can be inspected. This must not alter or replace any source file. Only after visual confirmation should the new derivatives be generated, added to PulseVault with new filenames, mapped in pubspec/manifest and checked by widget/screenshot tests.


## Owner quality correction — 2026-11-28
The earlier proposal to create padded WebP copies from existing source files is withdrawn. Those outputs are technical duplicates and were judged repetitive/low quality; they are not acceptable unique creative assets. Metadata/alpha audit does not establish visual quality or originality. Do not follow earlier derivative recommendations as a generation task. Read docs/ASSET_ORIGINALITY_AND_QUALITY_POLICY.md. New detailed imagery requires a distinct concept, repository-wide similarity review, an 8K-quality 7,680px-long-edge master (native or honestly labelled super-resolution), real alpha and 100% visual inspection. No new image is needed when an existing source is already suitable.
