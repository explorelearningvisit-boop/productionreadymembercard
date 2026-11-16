import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';
import 'package:bad_gym/core/theme/dashboard_theme_variant.dart';

class MergedMemberCard extends StatefulWidget {
  final MemberIntelligenceData data;
  final DashboardThemeVariant themeVariant;
  final VoidCallback? onRenewPressed;
  final VoidCallback? onPaymentDetailsPressed;
  final VoidCallback? onQrPassPressed;
  final VoidCallback? onCheckInPressed;
  final VoidCallback? onNotificationPressed;

  const MergedMemberCard({
    super.key,
    required this.data,
    this.themeVariant = DashboardThemeVariant.festiveGold,
    this.onRenewPressed,
    this.onPaymentDetailsPressed,
    this.onQrPassPressed,
    this.onCheckInPressed,
    this.onNotificationPressed,
  });

  @override
  State<MergedMemberCard> createState() => _MergedMemberCardState();
}

class _MergedMemberCardState extends State<MergedMemberCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    const primaryTextColor = Color(0xFF1A1A1A);
    const secondaryTextColor = Color(0xFF6B6B6B);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Check-In Success! Ribbon with Notification Bell
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              widget.onCheckInPressed?.call();
            },
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.5),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF8B0000),
                    Color(0xFF5B0007),
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B0000).withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Color(0xFF16A34A),
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Check-In Success!',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontHeading,
                            fontWeight: FontWeight.w900,
                            fontSize: 13.5,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '${data.checkInDate} • ${data.checkInTime}',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontBody,
                            fontWeight: FontWeight.w500,
                            fontSize: 9.0,
                            color: Color(0xFFFDE8EC),
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Embedded Notification Bell Button
                  InkWell(
                    key: const ValueKey('header_notification_button'),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      widget.onNotificationPressed?.call();
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFD4AF37).withValues(alpha: 0.45),
                          width: 1.0,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            Icons.notifications_rounded,
                            color: Colors.white,
                            size: 17,
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Color(0xFFDC2626),
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: const Center(
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 7.5,
                                    fontWeight: FontWeight.w900,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 6),

          // 2. Member Profile Card (Luxury Gold & Ivory Edition with 3D Dumbbell)
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFFDF8),
                  Color(0xFFFDF6EA),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFEAD9C3),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Top Right 3D Metallic Dumbbell Asset
                Positioned(
                  top: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: 0.95,
                      child: Image.asset(
                        'assets/images/dumbbell_3d.png',
                        width: 84,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Profile Row: Avatar + Demographics + Badges
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 58x58 Avatar with Gold Border
                          InkWell(
                            key: const ValueKey('member_avatar_button'),
                            onTap: () {
                              HapticFeedback.lightImpact();
                              widget.onQrPassPressed?.call();
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFD4AF37),
                                  width: 2.2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF8B0000).withValues(alpha: 0.20),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/avatar_ashwani_hq.png',
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                  errorBuilder: (_, __, ___) => Image.asset(
                                    'assets/images/avatar_ashwini.png',
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.person_rounded,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 9),

                          // Name + ID | Age | Gender + Badges
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  data.name,
                                  style: const TextStyle(
                                    fontFamily: BadGymTypography.fontHeading,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15.5,
                                    color: primaryTextColor,
                                    letterSpacing: -0.2,
                                    height: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 2.5),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.badge_outlined,
                                        size: 11,
                                        color: Color(0xFF8B0000),
                                      ),
                                      const SizedBox(width: 2.5),
                                      Text(
                                        data.memberId,
                                        style: const TextStyle(
                                          fontFamily: BadGymTypography.fontHeading,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10,
                                          color: secondaryTextColor,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Text('|', style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 10)),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.person_outline_rounded,
                                        size: 11,
                                        color: Color(0xFF8B0000),
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${data.age} Yrs',
                                        style: const TextStyle(
                                          fontFamily: BadGymTypography.fontBody,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: secondaryTextColor,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Text('|', style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 10)),
                                      const SizedBox(width: 4),
                                      Text(
                                        '♂ ${data.gender}',
                                        style: const TextStyle(
                                          fontFamily: BadGymTypography.fontBody,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: secondaryTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 3.5),
                                // Badges Row: Active & Gold Plan
                                Row(
                                  children: [
                                    // Active Pill
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFF16A34A), Color(0xFF15803D)],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF16A34A).withValues(alpha: 0.3),
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.check_rounded, size: 10, color: Colors.white),
                                          SizedBox(width: 2.5),
                                          Text(
                                            'Active',
                                            style: TextStyle(
                                              fontFamily: BadGymTypography.fontHeading,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 9,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    // Gold Plan Pill
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFFFFDF7A), Color(0xFFD4AF37)],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.emoji_events_rounded, size: 10, color: Color(0xFF5D3800)),
                                          SizedBox(width: 2.5),
                                          Text(
                                            'Gold Plan',
                                            style: TextStyle(
                                              fontFamily: BadGymTypography.fontHeading,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 9,
                                              color: Color(0xFF5D3800),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Two-Subcard Row (Payment Due & 8 Days Left)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF1F2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFFFCCD3),
                            width: 0.9,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Left Subcard: Payment Status
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  widget.onPaymentDetailsPressed?.call();
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFE4E6),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.account_balance_wallet_rounded,
                                          color: Color(0xFFDC2626),
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Payment Due',
                                            style: TextStyle(
                                              fontFamily: BadGymTypography.fontBody,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 8.5,
                                              color: Color(0xFF6B6B6B),
                                              height: 1.0,
                                            ),
                                          ),
                                          SizedBox(height: 1.5),
                                          Text(
                                            '₹500 Due',
                                            style: TextStyle(
                                              fontFamily: BadGymTypography.fontHeading,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 12.0,
                                              color: Color(0xFFDC2626),
                                              height: 1.1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right_rounded,
                                      color: Color(0xFF94A3B8),
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Vertical Divider
                            Container(
                              width: 1,
                              height: 24,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              color: const Color(0xFFCBD5E1),
                            ),

                            // Right Subcard: Expiry Status
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  widget.onRenewPressed?.call();
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFE4E6),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.calendar_month_rounded,
                                          color: Color(0xFFDC2626),
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${data.daysLeft} Days Left',
                                            style: const TextStyle(
                                              fontFamily: BadGymTypography.fontHeading,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 12.0,
                                              color: Color(0xFFDC2626),
                                              height: 1.1,
                                            ),
                                          ),
                                          const SizedBox(height: 1.5),
                                          Text(
                                            'Expires: ${data.renewDate}',
                                            style: const TextStyle(
                                              fontFamily: BadGymTypography.fontBody,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 8.5,
                                              color: Color(0xFF6B6B6B),
                                              height: 1.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right_rounded,
                                      color: Color(0xFF94A3B8),
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Membership Progress Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Membership 22 / 30 Days',
                            style: TextStyle(
                              fontFamily: BadGymTypography.fontHeading,
                              fontWeight: FontWeight.w800,
                              fontSize: 10,
                              color: primaryTextColor,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBF1DF),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: const Color(0xFFE8D4B0),
                                width: 0.8,
                              ),
                            ),
                            child: const Text(
                              '73%',
                              style: TextStyle(
                                fontFamily: BadGymTypography.fontHeading,
                                fontWeight: FontWeight.w900,
                                fontSize: 9,
                                color: Color(0xFF92400E),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 3.5),

                      // Progress Bar Track with Luxury Red/Crimson Gradient
                      Container(
                        height: 5.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFE6D8),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: constraints.maxWidth * data.usedPercentage.clamp(0.0, 1.0),
                                height: 5.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFDC2626),
                                      Color(0xFF8B0000),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
