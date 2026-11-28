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


## Asset originality / quality gate

Before adding/changing art, read docs/ASSET_ORIGINALITY_AND_QUALITY_POLICY.md.

The earlier generated optimized derivative pack was withdrawn: it repeated existing source images in smaller WebP files and did not provide genuinely new artwork. Do not recreate it. Existing originals remain here and may be used directly where appropriate.

New detailed artwork must be unique against the whole repository. Target an 8K-quality master (7,680px long edge); record actual native dimensions and any genuine super-resolution method. Verify real alpha, subject bounds, 5–8% transparent margin, silhouette and edge quality at 100% over pearl and emerald backgrounds. Keep approved master and separately downsampled 3× runtime derivative, recording parent SHA-256. Cropping, recoloring, resizing or WebP conversion of existing source art is never described as new or unique artwork.
