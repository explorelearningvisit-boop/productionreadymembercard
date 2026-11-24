# BAD GYM — Final Approved Member Dashboard
## Implementation Master Prompt & Acceptance Specification

**Status:** FINAL VISUAL DIRECTION APPROVED BY PRODUCT OWNER  
**Target repository:** `explorelearningvisit-boop/productionreadymembercard`  
**Target branch:** `grok/purple-neon-member-dashboard`  
**Reference image target:** `design/reference/BADGYM_Final_Approved_Dashboard_Reference.jpg` (generated image supplied in this conversation; binary repository upload remains pending)  
**Implementation status:** Approved specification; implementation has started in the existing Flutter dashboard. See `docs/PIXEL_PERFECT_REBUILD_PLAN.md` for the evidence-based checkpoint. The generated reference image still needs to be committed as a repository binary asset.

---

## 1. Mission and source-of-truth rules

Rebuild the existing BAD GYM member dashboard in Flutter to match the approved reference image as closely as practical. This is an implementation of the existing dashboard, not a new unrelated screen, not a tablet mockup, and not a generic redesign.

The approved reference screenshot is the primary visual authority for:
- overall portrait composition and information hierarchy;
- purple / violet / electric-blue visual language with bright yellow-gold accents;
- red payment-due warning treatment;
- metric-card arrangement and graphic emphasis;
- member identity block, membership status, progress bar;
- left vertical analytics navigation rail and right analytics content panel;
- compact spacing, alignment, proportions, borders, gradients, and glow.

Existing repository code and data models remain the source of truth for app behavior and integration points. Preserve working features. Do not silently replace real functionality with static mockups. Where live APIs do not exist, retain explicit sample-data labels and document the integration boundary.

Never claim pixel-perfect completion based only on a successful compile. Require screenshots, geometry checks, widget tests, and a documented visual comparison.

## 2. Device and layout constraints

- Primary target: Android phone, logical width 360 dp.
- Reference is a tall portrait phone screenshot, not a tablet or desktop layout.
- Validate at 360 dp first, then 320 dp (narrow regression) and 390 dp (wide phone).
- Support variable device height and system insets; do not hard-code a single screen height.
- Keep the main dashboard compact and vertically efficient. Do not scale the entire UI down with a global FittedBox just to fit the screen.
- Avoid unnecessary outer padding, oversized gaps, duplicated margins, and excessive card gutters.
- Preserve readable text and touch targets; compactness must not make controls inaccessible.
- Use a deliberate spacing scale (suggested 4 dp base): 4, 6, 8, 10, 12, 16 dp. Use the smallest spacing that preserves clear grouping.
- Align card edges, text baselines, icon centers, badges, progress bars, and image bounds to a consistent grid.
- Avoid horizontal overflow and accidental clipping. Scroll only the content region that genuinely needs it; do not make the whole dashboard feel like a long web page.
- Respect status/navigation/system safe areas and the phone's real usable viewport.

## 3. Visual identity and design tokens

Create centralized Flutter design tokens (e.g. `BadGymColors`, `BadGymSpacing`, `BadGymRadii`, `BadGymShadows`, `BadGymTypography`). Do not scatter arbitrary color and padding literals throughout widgets.

### Palette (starting targets; tune by sampling the approved reference)
- Deep aubergine / base purple: approximately #26004F to #35006B.
- Primary vivid violet: approximately #7414D5 to #8B20E8.
- Electric purple highlight: approximately #B64CFF.
- Deep indigo-blue: approximately #152A8E / #2545C8 for cool accents.
- Gold / yellow: approximately #FFC928 / #FFE45C.
- Success green: approximately #12C96B / #19D978.
- Alert red: approximately #E5092F / #F21D35.
- White / cool lavender surfaces: #FFFFFF, #F8F2FF, #F0E6FF.
- Main text: deep purple on light surfaces; white on deep purple surfaces.
- Secondary text: muted plum / lavender-grey, with sufficient contrast.

### Surfaces
- Main dashboard shell: continuous dark-purple-to-violet gradient, enclosed by a thin warm-gold outer stroke and a restrained purple glow.
- Profile/member hero: integrate into the same continuous purple surface; do not create a disconnected white patch at the right or bottom edge.
- Inner content cards: rounded corners, controlled gradients, thin light/gold/violet strokes.
- Analytics panel: pale lavender/near-white interior for readable charts and calendar.
- Use subtle glass / gloss effects sparingly. The reference is vivid and premium, not a flat material UI.
- Glow must reinforce hierarchy, not blur text or reduce contrast.
- Avoid random square texture artifacts. If a soft geometric background texture is used, implement it programmatically with a low-opacity painter/decoration, clipped to the correct card, consistent with the reference. Do not fake this with screenshots of the whole UI.

### Shape language
- Rounded cards and pill badges; consistent corner radius families (roughly 16–24 dp for major cards, 10–16 dp for small chips).
- Thin, crisp borders. Outer frame and inner card borders must remain visually continuous and aligned.
- Shadows/glows should have controlled blur and spread; avoid muddy double shadows.

## 4. Typography and iconography

- Use one consistent display/body font family across the dashboard. Prefer the font already bundled in the repository if it matches the reference; otherwise use a licensed, bundled geometric sans (e.g. a suitable Poppins-like family). Do not rely on an unbundled device font.
- Strong, bold display face for member name, primary metric values, and section title.
- Medium/semibold for labels and metadata.
- Keep numeric typography tabular where possible so values align.
- Use a consistent type scale, responsive only where necessary: large metric value, medium card heading, compact supporting label, tiny metadata. Never shrink all text indiscriminately.
- Icons must use a consistent family and stroke/weight. Use Material Symbols or the existing project icon system; do not mix unrelated emoji, outline packs, and filled icons.
- Align icon optical center with text baseline. Icon size and gap should be tokenized.
- Keep labels readable; ellipsize only secondary labels and never truncate essential values without a tooltip/accessibility label.

## 5. Dashboard composition — exact hierarchy

### A. Top action strip
Two equal-width horizontal action cards:
1. **CHECK-IN**: green circular success/check icon, label, time (e.g. 07:12 AM), small fitness illustration at right. Purple gradient surface with gold/lavender border.
2. **FREEZE**: snowflake icon, title, short helper line, red discount pill, shaker/bottle illustration at right. Light cool surface with violet/gold edge.
Both cards share the same height, inner padding, baseline alignment, and image scale. Keep the top gap to the profile hero tight.

### B. Member hero / identity
- One large continuous member card visually integrated with the outer dashboard shell.
- Left: square/rounded avatar artwork in a gold frame with a subtle shadow.
- Right: member name (Ashwani Kumar Singh in reference), then compact metadata row: member ID, age, gender, each with a consistent small icon and separators.
- Below metadata: Gold Plan pill and Active status pill, equal visual height and aligned on one row.
- Keep name readable at 360 dp; use a deliberate one-line fit or two-line fallback, not arbitrary scaling.
- Outer purple/blue color fill must stay inside the member card's border. No white/blue seam or color discontinuity where the right edge meets the outer frame.
- The member hero and top frame should read as one coherent composition, not two unrelated stacked rectangles.

### C. Payment and promotion row
Two side-by-side cards with matched height:
1. **PAYMENT DUE** warning card:
   - full red / crimson background (not just red text);
   - white wallet/payment icon inside a pale circular surface;
   - visible warning triangle;
   - label and amount (e.g. ₹500 Due) in white/high-contrast red-aware typography;
   - days-left helper text.
   - The payment due state must also use red warning treatment in the membership/progress area and in the Payment metric card.
2. Whey promotion card:
   - deep purple/violet gradient;
   - whey tub transparent graphic;
   - concise promotion headline and discount;
   - clear Buy Now pill.
Maintain matched card heights and aligned vertical centers. Never let the red warning bleed outside its card.

### D. Membership progress
- Title/value row: “Membership 22 / 30 Days”, warning pill “8 Days Left”, and percentage “73%”.
- Progress bar immediately below, with a clearly visible green filled segment (22/30 ≈ 73.3%) and pale lavender remainder.
- Progress bar should use almost the full inner card width. Do not leave large side margins or excessive top/bottom padding.
- Track height should be visibly substantial but compact (approximately 10–14 dp, tune by reference).
- Fill must be clipped to the rounded track, with no empty/white rendering bug.
- Use a semantic progress indicator and expose value to accessibility.
- If membership is near expiry or payment is due, show a clear red alert pill; do not rely on color alone.

### E. Four compact metric / promotion cards
A single four-column row:
1. **Attendance**: yellow/gold surface, calendar icon, attendance percentage, fitness character graphic, bottom offer chip.
2. **Workout**: lavender/purple surface, dumbbell icon, “58 min” primary value, “↑ +12%” progress indicator.
3. **Payment**: cool cyan/blue surface, wallet/card icon, “₹500 Due” with red alert styling, offer chip and payment-card graphic.
4. **Body**: mint/green surface, body icon, “69.5 kg” primary value, “↓ −0.8 kg” change indicator, fitness product graphic, offer chip.

**Critical space-reallocation rule:**
- Do not reserve a separate full-width row or tall badge for “+12%” or “−0.8 kg”.
- Place Workout’s “↑ +12%” compactly beside the “58 min” value or adjacent to the Workout heading/icon, whichever aligns best at 360 dp.
- Place Body’s “↓ −0.8 kg” beside “69.5 kg” or adjacent to the Body heading/icon.
- The change indicators must remain legible, but their vertical footprint should be minimized.
- Reclaim the freed vertical space for the artwork: enlarge each card's transparent product/fitness graphic in both width and height.
- Graphics should use the available inner width; do not leave arbitrary left/right gutters. Preserve a safe inset so artwork does not touch borders or overlap text.
- Artwork should be centered, visually dominant, and consistent in perceived scale across cards. Different source aspect ratios may require per-asset BoxFit.contain / carefully chosen crop.
- Do not distort images. Do not use a global FittedBox to scale card contents.
- Keep four cards equal width and height, with equal gutters and aligned top/bottom edges.
- At 320 dp, gracefully reduce label density or image height without losing the metric. Do not overflow.

### F. Analytics area — left rail + content panel
- One unified rounded container beneath the metric row.
- Left vertical navigation rail with six destinations: Attend, Insights, Cal, History, Trend, Goals.
- Rail uses deep purple/violet gradient, white icons/labels, and a gold/light active-state tile for selected destination.
- Main analytics content sits immediately to the right, with aligned top and bottom boundaries.
- Rail width is compact but usable; content panel receives the majority of width.
- Do not allow the analytics panel's white/lavender surface to break the outer purple shell.

### G. Analytics content
- Header: selected section icon, title (e.g. Attendance Analytics), notification/bell icon, LIVE pill.
- Advertisement/promo strip with small transparent artwork and concise copy; clearly distinguish it from actual analytics.
- Attendance summary:
  - circular progress ring (e.g. 81%, 25/31);
  - status legend and horizontal bars for Present, Absent, Holiday, Late;
  - values and percentages aligned in consistent columns.
- Small insight row: streak, milestone, improvement indicators, with consistent icon/text alignment.
- Sample-data notice must be visible when live API data is not connected.
- Recovery Combo promotional strip.
- Month attendance heading, short status summary, and Train More offer.
- Calendar: weekday labels and compact date cells; distinct states for present, late, absent, holiday/off, and selected day. Use accessible labels and non-color cues (OFF, selected border, icons/text) where appropriate.
- Avoid tiny unreadable text. If content cannot fit, scroll only inside the analytics content panel and keep the navigation rail stable.
- Do not invent live values or claim live data if the screen is still using sample data.

## 6. Artwork and asset handling

- Prefer transparent PNG/WebP illustrations for the character, supplement tubs, bank card, shaker, and promo artwork.
- Use the repository's existing asset pack only after inspecting the actual pixels, dimensions, transparency, crop bounds, and visual identity.
- Do not assume a hashed PNG's semantic role from its filename.
- Preserve original source assets; create optimized derivatives separately and document source-to-derivative mapping in an asset manifest.
- Where no suitable source graphic exists, create a programmatic vector/gradient/shape treatment or request/produce a dedicated transparent asset. Do not use a full-screen screenshot as a widget background.
- Use `BoxFit.contain` by default for product artwork; use crop only when the reference clearly crops the subject.
- All artwork must be clipped to its own card and must not cover labels, values, or controls.
- Record dimensions, alpha bounds, file size, and SHA-256 for every approved asset.

## 7. Motion and interaction specification

Motion should make the interface feel premium without causing distraction or frame drops.
- Use short, purposeful transitions: approximately 160–240 ms for card/state changes; 220–320 ms for section changes where appropriate.
- Use easeOutCubic / easeInOutCubic or equivalent Flutter curves.
- Check-in: success state may animate once (subtle scale/check reveal), not loop indefinitely.
- Freeze: press feedback and state transition; no continuous spinning snowflake.
- Payment alert: static warning state; optional one-time subtle emphasis only, never aggressive pulsing.
- Membership progress: animate fill from 0 to target on first meaningful entry, then remain stable; avoid restarting on every rebuild.
- Metric artwork: optional gentle entrance/hover-like parallax only if performance-safe; no constant bobbing that reduces readability.
- Analytics section changes: use a short fade/slide or size transition; honor `MediaQuery.disableAnimationsOf(context)`.
- Promotional shine: finite/low-frequency and reduced-motion aware; do not run perpetual high-cost shaders.
- All animation controllers must be disposed. Avoid rebuilding the entire dashboard for a small animated child.
- Respect Android system reduced-motion settings; disable or simplify motion when requested.
- Maintain 60 fps target on typical mid-range devices; profile on a real low/mid Android device before claiming performance verified.

## 8. Functional behavior and data integrity

- Preserve existing check-in, freeze/resume, navigation, payment, and member interaction contracts where they already exist.
- Do not invent API endpoints or backend schemas.
- Keep sample data clearly labeled until a real data source is wired.
- Payment due is a warning presentation; do not imply a payment was processed.
- Workout/body change indicators must be derived from real data when available; otherwise mark sample values.
- Use semantic buttons, progress semantics, accessible names, and appropriate contrast.
- Avoid tap targets smaller than 44–48 dp where practical; if compact visuals require smaller icons, keep the surrounding hit area large.
- Add tests for state transitions and data formatting, not just screenshot rendering.

## 9. Flutter architecture and implementation approach

- Work within the existing Flutter project and existing `MemberDashboardScreen` and relevant widgets. Do not replace the app with a static image or a parallel mock screen.
- Extract reusable components only where they improve consistency: action tile, member hero, payment alert, promo tile, membership progress, metric card, analytics rail, analytics panel, calendar cell.
- Centralize design tokens.
- Prefer `LayoutBuilder`, `ConstrainedBox`, `Expanded/Flexible`, and intentional scroll regions over fixed device-specific dimensions.
- Use `AspectRatio` for artwork where appropriate.
- Use `CustomPainter` for subtle background texture, progress ring, and custom decorative effects only when simpler Flutter widgets are insufficient.
- Keep code modular, null-safe, testable, and lint-clean.
- Avoid gratuitous dependency additions. Reuse current project dependencies unless a clear technical need is documented.

## 10. Mandatory implementation stages (do not skip or combine)

**Stage 0 — Baseline and source audit**
- Inspect current branch, widget tree, tests, asset folders, theme, and current CI state.
- Record baseline screenshots and existing failures.
- Confirm approved reference image is present in repo.
- Do not alter unrelated screens.

**Stage 1 — Reference and asset forensics**
- Create reference dimensions and layout map.
- Decode every candidate asset; create contact sheet and metadata/alpha report.
- Map only visually verified assets.
- Add an asset manifest with source path, role, dimensions, alpha bounds, and checksum.
- Gate: no asset mapping by filename guess.

**Stage 2 — Design tokens and frame geometry**
- Implement palette, typography, spacing, radii, shadows, border and glow tokens.
- Rebuild continuous outer shell and member hero geometry.
- Verify 360 dp screenshot before moving on.

**Stage 3 — Top actions and member hero**
- Implement check-in/freeze row, avatar, member details, plan and status.
- Verify baseline alignment and no overflow at 320/360/390 dp.

**Stage 4 — Payment and membership**
- Implement full red payment warning card and consistent warning state.
- Implement filled membership progress and compact margins.
- Test 22/30 progress value and visual fill.

**Stage 5 — Metric cards and artwork sizing**
- Implement compact Workout +12% and Body −0.8 kg inline indicators.
- Reallocate freed height to artwork.
- Increase artwork width to use available inner card width with safe margins.
- Verify all four cards at 320/360/390 dp.

**Stage 6 — Analytics rail and content**
- Align six navigation items and content panel.
- Implement charts, sample-data notices, promo strip and calendar.
- Verify rail stays stable while content changes.

**Stage 7 — Motion, interaction and accessibility**
- Implement reduced-motion-aware transitions.
- Audit touch targets, semantic labels, contrast, keyboard/screen-reader behavior where applicable.
- Profile heavy animations.

**Stage 8 — Visual QA and correction loop**
- Capture real Flutter screenshots at 320, 360 and 390 dp using deterministic test data.
- Compare against approved reference for geometry, typography, color, spacing, image scale and clipping.
- Fix the largest visual mismatches first.
- Repeat until the acceptance checklist passes or remaining deviations are explicitly documented.
- Do not substitute a generated concept image for a Flutter screenshot.

**Stage 9 — Release verification**
- Run formatter, analyzer, unit/widget/integration tests, release build.
- Install and launch APK on a real Android device if device access is available.
- Report exact commit SHA, CI run, artifact URL, checksum, and any unverified device checks.
- Never claim real-device validation if it was not performed.

## 11. Visual acceptance checklist

- [ ] At 360 dp, the full composition follows the approved portrait hierarchy.
- [ ] Purple/blue fill stays inside the continuous member/outer frame; no white seam on right/bottom.
- [ ] Gold border and purple glow are consistent and do not create square artifacts.
- [ ] Member name, metadata, Gold Plan and Active align to one grid.
- [ ] Payment Due card is fully red with clear warning icon and readable white text.
- [ ] Membership 22/30 has a visibly filled green bar at approximately 73%.
- [ ] Progress bar has minimal balanced side padding.
- [ ] Workout +12% is inline/compact with 58 min; Body −0.8 kg is inline/compact with 69.5 kg.
- [ ] Metric artwork uses reclaimed vertical space and visibly larger width/height.
- [ ] Metric cards have equal dimensions and consistent internal alignment.
- [ ] Analytics rail and panel are one aligned rounded structure.
- [ ] No accidental overflow, clipping, text collisions, or tiny unreadable labels.
- [ ] 320 dp and 390 dp layouts remain usable.
- [ ] Reduced-motion setting is respected.
- [ ] All sample data remains clearly identified.
- [ ] Screenshots are from the actual Flutter build, not an image mockup.

## 12. Required deliverables

1. Approved reference image committed in the repository.
2. This master prompt/spec committed alongside it.
3. Asset audit report and verified manifest.
4. Flutter implementation in existing dashboard files.
5. Updated widget tests and deterministic screenshot tests.
6. Before/after screenshots at 320, 360 and 390 dp.
7. CI run and release APK artifact.
8. Completion report separating: implemented, tested in CI, visually verified, and real-device verified.

## 13. Non-negotiable working rules

- Do not start implementation until the product owner explicitly says to start using this approved prompt.
- Until then, only store and refine the specification/reference; do not change dashboard Dart files.
- When implementation starts, work stage-by-stage in order, with a commit and verification after each meaningful stage.
- Do not ask the product owner to repeat requirements already present here.
- Do not claim a stage is complete without code diff and fresh test/screenshot evidence.
- Never claim the dashboard is pixel-perfect if it has only compiled successfully.
- Keep the target phone-first. Do not generate tablet layouts.
