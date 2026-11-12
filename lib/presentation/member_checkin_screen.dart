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
import 'package:bad_gym/presentation/widgets/promo_banner_widget.dart';
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
  bool _isHeaderCollapsed = false;

  @override
  void initState() {
    super.initState();
    _data = widget.initialData ?? MemberIntelligenceData.ashwaniKumarSingh;
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final collapsed = _scrollController.hasClients && _scrollController.offset > 45;
    if (collapsed != _isHeaderCollapsed) {
      setState(() {
        _isHeaderCollapsed = collapsed;
      });
    }
  }

  void _onRailTabSelected(RailTab tab) {
    HapticFeedback.selectionClick();
    if (tab == RailTab.offers) {
      RenewalSheet.show(context, _data);
      return;
    }
    if (tab == RailTab.more) {
      NotificationSheet.show(context);
      return;
    }

    setState(() {
      _selectedRailTab = tab;
      switch (tab) {
        case RailTab.intelligence:
        case RailTab.attendance:
        case RailTab.calendar:
        case RailTab.history:
        case RailTab.trend:
        case RailTab.streak:
        case RailTab.analysis:
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

  void _scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + 260,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
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
                backgroundColor: BadGymColors.purpleCardStart,
                duration: Duration(seconds: 2),
              ),
            );
          },
          onInfoPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Attendance Intelligence Calculation: 25 / 31 Days (81%)'),
                backgroundColor: BadGymColors.purpleCardStart,
                duration: Duration(seconds: 2),
              ),
            );
          },
          onScrollDownPressed: _scrollDown,
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
      backgroundColor: BadGymColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Sleek Royal Purple Top Header Bar (Dual-state: Brand Header when top, Checked-In pill when scrolled)
            TopHeaderBar(
              data: _data,
              isCollapsed: _isHeaderCollapsed,
              onNotificationPressed: () => NotificationSheet.show(context),
              onAvatarPressed: () => MemberQrSheet.show(context, _data),
              onMorePressed: () => RenewalSheet.show(context, _data),
            ),

            // 2. Scrollable Body
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(4, 2, 4, 16),
                child: Column(
                  children: [
                    // Member VIP Check-In Pass Card (Interactive QR pass & Renewal)
                    MemberProfileCard(
                      data: _data,
                      onRenewPressed: () => RenewalSheet.show(context, _data),
                      onPaymentDetailsPressed: () => _onStatTabSelected(QuickStatTab.payment),
                      onQrPassPressed: () => MemberQrSheet.show(context, _data),
                    ),

                    const SizedBox(height: 8),

                    // 4 Quick Stats Row Spanning Full Width (Dynamic tab switching)
                    QuickStatsRow(
                      data: _data,
                      selectedTab: _selectedStatTab,
                      onTabSelected: _onStatTabSelected,
                    ),

                    const SizedBox(height: 8),

                    // Two-Column Section: Left Rail + Dynamic Right Intelligence Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Vertical Navigation Rail
                          VerticalNavigationRail(
                            selectedTab: _selectedRailTab,
                            onTabSelected: _onRailTabSelected,
                          ),

                          const SizedBox(width: 8),

                          // Dynamic Right Intelligence Card with smooth crossfade
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

                    // Bottom Promotional Banner (Muscle Building Program)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: PromoBannerWidget(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          _onStatTabSelected(QuickStatTab.workout);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Switched to Workout Intelligence: Muscle Building Program Active 🔥'),
                              backgroundColor: BadGymColors.purpleCardStart,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
