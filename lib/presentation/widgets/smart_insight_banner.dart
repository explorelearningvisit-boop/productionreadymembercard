import 'package:flutter/material.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class SmartInsightBanner extends StatelessWidget {
  final VoidCallback? onTap;

  const SmartInsightBanner({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8B0000),
            Color(0xFF550007),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD4AF37),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B0000).withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 88, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lightbulb_rounded,
                        color: Color(0xFFFFDF7A),
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Smart Insight',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontHeading,
                            fontWeight: FontWeight.w900,
                            fontSize: 13.0,
                            color: Colors.white,
                            letterSpacing: 0.2,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Great progress! Attendance is 81%. Keep a 6-day streak to reach 90%.',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontBody,
                    fontWeight: FontWeight.w500,
                    fontSize: 9.0,
                    color: Colors.white.withValues(alpha: 0.88),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),

          // 3D Gym Gear Graphic & Chevron Action Button
          Positioned(
            right: 6,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 72,
                  height: 48,
                  child: Image.asset(
                    'assets/images/smart_insight_gear_blended.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.fitness_center_rounded,
                      color: Color(0xFFFFDF7A),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B000B),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.7),
                        width: 1.0,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
