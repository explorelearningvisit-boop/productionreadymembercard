# BAD GYM — Attendance Reference Pixel Spec
Date: 2026-11-28

## Source order and authority

- 1000322943.jpg is the installed-app screenshot. It contains an Android/ChatGPT notification overlay covering the top dashboard; that OS notification is not an app component and must not be reproduced.
- 1000322424.png is the target requirement. It controls the order, density, campaign placements, typography hierarchy, status colors, attendance chart/calendar and six-row vertical rail.
- The target is a live Flutter screen, not a flattened screenshot or static background. Use the existing PulseVault assets with BoxFit.contain.

## Design direction

- Product: BAD GYM member intelligence for members and gym operators.
- Character: athletic, confident, tactile.
- World: deep grape frame surrounding a pearl/lilac frosted-glass workspace.
- Moments: green attendance ring and semantic day cells; product/campaign artwork inside clearly bounded sponsor slots.
- Signature: a six-item vertical contextual rail whose selected item uses the plan's gold identity, paired with four module KPI cards above it.

## Component order

1. Check-in and Freeze actions in one equal-width row.
2. Member identity: portrait, member name, ID, age, gender, Gold Plan, Active.
3. Payment Due + Whey Protein sponsored placement.
4. Membership: 22/30 days, 8 days left, 73% progress.
5. Four KPI/menu cards: Attendance 81%, Workout 58 min, Payment ₹500 Due, Body 69.5 kg. Each card has two disjoint hit areas: its metric surface opens the module; its visibly marked sponsored footer opens only the campaign preview.
6. Attendance rail: Attend, Insights, Cal, History, Trend, Goals. The main content panel sits to the right.
7. Attendance Analytics header with a distinct Blinkit campaign banner.
8. Attendance ring 81% / 25/31 and legend rows for Present 23 / 74%, Absent 2 / 6%, Holiday 4 / 13%, Late 2 / 6%.
9. One compact strip: 5d Streak, 14d Best, +6% This Month and a distinct Recovery Combo campaign.
10. October attendance calendar with a distinct Train More campaign, weekdays and days 13–25 with the target day/status semantics.
11. A quiet sample-data / no-live-sync disclosure.

## Interaction contract

- KPI metric surface and KPI sponsor footer are separate sibling tap targets; no nested gesture recognizers or overlapping hitboxes.
- Module surface changes the selected module and vertical rail. Sponsor surface opens a campaign preview only.
- Freeze and Check-in retain local preview behaviour; they do not alter server membership/check-in data.
- Every advertiser slot has a stable campaign_id, advertiser_id and placement_id.
- The preview inventory assigns each advertiser to one placement in this dashboard. A production feed must reject duplicate advertiser_id or capped campaign_id placements per member/session, and record impressions/clicks server-side. Client-only checks are not billing enforcement.
- No ad should appear automatically at the top of every module detail panel. Module navigation must not duplicate the paid campaign displayed in the KPI card. Contextual detail placements are shown only when they have their own eligible campaign/placement.
- A sponsor click currently opens a local preview sheet because no advertiser destination URL or live campaign feed is configured. Do not claim that a real external redirect or purchase works yet.

## Data contract

The reference's member and attendance figures are sample UI data. Retain Ashwani Kumar Singh / BG215 / 28 yrs / Male / Gold Plan / Active; ₹500 due; 22/30 days; 8 days left; 73%; Attendance 81%; Workout 58 min; Payment ₹500; Body 69.5 kg; sample attendance counts 23 present, 2 absent, 4 holidays and 2 late. The trend values and discount claims are illustrative campaign/sample data until connected to a verified API or advertiser contract.

## Sizing and quality

- 360 dp width is the primary target; check 320 and 390 dp without overflow or horizontal scrolling.
- Keep sibling cards equal in height and horizontal gaps consistent on a 4 dp rhythm.
- Preserve the pearl surface, deep-purple rail, gold active item, semantic KPI tints and transparent PulseVault art.
- Keep labels readable; avoid scaling the whole screen into a miniature.
- Test module navigation and sponsor actions independently.
- No new runtime packages. Keep the existing Android application ID and QA workflow.
- Retain Unslop by Damir Sokolovsky attribution under CC BY 4.0 in adaptations.
