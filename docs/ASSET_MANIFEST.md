# PulseVault asset manifest

Audit checkpoint: 2026-11-23
Repository branch: `grok/purple-neon-member-dashboard`

## Processing rules
- Preserve every uploaded PNG byte-for-byte in `assets/material_pack/inbox/PulseVault/`.
- Do not rename a hashed source until its visual content has been inspected.
- Record source path, semantic role, pixel dimensions, alpha bounds, crop, output dimensions, output format and destination for each derivative.
- Do not invent dimensions or infer image identity from upload order.
- Use contain for transparent product renders unless the screenshot demonstrates a crop; use cover only for photographic surfaces with measured focal alignment.

## Known semantic assets already in the app
| Path | Current semantic role | Status |
|---|---|---|
| `assets/material_pack/images/01_member_bodybuilder.webp` | Member portrait | Existing app asset; crop needs screenshot comparison |
| `assets/material_pack/membership/10_gold_photo_backplate.webp` | Portrait frame/backplate | Existing app asset |
| `assets/material_pack/offers-promotions/03_whey_protein_tub.webp` | Whey product render | Existing; now assigned to Attendance KPI and promo banner |
| `assets/material_pack/offers-promotions/04_purple_shaker.webp` | Purple shaker | Existing; role/crop to verify against reference |
| `assets/material_pack/offers-promotions/05_blinkit_grocery_bag.webp` | Blinkit promotion art | Existing; analytics ad placement to verify |
| `assets/material_pack/offers-promotions/06_creatine_tub.webp` | Creatine product render | Existing; now assigned to Workout KPI |
| `assets/material_pack/offers-promotions/07_green_shaker.webp` | Green shaker | Existing; not assumed to be Fat Loss product |
| `assets/material_pack/offers-promotions/28_protinex_tub.webp` | Protinex product render | Existing; intended role not confirmed |
| `assets/material_pack/payment/29_sbi_payment_card_graphic.webp` | SBI payment card | Existing; assigned to Payment KPI |
| `assets/material_pack/attendance/25_calendar_graphic.webp` | Calendar graphic | Existing; no longer used as Attendance KPI artwork |
| `assets/material_pack/advertisements/27_dumbbell_promo_graphic.webp` | Dumbbell promotion | Existing; not used as Workout KPI artwork |
| `assets/material_pack/attendance/23_freeze_snowflake_graphic.webp` | Freeze/snowflake art | Existing; freeze card mapping to verify |

## Uploaded PulseVault PNG inventory
GitHub directory listing confirms 14 PNG source files. GitHub's current file-fetch connector returns an empty payload for binary files even when base64 encoding is requested; visual pixels and PNG metadata therefore cannot be inspected through that route. No hashed file has been renamed or assigned a visual role.

| Source filename | GitHub listed size (bytes) | Visual identity / dimensions / alpha / crop |
|---|---:|---|
| `file_00000000063482088fa83a658c26ddbf.png` | 1,202,767 | Pending binary visual inspection |
| `file_0000000014f88211afbef9f12974de01.png` | 2,259,154 | Pending binary visual inspection |
| `file_00000000261c82088654a17184ff32d2.png` | 2,384,424 | Pending binary visual inspection |
| `file_000000003a108208906c96b9d94cc18c.png` | 2,077,063 | Pending binary visual inspection |
| `file_000000007efc8208af28f392dc5b37cb.png` | 2,051,232 | Pending binary visual inspection |
| `file_0000000094ec8208b9c5c483a78574ed.png` | 2,148,137 | Pending binary visual inspection |
| `file_00000000952c8208b62a6b5506019f48.png` | 2,071,954 | Pending binary visual inspection |
| `file_00000000a2688208951066ca71d37323.png` | 2,261,377 | Pending binary visual inspection |
| `file_00000000bd848208b03817c2a62e1179.png` | 1,974,859 | Pending binary visual inspection |
| `file_00000000c5c08208afc6ad93ac1b123b.png` | 1,485,382 | Pending binary visual inspection |
| `file_00000000cb508208bd54389d6926b40b.png` | 1,919,647 | Pending binary visual inspection |
| `file_00000000cfb482088d3f2d93ccc42527.png` | 1,775,970 | Pending binary visual inspection |
| `file_00000000f0888208b54723433707ba5b.png` | 2,245,380 | Pending binary visual inspection |
| `file_00000000f38082468a3a6fe2b178ca0a.png` | 1,758,849 | Pending binary visual inspection |

## Stage 1 gate
Not passed. Required evidence: decoded source images, contact sheet, dimensions/alpha report, confirmed screenshot-to-asset mapping and derivative checksums. Until then, the PNGs remain untouched in the inbox.
