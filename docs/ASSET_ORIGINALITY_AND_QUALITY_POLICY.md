# BAD GYM — Asset Originality & Quality Policy
Version 1.0 · Owner-mandated · Effective 2026-11-28

Mandatory for every AI agent, developer, designer and automated workflow in this repository. Read before searching for, generating, editing, upscaling, exporting or uploading any visual asset.

## 1. No duplicate assets or fake asset packs
- Never copy an existing GitHub/PulseVault image, crop, recolor, resize or re-encode it as WebP/PNG, change its filename and claim it is a new or unique generated asset.
- Format conversion, resize, crop, background removal and padding are technical derivatives, not new creative artwork. Never describe them as original/unique.
- Do not create multiple near-identical versions to inflate an asset pack. If an existing asset fills a role and passes quality checks, reuse the original file directly.
- Do not regenerate artwork merely to replace an existing file with a lower-quality copy. No repetitive packs, unnecessary generation or wasted compute.
- Never overwrite/delete source artwork without review and a validated replacement.

## 2. Originality check before generation
1. Inventory all relevant image files across the repository, not only PulseVault; include aliases/shared blobs and archived asset directories.
2. Build a contact sheet and compare subject, composition, camera angle, pose, colorway, lighting, crop and intended placement.
3. Check exact SHA-256 and perceptual similarity (pHash/dHash or equivalent). Hashes are automated signals only; visual review is mandatory because edits/crops/recolors can evade hashes.
4. Write a visual-gap statement describing what the dashboard needs that no existing repository image provides.
5. Define a genuinely distinct concept. If no meaningful gap exists, generate nothing.
6. Record concept, provenance, prompt, intended slot and why it is not a duplicate in the manifest.

## 3. 8K-quality master requirement
- When a new photographic/3D hero, portrait, product cut-out or detailed campaign image is genuinely required, target an 8K-quality master with a 7,680-pixel long edge (or higher where aspect ratio requires it), real detail and true transparency where needed.
- The master must be detailed at 100% inspection. Merely changing metadata/canvas dimensions or doing a simple low-resolution resize does not make an image 8K quality.
- If the generator cannot produce requested native resolution, record actual native size and use genuine super-resolution. Label “upscaled 8K master”, never “native 8K”. Never claim 8K if detail is absent or upscaling introduces artifacts.
- Preserve the approved high-quality master in source/archive storage. Create runtime derivative only after master approval.
- Small icons, progress bars, badges, separators and simple illustrations should generally be native Flutter/vector shapes, not 8K rasters.

## 4. True transparency and silhouette checks
- Cut-outs must be PNG RGBA or WebP with a real alpha channel. Checkerboard, white/green/purple matte or transparency-looking texture is not alpha.
- Reopen exported image and verify alpha extrema include 0 and visible pixels (normally max 255); report alpha bbox, transparent pixel percentage and four edge margins.
- Use 5–8% transparent breathing room on each edge unless approved composition requires otherwise.
- Inspect hair, fingers, shoulders, product caps, bottle bases, card corners and all silhouette edges at 100%. No accidental crop, halo, fringe, holes, jagged segmentation or background remnants.
- Inspect over both pearl-light and emerald-dark backgrounds. Alpha metadata alone is insufficient.
- A non-transparent scene intentionally used as full card/banner art must be labelled opaque composition, never transparent cut-out.

## 5. Quality, provenance and manifest
Every new master/runtime derivative must record:
- unique asset ID, filename, description and target placement;
- why visually distinct from existing relevant assets;
- provenance/model/tool, exact prompt or source licence;
- native resolution, any upscale method, bit depth and format;
- SHA-256; parent-master SHA for runtime derivative;
- alpha extrema, subject bbox, four transparent margins and transparency percentage;
- visual QA over light/dark backgrounds, crop/silhouette and artifact review;
- runtime slot in dp and export dimensions.

Inspect at 100%, not only a small phone preview. Reject blur, smudged detail, duplicate composition, edge halos, pseudo-text, incorrect logos, jagged cut-outs, matte remnants and oversharpening.

## 6. Runtime export is not the creative master
- Keep approved high-quality master; downsample from it to approximately 3× the measured Flutter slot for the app. Runtime files should be crisp at device scale without bloating APK with 8K masters.
- Runtime derivatives may change size/format/compression only after master approval. They record parent-master SHA and remain labelled technical derivatives.
- Never upscale a poor PulseVault source and pretend its detail improved.
- Use BoxFit.contain for isolated art; no stretch/BoxFit.fill. Keep UI text/prices in Flutter.

## 7. Workflow gates
- No automated workflow may mass-generate, re-encode, commit or overwrite assets without originality review.
- Generation is explicit and purpose-specific. Stop if source assets already cover the role.
- Before commit compare against full relevant asset library, run metadata/alpha checks, produce contact sheet/100% crops, record provenance/quality, and inspect Git diff.
- Unverified requirements must be marked unverified; do not call asset production-ready.
- This policy supersedes prior scripts/instructions that padded, recolored or resized existing PulseVault artwork into derivative packs and called them new assets.

## 8. Current repository decision
- Existing PulseVault artwork is owner-provided source art. Reuse originals directly only where visually appropriate and quality passes.
- Earlier derivative generator and auto-commit workflow are withdrawn because they produced copies of existing art, not unique creative artwork.
- Do not reference PulseVault/optimized from Flutter unless a separately approved master creates a quality-verified runtime derivative and the binary is committed.
- Do not create replacement art until a real visual gap is recorded. New art must add a distinct design contribution.
