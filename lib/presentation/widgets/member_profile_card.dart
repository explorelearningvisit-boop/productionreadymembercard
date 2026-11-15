import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class MemberProfileCard extends StatelessWidget {
  final MemberIntelligenceData data;
  final VoidCallback? onRenewPressed;
  final VoidCallback? onPaymentDetailsPressed;
  final VoidCallback? onQrPassPressed;
  final VoidCallback? onBackPressed;
  final VoidCallback? onCheckInPressed;
  final VoidCallback? onNotificationPressed;

  const MemberProfileCard({
    super.key,
    required this.data,
    this.onRenewPressed,
    this.onPaymentDetailsPressed,
    this.onQrPassPressed,
    this.onBackPressed,
    this.onCheckInPressed,
    this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE50914), Color(0xFFB80016), Color(0xFF76000D)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFFF8794), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Top Row: Avatar + Name & Demographics + Badges
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circle Avatar
              InkWell(
                key: const ValueKey('member_avatar_button'),
                onTap: () {
                  HapticFeedback.lightImpact();
                  onQrPassPressed?.call();
                },
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFF9AA6),
                      width: 1.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 6,
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
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Name + ID | Age | Gender
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
                        fontSize: 16,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.2,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 3),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.badge_outlined,
                            size: 13,
                            color: Color(0xFF64748B),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            data.memberId,
                            style: const TextStyle(
                              fontFamily: BadGymTypography.fontHeading,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                              color: Color(0xFF475569),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '|',
                            style: TextStyle(
                              color: Color(0xFFCBD5E1),
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.person_outline_rounded,
                            size: 13,
                            color: Color(0xFF64748B),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${data.age} Yrs',
                            style: const TextStyle(
                              fontFamily: BadGymTypography.fontBody,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: Color(0xFF475569),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '|',
                            style: TextStyle(
                              color: Color(0xFFCBD5E1),
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '♂ ${data.gender}',
                            style: const TextStyle(
                              fontFamily: BadGymTypography.fontBody,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: Color(0xFF475569),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF22C55E),
                          Color(0xFF16A34A),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF22C55E).withValues(alpha: 0.35),
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
                          size: 12,
                          color: Colors.white,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Active',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontHeading,
                            fontWeight: FontWeight.w800,
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Gold Plan Pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFFDF7A),
                          Color(0xFFFFB300),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFB300).withValues(alpha: 0.3),
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
                          size: 11,
                          color: Color(0xFF5D3800),
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Gold Plan',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontHeading,
                            fontWeight: FontWeight.w800,
                            fontSize: 10,
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

          const SizedBox(height: 10),

          // 2. Middle Row: Two Sub-Cards with Right Chevrons (Payment ₹500 Due | 8 Days Left)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFF8F0010),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFFF697B),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Left Stat Box: Payment ₹500 Due
                Expanded(
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onPaymentDetailsPressed?.call();
                    },
                    child: Row(
                      children: [
                        // Red Wallet Icon Container
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB90018),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFFF9AA6),
                              width: 0.8,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.account_balance_wallet_rounded,
                              color: Color(0xFFD6001C),
                              size: 18,
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
                                'Payment',
                                style: TextStyle(
                                  fontFamily: BadGymTypography.fontBody,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: Color(0xFF64748B),
                                  height: 1.0,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '₹500 Due',
                                style: TextStyle(
                                  fontFamily: BadGymTypography.fontHeading,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 13,
                                  color: Color(0xFFD6001C),
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: Color(0xFF94A3B8),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),

                // Vertical Divider
                Container(
                  width: 1,
                  height: 32,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: const Color(0xFFE2E8F0),
                ),

                // Right Stat Box: 8 Days Left | Expires: 24 Oct 2026
                Expanded(
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onRenewPressed?.call();
                    },
                    child: Row(
                      children: [
                        // Red Calendar Icon Container
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFECEF),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFFFCCD3),
                              width: 0.8,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.calendar_month_rounded,
                              color: Color(0xFFD6001C),
                              size: 18,
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
                                '${data.daysLeft} Days Left',
                                style: const TextStyle(
                                  fontFamily: BadGymTypography.fontHeading,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 13,
                                  color: Color(0xFF0F172A),
                                  height: 1.1,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Expires: ${data.renewDate}',
                                style: const TextStyle(
                                  fontFamily: BadGymTypography.fontBody,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9,
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
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 3. Bottom Row: Membership 22 / 30 Days + Yellow Angled 73% Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Membership ${data.daysUsed} / ${data.totalDays} Days',
                style: const TextStyle(
                  fontFamily: BadGymTypography.fontHeading,
                  fontWeight: FontWeight.w800,
                  fontSize: 11.5,
                  color: Color(0xFF1E293B),
                ),
              ),
              // Yellow Slanted Badge with 73%
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFDF00),
                      Color(0xFFFFB800),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFB800).withValues(alpha: 0.4),
                      blurRadius: 4,
                      offset: const Offset(0, 1.5),
                    ),
                  ],
                ),
                child: const Text(
                  '73%',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontWeight: FontWeight.w900,
                    fontSize: 11.5,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          // 4. Vibrant Golden-Yellow Progress Bar
          Container(
            height: 9,
            decoration: BoxDecoration(
              color: const Color(0xFF68000A),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 0.8,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.5),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.73,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFE600),
                            Color(0xFFFFB800),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFB800).withValues(alpha: 0.8),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
