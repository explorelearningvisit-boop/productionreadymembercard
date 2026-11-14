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

class _MemberCheckInScreenState extends State<MemberCheckInScreen>
    with SingleTickerProviderStateMixin {
  late final MemberIntelligenceData _data;
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _berryAnimController;
  late final Animation<double> _berrySway;

  RailTab _selectedRailTab = RailTab.intelligence;
  QuickStatTab _selectedStatTab = QuickStatTab.attendance;

  @override
  void initState() {
    super.initState();
    _data = widget.initialData ?? MemberIntelligenceData.ashwaniKumarSingh;

    _berryAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
    if (!WidgetsBinding.instance.runtimeType.toString().contains('Test')) {
      _berryAnimController.repeat(reverse: true);
    } else {
      _berryAnimController.value = 0.5;
    }

    _berrySway = Tween<double>(begin: -3.0, end: 3.0).animate(
      CurvedAnimation(
        parent: _berryAnimController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _berryAnimController.dispose();
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
      backgroundColor: const Color(0xFFF9FAFB),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF1F3),
              Color(0xFFFFFFFF),
            ],
            stops: [0.0, 0.45],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 🌟 THE UNIFIED MEMBER INTELLIGENCE CARD CONTAINER 🌟
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(
                      color: const Color(0xFFFFCAD4),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFBA0018).withValues(alpha: 0.14),
                        blurRadius: 20,
                        spreadRadius: 1,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Inner Card Content
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 1. Member Profile Card (With Integrated Top Header: Back, CHECK-IN, Time/Date, Bell)
                            MemberProfileCard(
                              data: _data,
                              onBackPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('BAD GYM Dashboard Active'),
                                    backgroundColor: BadGymColors.primary,
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              onCheckInPressed: () {
                                MemberQrSheet.show(context, _data);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Checked In successfully at BAD GYM! 🔥'),
                                    backgroundColor: BadGymColors.primary,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              onNotificationPressed: () =>
                                  NotificationSheet.show(context),
                              onRenewPressed: () =>
                                  RenewalSheet.show(context, _data),
                              onPaymentDetailsPressed: () =>
                                  _onStatTabSelected(QuickStatTab.payment),
                              onQrPassPressed: () =>
                                  MemberQrSheet.show(context, _data),
                            ),

                            const SizedBox(height: 6),

                            // 2. Compact 4 Quick Stats Row
                            QuickStatsRow(
                              data: _data,
                              selectedTab: _selectedStatTab,
                              onTabSelected: _onStatTabSelected,
                            ),

                            const SizedBox(height: 6),

                            // 3. Two-Column Section with Stable Fixed-Height Viewport (Zero Jitter)
                            SizedBox(
                              height: 358,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Left Vertical Navigation Rail (Fixed Height 358)
                                  VerticalNavigationRail(
                                    height: 358,
                                    selectedTab: _selectedRailTab,
                                    onTabSelected: _onRailTabSelected,
                                  ),

                                  const SizedBox(width: 6),

                                  // Right Dynamic Intelligence Card Viewport (Fixed Height 358, Internally Scrollable)
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 200),
                                        switchInCurve: Curves.easeOut,
                                        switchOutCurve: Curves.easeIn,
                                        child: SizedBox(
                                          key: ValueKey(_selectedStatTab),
                                          height: 358,
                                          child: SingleChildScrollView(
                                            physics: const BouncingScrollPhysics(),
                                            child: _buildIntelligenceCard(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ),

                      // Animated Floating Strawberries & Blackberries at Bottom-Left of Card
                      Positioned(
                        bottom: -10,
                        left: -6,
                        child: IgnorePointer(
                          child: AnimatedBuilder(
                            animation: _berrySway,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, _berrySway.value),
                                child: child,
                              );
                            },
                            child: Image.asset(
                              'assets/decorations/bottom_strawberries.png',
                              height: 52,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const SizedBox(),
                            ),
                          ),
                        ),
                      ),

                      // Animated Floating Blueberries & Mint at Bottom-Right of Card
                      Positioned(
                        bottom: -8,
                        right: -4,
                        child: IgnorePointer(
                          child: AnimatedBuilder(
                            animation: _berrySway,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, -_berrySway.value),
                                child: child,
                              );
                            },
                            child: Image.asset(
                              'assets/decorations/bottom_blueberries.png',
                              height: 44,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const SizedBox(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
