# V1 Implementation Notes

## Implemented
- Responsive single-column dashboard with the approved component sequence.
- Neon outer frame and purple/gold gradient surfaces using Flutter decorations.
- Member identity, plan/active pills, payment and membership offer sections.
- Four sponsor/metric cards.
- Attendance rail with tappable selected state.
- Attendance summary, streak indicators, day-state calendar and legend.
- Bottom utility actions.
- Safe-area-aware screen wrapper.

## Not yet implemented
- Real member API, payment gateway, attendance sync or server-driven advertising.
- Production QR payload/QR code rendering (current QR-like mark is decorative only).
- Final isolated 3D PNG pack. The previously generated local ZIP is not silently treated as committed or production-ready.
- Screenshot-diff calibration on physical Android hardware.

## Verification gate
Run CI on this branch. A passing CI run verifies formatting, analysis, widget tests and APK compilation only; it does not prove pixel-perfect hardware rendering. Device screenshot comparison is a separate acceptance gate.
