# BAD GYM — Pearl Glass / Purple Neon Member Intelligence Dashboard

**Design authority:** The owner's second and third uploaded screenshots are the visual reference. The second image defines section order and campaign placement; the third guides compact spacing. The Emerald + Wine direction is superseded.

## Visual direction
- Gold-plan shell: deep grape / purple-violet outer frame with selective neon violet and champagne-gold edging.
- Content field: bright pearl / lilac frosted glass, not a full-screen dark-purple surface.
- Check-in: glossy purple gradient with green check circle and bodybuilder cutout.
- Freeze: pearl-white panel, violet snowflake and shaker artwork.
- Identity: gold portrait plate; strong plum/black member name; ID/age/gender metadata; luminous gold Gold Plan and green Active buttons.
- Payment: pearl card with purple wallet and rose amount; adjacent vivid violet whey promotion with matching art and yellow CTA.
- Membership progress: pale lilac glass card, purple progress track, red days-left chip and percentage.
- KPI tiles: distinct yellow Attendance, lavender Workout, sky Payment and mint Body; high-contrast values, transparent product art and saturated CTA strip.
- Analytics: pearl/lilac panel, violet header icon, attendance ring, semantic series, streak/best/month stats, paired campaign strips and compact calendar.
- Rail: six destinations (Attend, Insights, Cal, History, Trend, Goals), purple gradient, champagne-gold selected tile and white icons.

## Layout
Preserve master prompt order. At 360 dp fit the bounded host area without vertical/horizontal scrolling, clipping or distorted assets. Reclaim whitespace before shrinking critical labels. No extra app-level top/bottom navigation inside this component.

## Palette
Gold shell grape #210047, violet #6810B8, rail #7410C9 to #250045, neon accent #8F22E9, gold #FFE45E, pearl #FFFCFF, lilac #F0E6FF. Keep green, rose, amber and sky for status/KPI semantics. Spark and Silver preserve their own plan-derived palettes.

## Data and assets
Sample member remains Ashwani Kumar Singh / BG215 / 28 yrs / Male / Gold / Active; 22/30 membership days, 8 days left, ₹500 due, 81% attendance, 58 min workout, 69.5 kg. Mark sample data. Do not invent transactions, measurements, advertiser contracts or LIVE status. Keep campaign art paired with offer copy. Reuse PulseVault transparent assets with BoxFit.contain; no duplicate asset payloads or new runtime packages.

## Function and motion
Keep the four KPI modules and contextual destinations functional. Artwork and offer copy stay paired. Motion is finite; no idle timers, pulse loops or flashing.

## QA
Dart format, Flutter analyze, widget tests, ARM64 release build, APK signature verification and viewport tests at 320×560, 320×640, 360×600, 360×700, 390×720 and 800×600. CI pass is not physical-device certification.

## Attribution
This project uses Unslop by Damir Sokolovsky from .agents/skills/unslop/. Retain CC BY 4.0 attribution in adaptations.
