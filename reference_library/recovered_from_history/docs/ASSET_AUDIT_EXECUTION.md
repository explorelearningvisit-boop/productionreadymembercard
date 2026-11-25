# BAD GYM asset audit execution checkpoint

- Branch: `grok/purple-neon-member-dashboard`
- Inbox root: `assets/material_pack/inbox/`
- The 30 individually named WebP assets have a pre-existing checkerboard contact sheet and dark-background edge review.
- The 14 files in `assets/material_pack/inbox/PulseVault/` and the additional hashed uploads at inbox root are not yet visually classified.
- `scripts/audit_asset_inbox.py` generates a deterministic contact sheet and metadata report for every PNG, WebP and JPEG under the inbox.
- Audit output is published by the dedicated `BAD GYM Asset Inbox Audit` workflow as a downloadable artifact.
- Originals are immutable during audit. Do not rename, move, delete, or overwrite files until the image-level mapping and duplicate checks are reviewed.
- After visual audit, create a source-to-semantic-name map, preserve source originals, create verified production derivatives, update Flutter asset declarations, and only then integrate into widgets.
