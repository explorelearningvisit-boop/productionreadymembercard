import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class TopHeaderBar extends StatelessWidget {
  final MemberIntelligenceData data;
  final bool isCollapsed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onMorePressed;
  final VoidCallback? onAvatarPressed;
  final VoidCallback? onCheckInPressed;
  final VoidCallback? onBackPressed;

  const TopHeaderBar({
    super.key,
    required this.data,
    this.isCollapsed = false,
    this.onNotificationPressed,
    this.onMorePressed,
    this.onAvatarPressed,
    this.onCheckInPressed,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Back Chevron Button (Glossy Red Squircle)
          InkWell(
            key: const ValueKey('header_back_button'),
            onTap: () {
              HapticFeedback.lightImpact();
              if (onBackPressed != null) {
                onBackPressed!();
              } else if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFBA0018),
                    Color(0xFF6B000B),
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFFFF5268).withValues(alpha: 0.6),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFBA0018).withValues(alpha: 0.45),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // 2. CHECK-IN Button (Neon Emerald Green Pill)
          InkWell(
            key: const ValueKey('header_checkin_button'),
            onTap: () {
              HapticFeedback.mediumImpact();
              onCheckInPressed?.call();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Checked In successfully at BAD GYM! 🔥'),
                  backgroundColor: BadGymColors.primary,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            borderRadius: BorderRadius.circular(22),
            child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF26DE7A),
                    Color(0xFF0EA74E),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFF86FFBD),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF26DE7A).withValues(alpha: 0.55),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check_rounded,
                        color: Color(0xFF0EA74E),
                        size: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'CHECK-IN',
                    style: TextStyle(
                      fontFamily: BadGymTypography.fontHeading,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Subtle white vertical separator
          Container(
            width: 1.5,
            height: 24,
            color: const Color(0x99FFFFFF),
          ),

          const SizedBox(width: 10),

          // 3. Time & Date Display (Crisp Typography with FittedBox)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    data.checkInTime, // 07:12 AM
                    style: const TextStyle(
                      fontFamily: BadGymTypography.fontHeading,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: Color(0xFFD6001C),
                      height: 1.1,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const SizedBox(height: 1),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        size: 11,
                        color: Color(0xFFD6001C),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        data.checkInDate, // 16 Oct 2026
                        style: const TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w700,
                          fontSize: 10.5,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // 4. Notification Bell Button (Glossy Red Squircle with Badge 3)
          InkWell(
            key: const ValueKey('header_notification_button'),
            onTap: () {
              HapticFeedback.lightImpact();
              onNotificationPressed?.call();
            },
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFBA0018),
                        Color(0xFF6B000B),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFFF5268).withValues(alpha: 0.6),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFBA0018).withValues(alpha: 0.45),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.notifications_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),

                // Red circular notification count badge
                Positioned(
                  top: -3,
                  right: -3,
                  child: Container(
                    padding: const EdgeInsets.all(3.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF1744),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 17,
                      minHeight: 17,
                    ),
                    child: const Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w900,
                          fontSize: 9,
                          color: Colors.white,
                          height: 1.0,
                        ),
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
