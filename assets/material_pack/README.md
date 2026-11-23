# Material Pack Drop Folder

Upload the extracted design/material asset pack under this directory.

Suggested structure:
- `images/` — photos, illustrations, decorative PNG/WebP assets
- `icons/` — SVG/PNG icons
- `backgrounds/` — background textures and gradients
- `banners/` — advertising and promotional artwork
- `badges/` — membership tiers, rank and achievement badges
- `borders/` — frames, borders and card treatments
- `reference/` — visual reference sheets only (not used as full-screen UI backgrounds)

Keep original filenames where possible. Do not replace `../images/member_portrait.png` or `../fonts/` unless explicitly intended. Upload extracted files, not only a ZIP; a ZIP may be kept alongside the extracted folders as an optional source archive.

After upload, tell the maintainer the exact path(s). The Flutter asset manifest in `pubspec.yaml` must be updated for new runtime assets before they can be loaded by the app.