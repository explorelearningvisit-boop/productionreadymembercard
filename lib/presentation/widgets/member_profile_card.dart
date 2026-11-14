import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class MemberProfileCard extends StatelessWidget {
  final MemberIntelligenceData data;
  final VoidCallback? onRenewPressed;
  final VoidCallback? onPaymentDetailsPressed;
  final VoidCallback? onQrPassPressed;

  const MemberProfileCard({
    super.key,
    required this.data,
    this.onRenewPressed,
    this.onPaymentDetailsPressed,
    this.onQrPassPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFC7001B),
            Color(0xFF9E0014),
            Color(0xFF5E0008),
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: const Color(0xFFFF5268).withValues(alpha: 0.65),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBA0018).withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 3D Metallic Dumbbell with Neon Halo at Top Right
          Positioned(
            top: 4,
            right: 8,
            child: IgnorePointer(
              child: Image.asset(
                'assets/graphics/dumbbell_halo.png',
                width: 86,
                height: 68,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Top Row: Avatar + Info & Badges
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Avatar with Glowing White Frame
                    InkWell(
                      key: const ValueKey('member_avatar_button'),
                      onTap: () {
                        HapticFeedback.lightImpact();
                        onQrPassPressed?.call();
                      },
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        width: 66,
                        height: 66,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.white,
                            width: 2.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/avatar_ashwini.png',
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Athlete Name, ID, Age, Gender & Badges
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Name
                          Text(
                            data.name,
                            style: const TextStyle(
                              fontFamily: BadGymTypography.fontHeading,
                              fontWeight: FontWeight.w800,
                              fontSize: 16.5,
                              color: Colors.white,
                              letterSpacing: 0.2,
                              height: 1.15,
                            ),
                          ),
                          const SizedBox(height: 2),

                          // ID | Age | Gender
                          Text(
                            '${data.memberId}  |  ${data.age} Yrs  |  ♂ ${data.gender}',
                            style: TextStyle(
                              fontFamily: BadGymTypography.fontBody,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.90),
                              letterSpacing: -0.1,
                            ),
                          ),
                          const SizedBox(height: 5),

                          // Badges Row: Active + Gold Plan
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Active Badge (Green Pill)
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
                                        color: const Color(0xFF22C55E).withValues(alpha: 0.4),
                                        blurRadius: 4,
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

                                const SizedBox(width: 6),

                                // Gold Plan Badge (Golden Gradient Pill)
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
                                        color: Colors.black.withValues(alpha: 0.15),
                                        blurRadius: 4,
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
                          ),
                        ],
                      ),
                    ),

                    // Spacer to account for dumbbell halo on right
                    const SizedBox(width: 50),
                  ],
                ),

                const SizedBox(height: 12),

                // 2. Middle Row: Two White Pill Cards (Payment & Days Left)
                Row(
                  children: [
                    // Card 1: Payment ₹500 Due
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          onPaymentDetailsPressed?.call();
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Red Wallet Icon Container
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFECEF),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
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
                                        fontSize: 9.5,
                                        color: Color(0xFF6B7280),
                                        height: 1.0,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '₹500 Due',
                                      style: TextStyle(
                                        fontFamily: BadGymTypography.fontHeading,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12.5,
                                        color: Color(0xFFD6001C),
                                        height: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Card 2: 8 Days Left | Expires: 24 Oct 2026
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          onRenewPressed?.call();
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Red Calendar Icon Container
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFECEF),
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
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
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12.5,
                                        color: Color(0xFF1F2937),
                                        height: 1.1,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Expires: ${data.renewDate}',
                                      style: const TextStyle(
                                        fontFamily: BadGymTypography.fontBody,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 8.5,
                                        color: Color(0xFF6B7280),
                                        height: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // 3. Bottom Row: Membership Progress
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Membership ${data.daysUsed} / ${data.totalDays} Days',
                      style: const TextStyle(
                        fontFamily: BadGymTypography.fontBody,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      '73%',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontWeight: FontWeight.w900,
                        fontSize: 12.5,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // Glowing Strawberry-Red Progress Bar
                Container(
                  height: 9,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A0308),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.73,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF334B),
                            Color(0xFFFF8595),
                            Colors.white,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFFF334B),
                            blurRadius: 6,
                            offset: Offset(0, 0),
                          ),
                        ],
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
