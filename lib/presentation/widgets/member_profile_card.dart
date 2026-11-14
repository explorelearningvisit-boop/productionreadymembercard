import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class MemberProfileCard extends StatefulWidget {
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
  State<MemberProfileCard> createState() => _MemberProfileCardState();
}

class _MemberProfileCardState extends State<MemberProfileCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    if (!WidgetsBinding.instance.runtimeType.toString().contains('Test')) {
      _animController.repeat(reverse: true);
    } else {
      _animController.value = 0.5;
    }

    _floatAnim = Tween<double>(begin: -3.5, end: 3.5).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Container(
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
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFFF5268).withValues(alpha: 0.65),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBA0018).withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Animated Floating 3D Metallic Dumbbell with Neon Halo at Top Right
          Positioned(
            top: 42,
            right: 6,
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _floatAnim,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _floatAnim.value),
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/graphics/dumbbell_halo.png',
                  width: 82,
                  height: 64,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Integrated Top Header: Back | CHECK-IN | 07:12 AM / 16 Oct 2026 | Bell (3)
                _buildIntegratedTopHeader(context),

                const SizedBox(height: 8),

                // 2. Member Info Row: Avatar + Details & Badges
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Avatar with Glowing White Frame
                    InkWell(
                      key: const ValueKey('member_avatar_button'),
                      onTap: () {
                        HapticFeedback.lightImpact();
                        widget.onQrPassPressed?.call();
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            'assets/images/avatar_ashwini.png',
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

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
                              fontSize: 15.5,
                              color: Colors.white,
                              letterSpacing: 0.2,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 2),

                          // ID | Age | Gender
                          Text(
                            '${data.memberId}  |  ${data.age} Yrs  |  ♂ ${data.gender}',
                            style: TextStyle(
                              fontFamily: BadGymTypography.fontBody,
                              fontWeight: FontWeight.w500,
                              fontSize: 10.5,
                              color: Colors.white.withValues(alpha: 0.90),
                              letterSpacing: -0.1,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Badges Row: Active + Gold Plan
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Active Badge (Green Pill)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2.5),
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
                                        color: const Color(0xFF22C55E)
                                            .withValues(alpha: 0.4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_rounded,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 2.5),
                                      Text(
                                        'Active',
                                        style: TextStyle(
                                          fontFamily:
                                              BadGymTypography.fontHeading,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 9.5,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 5),

                                // Gold Plan Badge (Golden Gradient Pill)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2.5),
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
                                        color: Colors.black
                                            .withValues(alpha: 0.15),
                                        blurRadius: 4,
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
                                          fontFamily:
                                              BadGymTypography.fontHeading,
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
                          ),
                        ],
                      ),
                    ),

                    // Spacer for top-right dumbbell
                    const SizedBox(width: 48),
                  ],
                ),

                const SizedBox(height: 8),

                // 3. Middle Row: Two White Pill Cards (Payment & Days Left)
                Row(
                  children: [
                    // Card 1: Payment ₹500 Due
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          widget.onPaymentDetailsPressed?.call();
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 1.5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 26,
                                height: 26,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFECEF),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.account_balance_wallet_rounded,
                                    color: Color(0xFFD6001C),
                                    size: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Payment',
                                      style: TextStyle(
                                        fontFamily: BadGymTypography.fontBody,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9,
                                        color: Color(0xFF6B7280),
                                        height: 1.0,
                                      ),
                                    ),
                                    SizedBox(height: 1.5),
                                    Text(
                                      '₹500 Due',
                                      style: TextStyle(
                                        fontFamily:
                                              BadGymTypography.fontHeading,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12,
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

                    const SizedBox(width: 6),

                    // Card 2: 8 Days Left | Expires: 24 Oct 2026
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          widget.onRenewPressed?.call();
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 1.5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 26,
                                height: 26,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFECEF),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.calendar_month_rounded,
                                    color: Color(0xFFD6001C),
                                    size: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${data.daysLeft} Days Left',
                                      style: const TextStyle(
                                        fontFamily:
                                              BadGymTypography.fontHeading,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: Color(0xFF1F2937),
                                        height: 1.1,
                                      ),
                                    ),
                                    const SizedBox(height: 1.5),
                                    Text(
                                      'Expires: ${data.renewDate}',
                                      style: const TextStyle(
                                        fontFamily: BadGymTypography.fontBody,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 8,
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

                const SizedBox(height: 8),

                // 4. Membership Progress (High Contrast Neon Lime / Gold)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Membership ${data.daysUsed} / ${data.totalDays} Days',
                      style: const TextStyle(
                        fontFamily: BadGymTypography.fontBody,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.5,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      '73%',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        color: Color(0xFF4ADE80), // Neon Lime highlight
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // High-Contrast Neon Lime & Gold Glow Progress Bar
                Container(
                  height: 9,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.25),
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
                                  Color(0xFF22C55E), // Emerald Green
                                  Color(0xFF4ADE80), // Neon Lime
                                  Color(0xFFFFD700), // Glowing Gold Accent
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4ADE80)
                                      .withValues(alpha: 0.8),
                                  blurRadius: 8,
                                  spreadRadius: 1,
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
          ),
        ],
      ),
    );
  }

  Widget _buildIntegratedTopHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Back Chevron Button
        InkWell(
          key: const ValueKey('header_back_button'),
          onTap: () {
            HapticFeedback.lightImpact();
            if (widget.onBackPressed != null) {
              widget.onBackPressed!();
            } else if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          borderRadius: BorderRadius.circular(11),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF8B0012),
                  Color(0xFF4A0008),
                ],
              ),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: const Color(0xFFFF5268).withValues(alpha: 0.5),
                width: 1.0,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 13,
              ),
            ),
          ),
        ),

        const SizedBox(width: 6),

        // 2. CHECK-IN Button (Neon Emerald Green Pill)
        InkWell(
          key: const ValueKey('header_checkin_button'),
          onTap: () {
            HapticFeedback.mediumImpact();
            widget.onCheckInPressed?.call();
          },
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF22C55E),
                  Color(0xFF16A34A),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF86EFAC),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF22C55E).withValues(alpha: 0.55),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 14,
                ),
                SizedBox(width: 4),
                Text(
                  'CHECK-IN',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    color: Colors.white,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
        ),

        const Spacer(),

        // 3. Time & Date (07:12 AM | 16 Oct 2026)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
              width: 0.8,
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '07:12 AM',
                style: TextStyle(
                  fontFamily: BadGymTypography.fontHeading,
                  fontWeight: FontWeight.w800,
                  fontSize: 11.5,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 1),
              Text(
                '16 Oct 2026',
                style: TextStyle(
                  fontFamily: BadGymTypography.fontBody,
                  fontWeight: FontWeight.w500,
                  fontSize: 8.5,
                  color: Color(0xFFFFD2D9),
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 6),

        // 4. Notification Bell Button with Badge '3'
        InkWell(
          key: const ValueKey('header_notification_button'),
          onTap: () {
            HapticFeedback.lightImpact();
            widget.onNotificationPressed?.call();
          },
          borderRadius: BorderRadius.circular(11),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF8B0012),
                  Color(0xFF4A0008),
                ],
              ),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: const Color(0xFFFF5268).withValues(alpha: 0.5),
                width: 1.0,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications_rounded,
                  color: Colors.white,
                  size: 15,
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB300),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF6B000B),
                        width: 1.2,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w900,
                          fontSize: 7.5,
                          color: Color(0xFF380005),
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
    );
  }
}
