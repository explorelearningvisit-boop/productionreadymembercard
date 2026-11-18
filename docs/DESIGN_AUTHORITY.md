# Design Authority — Clean-slate rebuild

## Retired material
- Retire the earlier crimson/metallic-gold/pearl-white implementation based on reference `1000320298.png`.
- Its derived member crop `assets/images/member_ashwani.webp` was deleted from the active source tree.
- Do not re-import the old `bad_gym_complete_visual_asset_pack_v1.zip` as the new design system.
- Do not resurrect the previous purple/glass/neumorphism experiments as the production master.

## Current authority
- User's final approved first/red dashboard image from 17 November 2026 is the master.
- The second and third images were also liked; the fourth pale design was rejected.
- The master image itself must be supplied/located before pixel-accurate UI recreation; do not guess which of the recent theme variants is the first/red master.
- The 360dp mobile layout remains the target.
- Keep member card, vertical rail and horizontal menu on one identical theme.
- Information workspaces use the approved light white/lavender/yellow/green surfaces where shown by the master.

## Asset policy
- Only use the recent approved asset/theme pack that corresponds to the master image.
- Use static transparent PNGs only for decorative/illustrative material.
- Build text, controls, charts, calendar states, progress indicators and QR components natively in Flutter.
- Do not use a whole screenshot as a live screen background or rasterize dynamic UI.
- Do not generate duplicate images or create repeated visual variants unless the user asks.

## Current implementation state
- Active main branch has been reset to a neutral Flutter shell.
- No old reference-derived image asset is registered in `pubspec.yaml`.
- The exact first/red master image and its corresponding latest asset pack still need to be identified in the available source material before UI reconstruction.
