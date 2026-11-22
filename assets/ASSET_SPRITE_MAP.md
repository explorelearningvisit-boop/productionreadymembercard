# BAD GYM dashboard asset status

## Runtime assets currently committed
The Flutter dashboard registers `assets/images/` in `pubspec.yaml`. The member hero image is loaded from `assets/images/member_hero.webp`; gym interior, plants, portrait and sprite-sheet files are available for later component-level use.

## Separate verified asset source pack
A separate **BADGYM Asset Pack v3** was inspected from the development workspace. It contains 26 individually named transparent RGBA PNGs, an asset manifest, a contact sheet and a dark-background edge-review sheet. Product cutouts are approximately 2.5K–4K px on their longest edge. UI background elements were cropped from a component sheet and upscaled to a 4096 px longest edge, so those particular files are not native 4K renders.

The source pack includes:
- Member bodybuilder, gift box, whey/creatine/Protinex tubs, purple/green shakers and Blinkit bag
- Gold profile panels, photo backplate, purple/white/gold/green menu backgrounds, status pills and progress bar
- Freeze snowflake, QR graphic, calendar graphic, master purple-gold frame, footer waves, dumbbell promo and SBI payment-card graphic

The source pack is packaged separately for review. Its binary PNGs are not claimed as repository-committed until they appear as actual Git blobs in this branch.

## Placeholder assets — do not use
The legacy `assets/images/individual/` directory currently contains 44 100×100 PNG placeholder filenames that all resolve to the same Git blob SHA. The manifest marks them `placeholder: true`. They are intentionally not used by the dashboard.

## Integration rules
- Keep all member values, dates, amounts, attendance states and labels as live Flutter widgets.
- Use `BoxFit.contain` for isolated transparent art; do not stretch artwork to fill cards.
- Do not use a full dashboard screenshot as the app screen.
- Before promoting any pack image into the app, verify the actual file, alpha edges, visual crop and intended component.
