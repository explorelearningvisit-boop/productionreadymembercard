import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/presentation/widgets/merged_member_card.dart';
import 'package:bad_gym/presentation/widgets/member_qr_sheet.dart';
import 'package:bad_gym/presentation/widgets/notification_sheet.dart';
import 'package:bad_gym/presentation/widgets/payment_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/quick_stats_row.dart';
import 'package:bad_gym/presentation/widgets/renewal_sheet.dart';
import 'package:bad_gym/presentation/widgets/vertical_navigation_rail.dart';
import 'package:bad_gym/presentation/widgets/workout_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/body_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/attendance_trend_container_card.dart';
import 'package:bad_gym/presentation/widgets/smart_insight_banner.dart';
import 'package:bad_gym/presentation/widgets/bottom_stats_strip.dart';

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

  RailTab _selectedRailTab = RailTab.home;
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
        case RailTab.home:
        case RailTab.intelligence:
        case RailTab.overview:
        case RailTab.attendance:
        case RailTab.calendar:
        case RailTab.history:
        case RailTab.trend:
        case RailTab.progress:
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
        case RailTab.members:
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
          _selectedRailTab = RailTab.home;
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

  Widget _buildSelectedTabContent() {
    // If Workout or Body or Payment is actively selected, show its specialized view
    if (_selectedStatTab == QuickStatTab.workout || _selectedRailTab == RailTab.workout) {
      return WorkoutIntelligenceCard(
        key: const ValueKey('workout_card'),
        data: _data,
      );
    }
    if (_selectedStatTab == QuickStatTab.payment || _selectedRailTab == RailTab.payment) {
      return PaymentIntelligenceCard(
        key: const ValueKey('payment_card'),
        data: _data,
        onRenewPressed: () => RenewalSheet.show(context, _data),
      );
    }
    if (_selectedStatTab == QuickStatTab.body || _selectedRailTab == RailTab.body) {
      return BodyIntelligenceCard(
        key: const ValueKey('body_card'),
        data: _data,
      );
    }

    // Default Home / Attendance Dashboard Layout (Pixel-Perfect from reference)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 3. Attendance Trend Spline Chart Card
        AttendanceTrendContainerCard(
          key: const ValueKey('attendance_trend_card'),
          data: _data,
        ),

        const SizedBox(height: 3),

        // 4. Smart Insight Banner (AI Powered with 3D gym gear)
        SmartInsightBanner(
          onTap: () {
            NotificationSheet.show(context);
          },
        ),

        const SizedBox(height: 3),

        // 5. Bottom 4-Item Quick Metric Strip
        const BottomStatsStrip(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EF),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF9EF),
              Color(0xFFFDF6E8),
              Color(0xFFFBF1DF),
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Full-Height Left Navigation Rail
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 3, 4),
                child: VerticalNavigationRail(
                  selectedTab: _selectedRailTab,
                  onTabSelected: _onRailTabSelected,
                ),
              ),

              // 2. Right Main Scrollable Content Area
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(2, 4, 6, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // A. Merged Member Profile & Check-In Hero Ribbon
                      MergedMemberCard(
                        data: _data,
                        onNotificationPressed: () => NotificationSheet.show(context),
                        onPaymentDetailsPressed: () => _onStatTabSelected(QuickStatTab.payment),
                        onRenewPressed: () => RenewalSheet.show(context, _data),
                        onQrPassPressed: () => MemberQrSheet.show(context, _data),
                        onCheckInPressed: () {
                          MemberQrSheet.show(context, _data);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Checked In successfully at BAD GYM! 🔥'),
                              backgroundColor: Color(0xFF8B0000),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),

                      // B. Quick Stats 3-Card Row (Attendance, Workout, Body)
                      QuickStatsRow(
                        data: _data,
                        selectedTab: _selectedStatTab,
                        onTabSelected: _onStatTabSelected,
                      ),

                      const SizedBox(height: 3),

                      // C. Tab / Section Content (Attendance Trend, Smart Insight, Bottom Strip)
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: KeyedSubtree(
                          key: ValueKey('$_selectedStatTab$_selectedRailTab'),
                          child: _buildSelectedTabContent(),
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
    );
  }
}
