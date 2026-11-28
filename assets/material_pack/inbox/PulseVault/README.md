# PulseVault — BAD GYM member dashboard assets

This is the canonical runtime asset directory for the member-card/dashboard UI.

- The 16 source graphics are shared Git blobs with the original `assets/member_card/` source directory; no duplicate binary payload was added to Git history.
- Existing WebP artwork remains WebP to preserve transparency and reduce Android bundle size. The Fat Loss support source remains PNG for now.
- UI code and `pubspec.yaml` should reference this directory for new dashboard work.
- Do not bake interface text, menu labels, prices, status values or advertiser claims into artwork. Keep these as Flutter text/data so they remain readable and localizable.
- Advert creatives must be campaign-consistent: image, offer copy and action rotate as one item. Placeholder brands/discounts must be marked as sample until a real campaign is configured.
- The source copy in `assets/member_card/` is intentionally retained as an archive until the runtime migration has passed CI.

## Asset inventory

- `01_member_bodybuilder.webp`
- `03_whey_protein_tub.webp`
- `04_purple_shaker.webp`
- `05_blinkit_grocery_bag.webp`
- `06_creatine_tub.webp`
- `08_gold_profile_badge_panel.webp`
- `10_gold_photo_backplate.webp`
- `15_purple_progress_bar.webp`
- `21_gold_plan_badge_background.webp`
- `22_green_active_badge_background.webp`
- `23_freeze_snowflake_graphic.webp`
- `25_calendar_graphic.webp`
- `27_dumbbell_promo_graphic.webp`
- `28_protinex_tub.webp`
- `29_sbi_payment_card_graphic.webp`
- `fat_loss_support_tub.png`


## Emerald Pearl optimized cut-outs

The original 16 PulseVault images remain unchanged. Nine padded WebP cut-outs are created in `optimized/` by `tools/build_pulsevault_emerald_derivatives.py`. The dedicated GitHub asset workflow commits this generated binary directory after inspection; Android build CI also regenerates and audits it before `flutter pub get`.

- Every derivative is reopened after export and checked for true alpha (range 0–255), expected pixel dimensions, SHA-256 and subject bounding box.
- A minimum 5% transparent margin is enforced on all four edges (target 6.7%).
- Fat Loss source art is almost opaque despite its alpha channel; OpenCV GrabCut isolates the product before creating its transparent derivative.
- UI uses `BoxFit.contain`; no stretch or fake checkerboard transparency.
- Source images are never overwritten or removed.
