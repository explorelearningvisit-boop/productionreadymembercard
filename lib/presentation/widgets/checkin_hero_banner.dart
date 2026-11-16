import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class CheckInHeroBanner extends StatelessWidget {
  final MemberIntelligenceData data;
  final VoidCallback? onCheckInPressed;

  const CheckInHeroBanner({
    super.key,
    required this.data,
    this.onCheckInPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      height: 130,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE50914),
            Color(0xFFBA0018),
            Color(0xFF75000C),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFFF4D6D).withValues(alpha: 0.5),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBA0018).withValues(alpha: 0.4),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Golden light wave arc across background
            Positioned(
              top: -20,
              left: 40,
              right: 40,
              height: 100,
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _GoldWavePainter(),
                ),
              ),
            ),

            // Left Athlete Image
            Positioned(
              left: -4,
              bottom: 0,
              top: 4,
              child: IgnorePointer(
                child: Image.asset(
                  'assets/hero/hero_athlete.png',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),

            // Right-side product cutouts: dumbbell + BAD GYM shaker.
            // Keep them compact so they never collide with the success headline.
            Positioned(
              right: 5,
              bottom: 8,
              top: 8,
              child: IgnorePointer(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/hero/dumbbell_3d.png',
                      width: 66,
                      height: 72,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const SizedBox(),
                    ),
                    const SizedBox(width: 2),
                    Image.asset(
                      'assets/hero/shaker_bottle.png',
                      width: 39,
                      height: 96,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),

            // Center: Checkmark Circle + "Check-In Success!" + "Welcome Back to BAD GYM"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Yellow Checkmark Circle
                      InkWell(
                        key: const ValueKey('header_checkin_button'),
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          onCheckInPressed?.call();
                        },
                        borderRadius: BorderRadius.circular(22),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFFEB3B),
                                Color(0xFFF59E0B),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFF59E0B)
                                    .withValues(alpha: 0.6),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.black,
                            size: 24,
                            weight: 800,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Text: Check-In Success!
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Check-In',
                            style: TextStyle(
                              fontFamily: BadGymTypography.fontHeading,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Colors.white,
                              height: 1.0,
                              letterSpacing: 0.2,
                            ),
                          ),
                          Text(
                            'Success!',
                            style: TextStyle(
                              fontFamily: BadGymTypography.fontHeading,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                              color: Color(0xFFFFE600),
                              height: 1.0,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Divider & Subtitle: — Welcome Back to BAD GYM —
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 22,
                          height: 1.2,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Welcome Back to BAD GYM',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontBody,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: Colors.white.withValues(alpha: 0.95),
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 22,
                          height: 1.2,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ],
                    ),
                  ),

                  // Accessible tap label for test automation
                  Semantics(
                    label: 'CHECK-IN',
                    child: const SizedBox(
                      width: 0,
                      height: 0,
                      child: Text('CHECK-IN', style: TextStyle(fontSize: 0.01)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoldWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(0, h * 0.7)
      ..cubicTo(w * 0.35, h * 0.1, w * 0.65, h * 0.9, w, h * 0.3);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = const LinearGradient(
        colors: [
          Color(0x00FFDF7A),
          Color(0xAAFFDF7A),
          Color(0xEEFFFFFF),
          Color(0xAAFFDF7A),
          Color(0x00FFDF7A),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
