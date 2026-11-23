# Asset naming convention for generated files

All generated visual assets that can be committed to this repository should be placed in `assets/material_pack/inbox/` first. Keep the original export there; do not silently overwrite an earlier version.

## Required filename pattern

`YYYYMMDD_HHMMSS_IST_CONTEXT_ASSETTYPE_vNN.ext`

Examples:
- `20261123_101530_IST_MEMBER_CARD_PURPLE_GOLD_SCREEN_v01.png`
- `20261123_102015_IST_BODYBUILDER_HERO_CUTOUT_v01.webp`
- `20261123_102240_IST_DIWALI_SALE_BANNER_v02.zip`

Rules:
- Use the date and time of export in India Standard Time (IST, UTC+05:30).
- Use uppercase context words separated by underscores; describe the subject or component (e.g. MEMBER_CARD, BODYBUILDER, ATTENDANCE_RAIL, PAYMENT_QR, DIWALI_SALE).
- Include a clear asset type where useful (SCREEN, ICON_SET, BANNER, BACKGROUND, BADGE, CUTOUT, FONT_PACK, ASSET_PACK).
- Increment `v01`, `v02`, etc. for revisions. Never reuse a version number for different content.
- ZIP bundles use the same naming pattern and end in `_ASSET_PACK_vNN.zip`.
- Keep source exports and ZIPs in `inbox/`; after inspection, copy verified individual assets into their categorized folders. Keep the inbox originals until the categorized copies and app build are verified.

## Processing expectation

After an upload, inventory every file, read any included manifests, inspect contact sheets, identify duplicates and transparent edges, classify assets, and update Flutter asset declarations before integration. Do not use full-screen screenshots as app backgrounds. Do not overwrite existing production assets or fonts without explicit approval.

Never upload secrets, API keys, private member records, or real payment credentials.
