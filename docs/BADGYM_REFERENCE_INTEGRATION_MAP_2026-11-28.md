# BAD GYM — Reference integration map / 2026-11-28

## Uploaded reference inventory

| Image | Reference role | Dashboard integration |
|---|---|---|
| 1000317294.png | Purple-glass overall dashboard with identity, check-in, attendance, workout, body, calendar, payment, trainer and nutrition | Shared member header and compact four-module overview |
| 1000317295.png | Pearl dashboard with traffic-light states, check-in progress and status summary | Semantic present / caution / action / unavailable states; local check-in remains a preview |
| 1000317298.png | Four detailed workspaces for Attendance, Workout, Payment and Body | Four KPI modules, each with six contextual destinations |
| 1000317054.png | Member summary, check-in, campaign strip, payment and body KPI cards | Member identity, balance, membership progress and preview campaign |
| 1000315582.png | Asset board with themes, transparent-character examples, fitness objects, food, icons, charts, typography and wireframes | Material and asset selection only; not used as a flattened screen background |
| 1000315581.png | Alternate color/material board, UI widgets, characters, objects and wireframes | Common lavender / pearl glass language; campaigns retain their own source colors |
| 1000315570.png | Ten theme/campaign dashboard examples | Campaign placement and layout reference; claims remain demo until provider connected |
| 1000315572.png | Ten mobile theme examples including nutrition, health, wearable and campaign screens | Layout inspiration; do not combine ten incompatible skins in one dashboard |
| 1000315469.png | Detailed Attendance, Workout, Payment and Body module panels | Charts, month/range controls, legends, behaviour and progress panels |
| 1000315354.png | Body overview, composition, measurements, progress, gallery, goals and health | Body module IA and honest empty-state structure |

## Approved product direction

- Product: phone-first member intelligence for gym members and gym staff.
- Character: athletic, tactile and data-rich.
- World: lavender pearl-glass surfaces, deep-violet navigation and restrained semantic status colors.
- Moments: attendance calendar, workout distribution / trend, payment behaviour and body progress.
- Signature: four horizontal module selectors with contextual six-item vertical navigation.

## Menu map

- Attendance: Overview, Insights, Calendar, History, Trend, Goals.
- Workout: Overview, Insights, Log, Trend, Recovery, Goals.
- Payment: Overview, Insights, Invoices, History, Methods, Rewards.
- Body: Overview, Insights, Weight, Measurements, Nutrition, Goals.

## Asset contract

- Canonical runtime folder: \`assets/material_pack/inbox/PulseVault/\`.
- Use actual transparent WebP / PNG artwork with \`BoxFit.contain\`; preserve source aspect ratio.
- Reference collage boards contain embedded text, cards, borders and faux checkerboard-looking regions. They must not be loaded as app backgrounds or passed off as individual transparent cut-outs.
- Keep all visible copy, prices, dates, status, labels, charts and controls as Flutter widgets.
- Only register runtime assets actually used.

## Data-integrity and release boundaries

- Ashwani / BG215 remains the existing local sample member.
- Do not invent payment transactions, exercise logs, body assessments, measurement histories, photo gallery entries, nutrition logs, sleep or hydration records.
- Illustrative charts and calendar statuses are visibly labelled preview/demo. Empty history panels describe which source is required.
- Check-in, freeze and campaign actions remain local previews; they do not write server transactions.
- Backend, auth, server-authoritative actions, production signing and Xiaomi 11i screenshot certification remain separate gates.

## Unslop attribution

Adaptation retains the Unslop by Damir Sokolovsky attribution under CC BY 4.0, as required by the bundled project skill.
