import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';
import 'package:bad_gym/presentation/widgets/attendance_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/body_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/member_profile_card.dart';
import 'package:bad_gym/presentation/widgets/member_qr_sheet.dart';
import 'package:bad_gym/presentation/widgets/notification_sheet.dart';
import 'package:bad_gym/presentation/widgets/payment_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/quick_stats_row.dart';
import 'package:bad_gym/presentation/widgets/renewal_sheet.dart';
import 'package:bad_gym/presentation/widgets/top_header_bar.dart';
import 'package:bad_gym/presentation/widgets/vertical_navigation_rail.dart';
import 'package:bad_gym/presentation/widgets/workout_intelligence_card.dart';

class MemberCheckInScreen extends StatefulWidget {
  final MemberIntelligenceData? initialData;

  const MemberCheckInScreen({
    super.key,
    this.initialData,
  });

  @override
  State<MemberCheckInScreen> createState() => _MemberCheckInScreenState();
}

class _MemberCheckInScreenState extends State<MemberCheckInScreen> {
  late final MemberIntelligenceData _data;
  final ScrollController _scrollController = ScrollController();
  RailTab _selectedRailTab = RailTab.intelligence;
  QuickStatTab _selectedStatTab = QuickStatTab.attendance;

  @override
  void initState() {
    super.initState();
    _data = widget.initialData ?? MemberIntelligenceData.ashwaniKumarSingh;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onRailTabSelected(RailTab tab) {
    HapticFeedback.selectionClick();
    if (tab == RailTab.more) {
      NotificationSheet.show(context);
      return;
    }

    setState(() {
      _selectedRailTab = tab;
      switch (tab) {
        case RailTab.intelligence:
        case RailTab.calendar:
        case RailTab.history:
        case RailTab.trend:
          _selectedStatTab = QuickStatTab.attendance;
          break;
        case RailTab.workout:
          _selectedStatTab = QuickStatTab.workout;
          break;
        case RailTab.payment:
        case RailTab.reports:
          _selectedStatTab = QuickStatTab.payment;
          break;
        case RailTab.body:
        case RailTab.goals:
          _selectedStatTab = QuickStatTab.body;
          break;
        default:
          break;
      }
    });
  }

  void _onStatTabSelected(QuickStatTab tab) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedStatTab = tab;
      switch (tab) {
        case QuickStatTab.attendance:
          _selectedRailTab = RailTab.intelligence;
          break;
        case QuickStatTab.workout:
          _selectedRailTab = RailTab.workout;
          break;
        case QuickStatTab.payment:
          _selectedRailTab = RailTab.payment;
          break;
        case QuickStatTab.body:
          _selectedRailTab = RailTab.body;
          break;
      }
    });
  }

  Widget _buildIntelligenceCard() {
    switch (_selectedStatTab) {
      case QuickStatTab.attendance:
        return AttendanceIntelligenceCard(
          key: const ValueKey('attendance_card'),
          data: _data,
          onMonthDropdownPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('October 2026 selected'),
                backgroundColor: BadGymColors.primary,
                duration: Duration(seconds: 2),
              ),
            );
          },
          onInfoPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Attendance Intelligence: 25 / 31 Days (81%)'),
                backgroundColor: BadGymColors.primary,
                duration: Duration(seconds: 2),
              ),
            );
          },
        );
      case QuickStatTab.workout:
        return WorkoutIntelligenceCard(
          key: const ValueKey('workout_card'),
          data: _data,
        );
      case QuickStatTab.payment:
        return PaymentIntelligenceCard(
          key: const ValueKey('payment_card'),
          data: _data,
          onRenewPressed: () => RenewalSheet.show(context, _data),
        );
      case QuickStatTab.body:
        return BodyIntelligenceCard(
          key: const ValueKey('body_card'),
          data: _data,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF3F5),
              Color(0xFFFFFFFF),
            ],
            stops: [0.0, 0.40],
          ),
        ),
        child: Stack(
          children: [
            // 1. Background Liquid Waves Graphic (Top subtle cover)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 220,
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  'assets/backgrounds/bg_waves.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),

            // 2. Main Content inside SafeArea
            SafeArea(
              child: Column(
                children: [
                  // Top Header Bar: Back | CHECK-IN | 07:12 AM / 16 Oct 2026 | Bell 3
                  TopHeaderBar(
                    data: _data,
                    onNotificationPressed: () => NotificationSheet.show(context),
                    onAvatarPressed: () => MemberQrSheet.show(context, _data),
                    onMorePressed: () => RenewalSheet.show(context, _data),
                    onCheckInPressed: () => MemberQrSheet.show(context, _data),
                    onBackPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('BAD GYM Dashboard Active'),
                          backgroundColor: BadGymColors.primary,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),

                  // Scrollable Body
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 85),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Member Profile Card (Red Strawberry Theme Header Card)
                          MemberProfileCard(
                            data: _data,
                            onRenewPressed: () => RenewalSheet.show(context, _data),
                            onPaymentDetailsPressed: () => _onStatTabSelected(QuickStatTab.payment),
                            onQrPassPressed: () => MemberQrSheet.show(context, _data),
                          ),

                          const SizedBox(height: 6),

                          // 4 Quick Stats Row (Attendance 81% | Workout 58 min | Payment Due | Body 69.5 kg)
                          QuickStatsRow(
                            data: _data,
                            selectedTab: _selectedStatTab,
                            onTabSelected: _onStatTabSelected,
                          ),

                          const SizedBox(height: 8),

                          // Two-Column Section: Left Vertical Rail + Right Intelligence Content
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left 5-Item Vertical Navigation Rail
                                VerticalNavigationRail(
                                  selectedTab: _selectedRailTab,
                                  onTabSelected: _onRailTabSelected,
                                ),

                                const SizedBox(width: 8),

                                // Right Dynamic Intelligence Card (Default: Attendance Intelligence + Calendar)
                                Expanded(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 250),
                                    switchInCurve: Curves.easeOut,
                                    switchOutCurve: Curves.easeIn,
                                    child: _buildIntelligenceCard(),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 3. Bottom Screen Berries & Wave Decoration
            // A. Sweeping Red Liquid Wave Crest across bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 48,
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _BottomLiquidWavePainter(),
                ),
              ),
            ),

            // B. Bottom-Left Fresh Strawberry & Blackberry Cluster
            Positioned(
              bottom: 0,
              left: -4,
              child: IgnorePointer(
                child: Image.asset(
                  'assets/decorations/bottom_strawberries.png',
                  height: 68,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),

            // C. Bottom-Right Fresh Blueberries & Mint Leaves Cluster
            Positioned(
              bottom: 0,
              right: 0,
              child: IgnorePointer(
                child: Image.asset(
                  'assets/decorations/bottom_blueberries.png',
                  height: 56,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomLiquidWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(0, h * 0.42)
      ..cubicTo(w * 0.25, h * 0.72, w * 0.65, h * 0.22, w, h * 0.48)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFE50914),
          Color(0xFFB30710),
          Color(0xFF7A0208),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawPath(path, paint);

    // Specular highlight on wave crest
    final crestPath = Path()
      ..moveTo(0, h * 0.42)
      ..cubicTo(w * 0.25, h * 0.72, w * 0.65, h * 0.22, w, h * 0.48);

    final crestPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = const LinearGradient(
        colors: [
          Color(0x88FF4D6D),
          Color(0xEEFFFFFF),
          Color(0x88FF4D6D),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawPath(crestPath, crestPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
