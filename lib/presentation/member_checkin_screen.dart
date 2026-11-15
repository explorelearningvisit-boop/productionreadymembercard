import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';
import 'package:bad_gym/presentation/widgets/attendance_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/body_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/bottom_promo_banner.dart';
import 'package:bad_gym/presentation/widgets/checkin_hero_banner.dart';
import 'package:bad_gym/presentation/widgets/member_profile_card.dart';
import 'package:bad_gym/presentation/widgets/member_qr_sheet.dart';
import 'package:bad_gym/presentation/widgets/notification_sheet.dart';
import 'package:bad_gym/presentation/widgets/payment_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/quick_stats_row.dart';
import 'package:bad_gym/presentation/widgets/renewal_sheet.dart';
import 'package:bad_gym/presentation/widgets/top_brand_bar.dart';
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
    const double kIntelligenceSectionHeight = 358.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFFE7A0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFD34E),
              Color(0xFFFFE8A0),
              Color(0xFFFFF6D9),
              Color(0xFFFFF9EC),
            ],
            stops: [0.0, 0.12, 0.28, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. Top Header: Hamburger | BAD GYM Laurel Crest | 07:12 AM / 16 Oct 2026 | Bell 3
              TopBrandBar(
                data: _data,
                onMenuPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('BAD GYM Menu Active'),
                      backgroundColor: BadGymColors.primary,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                onNotificationPressed: () => NotificationSheet.show(context),
                onCalendarPressed: () => _onStatTabSelected(QuickStatTab.attendance),
              ),

              // Scrollable Dashboard Body
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 2. Check-In Success Hero Banner with Athlete & Weights
                      CheckInHeroBanner(
                        data: _data,
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
                      ),

                      // 3. Ashwani Kumar Singh Member Profile Card (White Card)
                      MemberProfileCard(
                        data: _data,
                        onPaymentDetailsPressed: () => _onStatTabSelected(QuickStatTab.payment),
                        onRenewPressed: () => RenewalSheet.show(context, _data),
                        onQrPassPressed: () => MemberQrSheet.show(context, _data),
                      ),

                      // 4. 4 Quick Stats Buttons (Attendance 81% Red Card, Workout 58 min, Payment Due, Body 69.5 kg)
                      QuickStatsRow(
                        data: _data,
                        selectedTab: _selectedStatTab,
                        onTabSelected: _onStatTabSelected,
                      ),

                      const SizedBox(height: 4),

                      // 5. Two-Column Intelligence Section (Fixed 358px Height - Zero Jitter)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          height: kIntelligenceSectionHeight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Left Column: Vertical Navigation Rail (Fixed Height 358)
                              VerticalNavigationRail(
                                height: kIntelligenceSectionHeight,
                                selectedTab: _selectedRailTab,
                                onTabSelected: _onRailTabSelected,
                              ),

                              const SizedBox(width: 6),

                              // Right Column: Dynamic Intelligence Card Viewport
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    switchInCurve: Curves.easeOut,
                                    switchOutCurve: Curves.easeIn,
                                    child: SizedBox(
                                      key: ValueKey(_selectedStatTab),
                                      height: kIntelligenceSectionHeight,
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
                      ),

                      const SizedBox(height: 6),

                      // 6. Bottom Promotional Banner: FITNESS NUTRITION - PROTEIN BURGER
                      BottomPromoBanner(
                        onOrderPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Order placed for Protein Burger! 50% OFF applied! 🍔'),
                              backgroundColor: Color(0xFFD6001C),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
