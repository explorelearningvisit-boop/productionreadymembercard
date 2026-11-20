# BAD GYM dashboard assets

The dashboard uses two optimized WebP sprite atlases generated from the supplied BAD GYM visual asset pack.

## UI sprite atlas
Path: `assets/images/badgym_ui_sprites.webp`

Atlas geometry: 5 columns × 4 rows, 28 × 28 px cells.

| Index | Asset |
|---:|---|
| 0–5 | Home, Attendance, Workout, Payment, Offers, History |
| 6–9 | Notification, Freeze, QR, Profile |
| 10–13 | Group, Trophy, Fire, Trend |
| 14–17 | Gold button, Active button, Cancel button, Purple button |

## Equipment sprite atlas
Path: `assets/images/badgym_equipment_sprites.webp`

Atlas geometry: 4 columns × 1 row, 48 × 48 px cells.

| Index | Asset |
|---:|---|
| 0 | Dumbbell |
| 1 | Kettlebell |
| 2 | Shaker bottle |
| 3 | Towel |

The sprite atlases are loaded once and individual elements are painted from source rectangles by `AssetSprite` and `EquipmentSprite` in `lib/widgets/purple_dashboard.dart`.
