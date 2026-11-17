# BAD GYM — Ten Independent Dashboard Theme Systems

**Status:** ACTIVE IMPLEMENTATION — 2026-11-17  
**Authority:** The ten dashboard screenshots uploaded by the user on 2026-11-17. This specification supersedes the earlier single-Gold unification decision for this isolated Design Lab branch.

## Product decision

The ten references are ten distinct dashboard visual systems, not ten palette presets for a single locked visual design. Deliver all ten inside one Flutter application. The user selects a theme from the in-app theme gallery; the selected theme changes the complete presentation system while preserving the same member identity, data model, navigation state, QR, calendar semantics and feature interactions.

## Reference-to-theme catalogue

| # | Theme | Visual language | Main treatments |
|---|---|---|---|
| 1 | Ice Glass | Ice-blue / white crystal glass | Frosted translucent cards, blue edge light, rounded glass panels |
| 2 | Crimson Gold | Deep crimson and gold luxury | Rich red canvas, gold outlines, glossy premium badges |
| 3 | Festival Yellow | Yellow festival / red | Sunshine canvas, warm ivory panels, gold highlights and crimson emphasis |
| 4 | Sky Pearl | Pale blue pearl / white | Soft blue gradients, white pearl surfaces, rounded 3D depth |
| 5 | Athletic Red | White / concrete / racing red | Sharper geometry, red athletic accents, charcoal typography |
| 6 | Emerald Pulse | Pearl / emerald / neon green | Light green canvas, emerald selection, lime progress and glow |
| 7 | Royal Ruby | Ruby red / champagne gold | Dark ruby panels, gold borders, premium contrast |
| 8 | Gold Festival | Warm gold / ivory / crimson | Golden background, ivory panels, red action accents and festive ornament |
| 9 | Obsidian Neon | Carbon / black / neon lime | Dark carbon surfaces, neon-lime outlines and high-contrast metrics |
| 10 | Minimal Red | Clean white / sharp red | Flat white surfaces, fine grey borders, restrained red geometry |

## Shared functional architecture

- One Flutter application, one member model and one set of interactions; no duplicate apps or theme-specific data stores.
- Brand header: BAD GYM, Member Intelligence, search, notifications, QR and theme gallery.
- Member context: avatar, checked-in state and timestamp, member ID/name/age/gender, active and Gold Plan badges, QR, membership progress, payment due and expiry countdown.
- Four quick workspaces in fixed order: Attendance, Workout, Payment, Body.
- Bounded contextual rail below quick workspaces. Selecting a rail destination replaces the content in place; never stack more widgets vertically.
- Attendance: current-month calendar, Trend, History, Insights and Goal. Green = present, amber = late, red = absent, grey/neutral = Sunday OFF and holiday. Calendar labels and dates remain native widgets.
- Workout: overview and trend/program/history destinations, using only available demo values and existing dumbbell artwork.
- Payment: outstanding amount, due date, early-pay information, transactions/rewards destinations. Payment collection is not active in this demo.
- Body: current weight and change, composition/measurement/progress destinations. Do not invent medical values or imply live health integration.
- Member data and navigation remain stable when the user changes theme.

## Layout and device rules

- Primary target: 360dp logical width; also test 320dp minimum and Xiaomi 11i 5G at 1080×2400 physical pixels / 2.75x density (approximately 393×873dp).
- Use the usable viewport between Android status and navigation bars. Keep both system bars visible and theme-aware; do not draw dashboard content under the notch/status area or Android navigation controls.
- Primary dashboard is a bounded viewport with no root vertical scrolling. Theme gallery may scroll inside its own modal.
- Four quick workspaces remain visible. Use compact spacing before reducing readable typography.
- Layout must adapt to short heights; hide only noncritical promotion art first, never member identity or primary navigation.
- Calendar dates, text, charts, QR and controls are native Flutter components. Never use a complete reference screenshot as a background.
- Maintain separate palettes, background treatments, surface gradients, border geometry, shadows, accent behavior and theme-specific graphic assets for all ten themes.

## Asset policy

- Reuse and register the repository asset library under assets/: avatar, transparent badge art, trophy/flame, dumbbell, body scale, promo illustrations, wave and theme ornaments.
- Use isolated PNG artwork only for complex graphics; preserve aspect ratio and transparency. Native text and data must never be baked into a graphic.
- Existing extracted PNG assets are preferred over regenerating equivalent graphics. Do not promote sprite sheets, test crops or full dashboard screenshots to production assets without inspecting alpha, dimensions, crop and source.
- Promo content is illustrative sample content; do not imply a real sponsor, advertiser, payment partner or live discount.

## Verification gate

- dart format, flutter analyze, flutter test and Android release APK build must pass on the exact feature-branch commit.
- Widget tests cover all ten theme selections, four quick tabs, rail switching, 360dp layout and 320dp compact-height overflow.
- A successful compile is not proof of pixel-perfect rendering. Physical Xiaomi 11i screenshots are required for visual comparison; report each theme's screenshot status separately.
- Keep this work isolated on `chatgpt/design-lab-yellow-festive`. Do not change production `main` or package `com.badgym.bad_gym` without a separate user-approved port.
- Preserve installed app data. Never uninstall, clear data or bypass Android signing checks.
