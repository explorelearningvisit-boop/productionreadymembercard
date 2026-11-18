# Asset Manifest

No external or unlicensed assets are included in the initial scaffold.

## Design tokens
- Primary: blush rose `#D98FA2`
- Deep rose: `#A94F6B`
- Surface: warm ivory `#FFF9F5`
- Champagne accent: `#C6A46A`
- Text: warm charcoal `#382F33`
- Success/warning/error must use accessible semantic colors and never rely on color alone.

## Export rules
- Raster: PNG, transparent only when required; provide 1x/2x/3x density variants.
- Vector: SVG for icons/illustrations when supported.
- Trim transparent padding; keep source files and record dimensions, source prompt, license and export date.
- Naming: `<feature>_<subject>_<variant>_<density>.<ext>`.
