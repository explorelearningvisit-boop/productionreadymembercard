# BAD GYM — Current UI/UX Source of Truth
Last updated: 2026-11-15
Status: ACTIVE — this file supersedes older design descriptions in AGENTS.md, AI_SHARED_COMMUNICATION_HUB.md, screenshots notes, and prior AI session logs whenever they conflict.

## Current reference
The user-provided image in the 2026-11-15 conversation is the latest approved visual reference (1024x1536 portrait). Match its composition, hierarchy, proportions, visual treatment and red/gold/white palette. Do not revert to Royal Purple / Neon Violet: that was an older iteration and is obsolete.

## Design language
- Brand direction: bold BAD GYM red performance dashboard; premium glossy / glass-like highlights, bright white content surfaces where the reference uses them, deep crimson gradients, gold/yellow accents, clean typography and crisp high-contrast text.
- Core palette: primary strawberry red #E50914; deep crimson #76000D; burgundy #380008; warm white #FFF8F5; gold #FFDF00 / #FFB800; success green #16A34A. Purple is not a primary brand/theme colour.
- Top brand bar and Check-In Success hero: vivid red gradient, white branding, gold accents, athlete cutout and gym equipment illustration.
- Member profile / membership card: user has explicitly requested the complete card to be red-themed, including member identity, payment/renewal details, membership progress label and progress track. Use a crimson gradient outer card and coordinated red inner surfaces; white/light text; gold progress fill and percentage badge; green Active and gold Plan pills. Do not leave the overall member card white.
- Quick stats: preserve four distinct cards (Attendance, Workout, Payment, Body); selected Attendance uses red; inactive cards remain light/white with red iconography and readable text.
- Vertical navigation rail: deep burgundy/red body with bright red active item, white icons/labels and restrained red glow. No purple rail.
- Intelligence card: light pearl/white content surface as in reference, red section icon/selected accents, clear data visualisation, readable calendar and legend.
- Promotional banner: red/gold branded campaign artwork; avoid stretching/cropping text or faces.

## Content and layout rules
- Use the supplied reference's information architecture: brand header; check-in hero; member profile; payment and expiry; membership progress; four quick stats; vertical navigation plus intelligence panel; promotional banner.
- Member identity is data-driven. Do not hardcode a different person's name; current sample model may display Ashwani Kumar Singh. The user referred to the member card; use the data model name.
- Keep the layout mobile-first and verify at 360dp width and on Xiaomi 11i (1080x2400, Android 13) when a live device is available. Avoid horizontal overflow, clipped labels, tiny text, or duplicated metrics.
- Do not invent features or replace the user's information architecture. Improve spacing, contrast, accessibility, responsive behaviour and component consistency.
- Do not flatten UI text/charts into images. Use native Flutter widgets for labels, metrics, charts, buttons and calendar; raster art only for isolated illustrations.

## Asset policy
- Audit each asset for dimensions, file size, alpha channel, crop and actual usage before declaring it production-ready.
- Keep transparent isolated illustrations as PNG/WebP with verified alpha. Do not use sprite sheets, contact sheets, or intermediate extraction files as final individual assets.
- Do not regenerate assets merely because a folder contains test exports. First inspect what the app actually references and whether existing art is valid.
- Record asset source/license and purpose in assets/README.md.

## AI collaboration protocol
1. Read this file first before any UI/UX change.
2. This file is the single current design authority. Older purple-theme notes are historical only and must not be treated as active requirements.
3. If the user changes the reference or palette, update this file and AI_SYNC_STATE.json in the same change.
4. After changes, run dart format, flutter analyze, flutter test and release APK build in GitHub Actions.
5. Device installation, screenshot and logcat are only VERIFIED when a current workflow run reports success and its artifacts contain the actual fresh capture. Do not copy old screenshots and label them live.
6. Never put private ADB keys, Tailscale auth keys, OAuth secrets or tokens in Git files or chat. Use encrypted GitHub Actions secrets.
7. Tailscale IP is private; Android Wireless Debugging TCP port is dynamic. Never assume port 5555 or reuse a stale port. Discover/update the port after checking the phone. Tailscale reachability does not imply ADB pairing/authorization.
8. Report build, test, device-connectivity and screenshot status separately; distinguish verified facts from pending setup.


## 2026-11-16 compact mobile revision
- Keep the four horizontal quick-stat tabs in this order: Attendance, Workout, Payment, Body.
- The check-in event ribbon and member profile card occupy the full available mobile width; the vertical navigation rail begins below the four quick-stat tabs.
- The vertical rail is a narrow crimson gradient control, aligned only beside the selected intelligence canvas rather than running alongside the header and member profile.
- Remove the duplicate CHECK-IN/QR action badge from the success ribbon; show only the event title and its date/time. Do not show a gym-floor label.
- Remove the Smart Insight promotional strip and the bottom Streak/Best/Plan Days/Next Goal summary strip from the default attendance viewport.
- Preserve the member profile's identity, payment due, expiry and membership progress. Keep the attendance trend visualization and its maximum/average/minimum summary.
- Keep all four quick-stat cards compact and equal-width; the Payment card displays the due/paid state with semantic status colour.


## 2026-11-16 — Unified Member Dashboard Card revision (latest user instruction)
- Supersedes the earlier instruction to remove Smart Insight and the bottom Streak/Best/Plan Days/Next Goal strip. Restore both inside the member intelligence canvas.
- Pack the check-in event ribbon, member profile/payment/expiry/progress, four horizontal tabs, vertical rail, selected intelligence content, Smart Insight and bottom summary inside one visibly bordered outer Member Dashboard Card. Border must be visible on top, left, right and bottom.
- Keep four horizontal tabs: Attendance, Workout, Payment, Body. Payment must remain visible and selectable at 360dp.
- Place the vertical rail only beside the intelligence canvas, beginning level with Attendance Trend and ending level with the bottom summary. It must not consume width beside the check-in ribbon or member profile.
- Remove the redundant CHECK-IN action/button beside the check-in event. The ribbon is informational; it must not open QR or claim a new check-in.
- Replace heavy dark brown/deep burgundy surfaces with light warm coral/rose/ivory. Smart Insight's light treatment is the colour direction. Maintain readable contrast.
- Preserve live member identity, payment due, expiry, membership progress and all four tabs.
- Verify at 360dp and on Xiaomi 11i when available; build/test and physical-device QA remain separate evidence states.


## 2026-11-16 — Compact fixed-viewport workspace (latest user direction)
- The current tall scrollable Dashboard screenshot is rejected. Replace the stacked full-page presentation with a compact fixed-viewport intelligence workspace.
- Keep compact member identity, plan, due/expiry context. Reduce horizontal tab height and internal padding. Four tabs remain Attendance, Workout, Payment, Body.
- Attendance opens a month calendar by default. The contextual vertical rail switches between Attendance Calendar, Trend, History and Streak/Insights; each selection replaces the widget inside one bounded viewport. No stacked widget growth and no primary dashboard vertical scrolling.
- Other top tabs similarly expose contextual compact widgets. Width and height must be bounded; use tab/rail switching to reveal more information instead of extending the page.
- Visual palette: premium warm ivory/light surfaces + controlled crimson/red; restrained gold for premium emphasis; semantic green/red/amber/grey. Remove lavender/purple and inconsistent peach/pink gradients. Use compact spacing and readable contrast.
- This latest user direction supersedes the previous 2026-11-16 unified outer card composition where that composition causes oversized vertical layout or scrolling.


## 2026-11-16 — Implemented compact workspace source authority
- Actual implementation now resides in `lib/presentation/member_checkin_screen.dart`; this supersedes older descriptions of the tall bordered scrollable page and old rail placement.
- Primary root is a bounded `LayoutBuilder` workspace with no vertical scroll view. Member identity/check-in/payment/expiry/progress are compact; four tabs stay visible; a contextual rail switches one fixed-viewport widget at a time.
- Attendance opens Calendar; Trend, History and Insights are separate destinations. Workout, Payment and Body expose their own focused destinations. No stacked chart + calendar + Smart Insight + streak strip in the default canvas.
- Calendar month controls use ivory/crimson and neutral holiday semantics; no lavender.
- CI run 43877970432 confirmed format/analyze and exposed an unbounded FittedBox calendar-width constraint. Replaced it with a directly width-constrained calendar in commit 9739c832f4c1b117d7541a47a1fd5015864e95de. New CI run 43879102167 has format/analyze/tests passing; Android APK build is still in progress at this note.
- Physical Xiaomi visual QA is still pending. Do not call the design pixel-perfect until a fresh screenshot from the Xiaomi is compared.


## 2026-11-17 — Latest approved screenshot: ice-blue glass Member Intelligence

**This dated user-provided screenshot supersedes all earlier visual palettes and layout descriptions above wherever they conflict.** Source: `/mnt/data/1000320035.jpg`, 1024 × 1536 px portrait. The screenshot includes the Android status and navigation areas; use it as a visual composition reference, not as dp dimensions.

### Visual language
- Pale ice-blue / cool cyan glass background with flowing water-wave highlights.
- Translucent pearl-white glass cards, double white/cool-blue edge highlights, soft blue ambient shadows and rounded corners.
- Navy headline/body typography; vivid blue primary controls; green checked-in/present/active, amber late/gold plan, red absent/payment due, neutral grey holiday/off.
- Premium glossy 3D highlights and supplied 3D artwork where assets exist. No dark theme, crimson theme, ivory-only theme or purple dominant theme.

### Exact screen hierarchy
1. Header: dumbbell app mark, BAD GYM wordmark with blue GYM accent, Member Intelligence subtitle, glass search, notification bell with red 3 badge, QR scan action.
2. Single member pass card: portrait at left; CHECKED-IN badge and date/time; full member name, ID, age, gender; Active and Gold Plan badges; QR at right. Bottom row contains membership days/progress/percentage and expiry/days-left. Keep all identity and membership data in this single card.
3. Horizontal sponsored festival banner: Amazon brand block, Great Indian Festival badge, up to 40% off fitness/wellness, gym product art, Sponsored label.
4. Four equal-width KPI cards in one row: Attendance (green donut +6%), Workout (58 min +12% mini-bars), Payment (₹500 Due + cashback), Body (69.5 kg −0.8 kg).
5. Large intelligence workspace: narrow vertical left rail (Calendar, Trend, History, Insight, Goal); default Attendance Intelligence content has month selector, weekday headers, circular day-status calendar, right-side 81% donut, counts/progress bars for Present/Late/Absent/Holiday, and 5-day streak.
6. Bottom glass AI Insights strip: AI Insights label, Attendance +6% vs last month, Best Streak 14 Days, forward chevron.

### Responsive implementation rules
- Preserve this exact hierarchy and relative visual weight on a 360dp-wide phone.
- Keep the primary dashboard bounded and non-scrollable; compress section heights responsively while preserving readable type and a useful attendance workspace.
- Calendar default is October 2026 for the supplied fixture; use model-driven dates/statuses. Sunday/off uses a neutral disabled treatment and holiday is neutral grey.
- Real scannable member QR, not a decorative QR glyph.
- The sponsored banner is a compact horizontal promo; do not replace it with the older oversized protein-burger banner.
- Tabs and rail controls replace the workspace content in place. No duplicate member payment/progress cards.
- Do not invent extra sections or change the visual system without a new explicit user reference.

### Implementation status
ChatGPT's independent implementation is in `lib/presentation/reference_member_dashboard.dart`, launched by `lib/main.dart`. Visual QA is pending until the latest CI release APK is built and compared against a fresh Xiaomi 11i capture. Never claim pixel-perfect or production-ready without that evidence.
