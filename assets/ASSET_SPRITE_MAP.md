# BAD GYM dashboard asset status

The Flutter dashboard no longer decodes sprite atlases at runtime. `AssetSprite` and `EquipmentSprite` are currently semantic Material icon fallbacks, not PNG crops. This avoids runtime dependence on composite sheets while the approved individual asset archive is integrated.

## Existing standalone images

- `assets/images/member_hero.webp`
- `assets/images/member_portrait.png`
- `assets/images/gym_interior.webp`
- `assets/images/gym_plants.webp`

## Pending

The verified 34-file `BAD_GYM_Transparent_PNG_Assets.zip` archive is available in the development workspace but has not yet been uploaded into this repository branch. Do not mark final asset integration complete until each approved PNG is committed, visually checked, and wired into the appropriate widget.
