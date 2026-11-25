# BAD GYM Asset Pack v3 — Verified PNG Source Pack

This folder contains 30 individual transparent PNG graphics plus a JSON manifest and visual review sheets.

## Validation
- 30 PNG files; all are RGBA and contain fully transparent pixels.
- Product cutouts are approximately 2.5K–4K pixels on their longest edge.
- UI background elements were cropped from a component sheet and upscaled to a 4096 px longest edge; they are not native 4K renders.
- `CONTACT_SHEET.jpg` and `EDGE_CHECK_DARK_BACKGROUND.jpg` are review-only images and should not be included in the app runtime.
- No full dashboard screenshot is included.

## Recommended usage
- Member hero: `01_member_bodybuilder.png`
- Sale gift: `02_red_gold_gift_box.png`
- Product promo: `03_whey_protein_tub.png`, `06_creatine_tub.png`, `28_protinex_tub.png`
- Drinkware: `04_purple_shaker.png`, `07_green_shaker.png`
- Sale/partner promotion: `05_blinkit_grocery_bag.png`, `29_sbi_payment_card_graphic.png`
- Gold member treatment: `08_gold_profile_badge_panel.png`, `10_gold_photo_backplate.png`, `21_gold_plan_badge_background.png`, `30_member_gold_profile_backplate.png`
- Navigation and status backgrounds: `11`–`14`, `16`–`19`, `22`
- Progress and actions: `15_purple_progress_bar.png`, `23_freeze_snowflake_graphic.png`, `24_qr_graphic.png`, `25_calendar_graphic.png`
- Outer frame: `26_master_neon_purple_gold_frame.png`
- Footer: `09_footer_purple_gold_wave.png` / `20_footer_purple_gold_wave.png`
- Promo tile: `27_dumbbell_promo_graphic.png`

Always use `BoxFit.contain` for isolated transparent artwork. Do not stretch transparent assets to fill a card. Keep member data, payment amounts, dates and status text as live Flutter widgets rather than baking them into images.
