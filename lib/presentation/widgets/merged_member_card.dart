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

  LinearGradient get _cardGradient {
    switch (widget.themeVariant) {
      case DashboardThemeVariant.darkObsidianGold:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E212D), Color(0xFF13151D), Color(0xFF0F1017)],
        );
      case DashboardThemeVariant.emeraldNeon:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF0FDF4), Color(0xFFDCFCE7), Color(0xFFBBF7D0)],
        );
      case DashboardThemeVariant.royalPurple:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFAF5FF), Color(0xFFF3E8FF), Color(0xFFE9D5FF)],
        );
      case DashboardThemeVariant.crimsonWave:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFFFF5F5), Color(0xFFFFECEE)],
        );
      case DashboardThemeVariant.festiveGold:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFDF7), Color(0xFFFFF7DB), Color(0xFFFFECB3)],
        );
    }
  }

  Color get _borderColor {
    switch (widget.themeVariant) {
      case DashboardThemeVariant.darkObsidianGold:
        return const Color(0xFFD4AF37).withValues(alpha: 0.5);
      case DashboardThemeVariant.emeraldNeon:
        return const Color(0xFF22C55E).withValues(alpha: 0.5);
      case DashboardThemeVariant.royalPurple:
        return const Color(0xFFA855F7).withValues(alpha: 0.4);
      case DashboardThemeVariant.crimsonWave:
        return const Color(0xFFFF334B).withValues(alpha: 0.35);
      case DashboardThemeVariant.festiveGold:
        return const Color(0xFFEAB308).withValues(alpha: 0.6);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final isDark = widget.themeVariant == DashboardThemeVariant.darkObsidianGold;
    final primaryTextColor = isDark ? Colors.white : const Color(0xFF1E293B);
    final secondaryTextColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
      padding: const EdgeInsets.all(9.0),
      decoration: BoxDecoration(
        gradient: _cardGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.07),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Integrated Check-In Success Ribbon + Notification Bell
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              widget.onCheckInPressed?.call();
            },
            borderRadius: BorderRadius.circular(13),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.5),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF10B981),
                    Color(0xFF059669),
                  ],
                ),
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withValues(alpha: 0.35),
                    blurRadius: 6,
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
                        color: Color(0xFF059669),
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
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
                          'Fri, 16 Oct 2026 • 06:42 PM • Main Gym Floor',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontBody,
                            fontWeight: FontWeight.w500,
                            fontSize: 9.5,
                            color: Color(0xFFD1FAE5),
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Accessory Badge: CHECK-IN
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'CHECK-IN',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontHeading,
                            fontWeight: FontWeight.w900,
                            fontSize: 8,
                            letterSpacing: 0.5,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(Icons.qr_code_scanner_rounded, size: 10, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(width: 7),
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
                        color: Colors.white.withValues(alpha: 0.22),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.45),
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
                            top: 3,
                            right: 3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Color(0xFFE50914),
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

          const SizedBox(height: 7),

          // 2. Member Profile Row (Enlarged Avatar + Demographics + Badges)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Enlarged Avatar (58x58) with gold border & click feedback
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
                      color: const Color(0xFFFFD66B),
                      width: 2.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFB50D12).withValues(alpha: 0.25),
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

              const SizedBox(width: 8),

              // Name + ID | Age | Gender
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.name,
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
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
                            size: 12,
                            color: Color(0xFFB91C1C),
                          ),
                          const SizedBox(width: 2.5),
                          Text(
                            data.memberId,
                            style: TextStyle(
                              fontFamily: BadGymTypography.fontHeading,
                              fontWeight: FontWeight.w700,
                              fontSize: 10.5,
                              color: secondaryTextColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '|',
                            style: TextStyle(
                              color: Color(0xFFCBD5E1),
                              fontSize: 10.5,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.person_outline_rounded,
                            size: 12,
                            color: Color(0xFFB91C1C),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${data.age} Yrs',
                            style: TextStyle(
                              fontFamily: BadGymTypography.fontBody,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.5,
                              color: secondaryTextColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '|',
                            style: TextStyle(
                              color: Color(0xFFCBD5E1),
                              fontSize: 10.5,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '♂ ${data.gender}',
                            style: TextStyle(
                              fontFamily: BadGymTypography.fontBody,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.5,
                              color: secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Badges: Active & Gold Plan
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Active Pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF22C55E),
                          Color(0xFF16A34A),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF22C55E).withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_rounded,
                          size: 11,
                          color: Colors.white,
                        ),
                        SizedBox(width: 2),
                        Text(
                          'Active',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontHeading,
                            fontWeight: FontWeight.w800,
                            fontSize: 9.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 3),

                  // Gold Plan Pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFFDF7A),
                          Color(0xFFFFB300),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFB300).withValues(alpha: 0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.emoji_events_rounded,
                          size: 10,
                          color: Color(0xFF5D3800),
                        ),
                        SizedBox(width: 2.5),
                        Text(
                          'Gold Plan',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontHeading,
                            fontWeight: FontWeight.w800,
                            fontSize: 9.5,
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

          const SizedBox(height: 6),

          // 3. Compact Two-Subcard Row (Payment & Days Left)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4.0),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1C26) : const Color(0xFFFFF1F2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? const Color(0xFF2E3346) : const Color(0xFFFFCCD3),
                width: 1,
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
                            color: isDark ? const Color(0xFF2A1C24) : const Color(0xFFFFE4E6),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.account_balance_wallet_rounded,
                              color: Color(0xFFE11D48),
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
                                'Payment',
                                style: TextStyle(
                                  fontFamily: BadGymTypography.fontBody,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 8.5,
                                  color: Color(0xFF64748B),
                                  height: 1.0,
                                ),
                              ),
                              SizedBox(height: 1.5),
                              Text(
                                '₹500 Due',
                                style: TextStyle(
                                  fontFamily: BadGymTypography.fontHeading,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 11.5,
                                  color: Color(0xFFE11D48),
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
                  color: isDark ? const Color(0xFF2E3346) : const Color(0xFFCBD5E1),
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
                            color: isDark ? const Color(0xFF2A1C24) : const Color(0xFFFFE4E6),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.calendar_month_rounded,
                              color: Color(0xFFE11D48),
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
                                  fontSize: 11.5,
                                  color: Color(0xFFE11D48),
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
                                  color: Color(0xFF64748B),
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

          const SizedBox(height: 5),

          // 4. Membership Progress Row & Animated Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
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
                  color: const Color(0xFFFBBF24).withValues(alpha: isDark ? 0.2 : 0.35),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '73%',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontWeight: FontWeight.w900,
                    fontSize: 9,
                    color: Color(0xFFB45309),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 3),

          // Progress Bar Track
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: SizedBox(
              height: 4.5,
              child: LinearProgressIndicator(
                value: data.usedPercentage,
                backgroundColor: isDark
                    ? const Color(0xFF262A3B)
                    : const Color(0xFFE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFEAB308),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
