# PulseVault — authoritative 14-image dashboard pack

This directory contains the 14 approved images moved byte-for-byte from `assets/material_pack/inbox/PulseVault/`. The hashed source filenames were replaced with semantic names; each PNG blob is unchanged.

## Asset map
| File | Visual role |
|---|---|
| `01_whey_protein_tub_cutout.png` | whey protein tub.png |
| `02_whey_protein_bundle_cutout.png` | whey protein bundle.png |
| `03_purple_protein_product_bundle_cutout.png` | purple protein product bundle.png |
| `04_fat_loss_support_tub_cutout.png` | fat loss support tub.png |
| `05_purple_gold_cta_background.png` | purple gold cta.png |
| `06_whey_recovery_tub_cutout.png` | whey recovery tub.png |
| `07_creatine_monohydrate_tub_cutout.png` | creatine monohydrate tub.png |
| `08_purple_shaker_bottle_full_canvas.png` | purple shaker bottle.png |
| `09_member_dashboard_reference.png` | member dashboard reference.png |
| `10_member_bodybuilder_cutout.png` | member bodybuilder.png |
| `11_sbi_payment_card_cutout.png` | sbi payment card.png |
| `12_purple_neon_cta_background.png` | purple neon cta.png |
| `13_blinkit_grocery_bag_cutout.png` | blinkit grocery bag.png |
| `14_lavender_glass_cta_background.png` | lavender glass cta.png |
| `09_member_dashboard_reference.png` | Visual reference only; never use a full-screen screenshot as a runtime background |

`08_purple_shaker_bottle_cutout.png` is the checkerboard-background-removed transparent shaker cutout, cropped to its subject bounds. Use `BoxFit.contain` for isolated transparent cutouts. Keep labels, prices, member details, and controls as live Flutter widgets. Preserve source aspect ratios and avoid cropping transparent edges.
