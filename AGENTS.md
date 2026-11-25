# BAD GYM project rules

- Reproduce the full supplied Purple Neon member dashboard screenshot in Flutter, including its promotions, analytics, calendar and six-item vertical navigation rail.
- Target Android phones first; verify 320 dp, 360 dp and 390 dp widths.
- Include the reference screenshot's member identity, membership status/progress, check-in/freeze, promotions, four metric tiles and attendance analytics/calendar.
- Do not add components that are absent from the current reference screenshot. The six-item rail and visible promotional panels are explicitly required by that reference.
- Keep demo values explicitly labeled until a real gym API is connected.
- Prefer Flutter SDK widgets and zero runtime packages.
- Run format, analyze, widget tests and an ARM64 release QA APK build for meaningful changes.
- Report CI, visual and real-device verification separately. Never claim device validation without installation and launch evidence.
