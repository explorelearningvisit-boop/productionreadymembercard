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
          _selectedStatTab = QuickStatTab.payment;
          break;
        case RailTab.reports:
          _selectedStatTab = QuickStatTab.attendance;
          break;
        case RailTab.body:
        case RailTab.goals:
          _selectedStatTab = QuickStatTab.body;
          break;
        case RailTab.members:
          _selectedStatTab = QuickStatTab.attendance;
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

    // Attendance is the default compact intelligence canvas.
    return AttendanceTrendContainerCard(
      key: const ValueKey('attendance_trend_card'),
      data: _data,
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
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(4, 2, 4, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header and member identity use the full mobile width.
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
                        content: Text('Attendance sync is not connected yet. No check-in was recorded.'),
                        backgroundColor: Color(0xFF8B0000),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),

                // Four compact, equal-width intelligence shortcuts.
                QuickStatsRow(
                  data: _data,
                  selectedTab: _selectedStatTab,
                  onTabSelected: _onStatTabSelected,
                ),

                const SizedBox(height: 4),

                // The rail starts below the four horizontal tabs and only
                // spans the active intelligence canvas height.
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      VerticalNavigationRail(
                        selectedTab: _selectedRailTab,
                        onTabSelected: _onRailTabSelected,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: KeyedSubtree(
                            key: ValueKey('$_selectedStatTab$_selectedRailTab'),
                            child: _buildSelectedTabContent(),
                          ),
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
    );
  }
}
