import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';
import 'package:bad_gym/presentation/widgets/attendance_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/body_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/merged_member_card.dart';
import 'package:bad_gym/presentation/widgets/member_qr_sheet.dart';
import 'package:bad_gym/presentation/widgets/notification_sheet.dart';
import 'package:bad_gym/presentation/widgets/payment_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/quick_stats_row.dart';
import 'package:bad_gym/presentation/widgets/renewal_sheet.dart';
import 'package:bad_gym/presentation/widgets/top_brand_bar.dart';
import 'package:bad_gym/presentation/widgets/vertical_navigation_rail.dart';
import 'package:bad_gym/presentation/widgets/workout_intelligence_card.dart';
import 'package:bad_gym/core/theme/dashboard_theme_variant.dart';
import 'package:bad_gym/presentation/widgets/theme_switcher_sheet.dart';
import 'package:bad_gym/presentation/widgets/theme_adaptive_bottom_section.dart';
import 'package:bad_gym/presentation/widgets/weekly_attendance_strip.dart';
import 'package:bad_gym/presentation/widgets/attendance_trend_container_card.dart';
import 'package:bad_gym/presentation/widgets/attendance_history_card.dart';

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
  DashboardThemeVariant _currentTheme = DashboardThemeVariant.festiveGold;

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
    if (_selectedRailTab == RailTab.trend) {
      return AttendanceTrendContainerCard(
        key: const ValueKey('attendance_trend_card'),
        data: _data,
      );
    }
    if (_selectedRailTab == RailTab.history) {
      return AttendanceHistoryCard(
        key: const ValueKey('attendance_history_card'),
        data: _data,
      );
    }

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
      backgroundColor: _currentTheme.canvasGradient.colors.first,
      body: Container(
        decoration: BoxDecoration(
          gradient: _currentTheme.canvasGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. Unified Top Brand Bar with Theme Switcher Palette Button
              TopBrandBar(
                data: _data,
                themeVariant: _currentTheme,
                onThemeSwitcherPressed: () {
                  ThemeSwitcherSheet.show(
                    context,
                    currentTheme: _currentTheme,
                    onThemeSelected: (variant) {
                      setState(() {
                        _currentTheme = variant;
                        if (variant == DashboardThemeVariant.darkObsidianGold) {
                          _selectedStatTab = QuickStatTab.payment;
                          _selectedRailTab = RailTab.payment;
                        } else {
                          _selectedStatTab = QuickStatTab.attendance;
                          _selectedRailTab = RailTab.intelligence;
                        }
                      });
                    },
                  );
                },
                onMenuPressed: () {
                  ThemeSwitcherSheet.show(
                    context,
                    currentTheme: _currentTheme,
                    onThemeSelected: (variant) {
                      setState(() {
                        _currentTheme = variant;
                        if (variant == DashboardThemeVariant.darkObsidianGold) {
                          _selectedStatTab = QuickStatTab.payment;
                          _selectedRailTab = RailTab.payment;
                        } else {
                          _selectedStatTab = QuickStatTab.attendance;
                          _selectedRailTab = RailTab.intelligence;
                        }
                      });
                    },
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
                      // 2. Merged Member Profile & Check-In Hero Card
                      MergedMemberCard(
                        data: _data,
                        themeVariant: _currentTheme,
                        onNotificationPressed: () => NotificationSheet.show(context),
                        onPaymentDetailsPressed: () => _onStatTabSelected(QuickStatTab.payment),
                        onRenewPressed: () => RenewalSheet.show(context, _data),
                        onQrPassPressed: () => MemberQrSheet.show(context, _data),
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

                      // 4. Quick Stats Row
                      QuickStatsRow(
                        data: _data,
                        selectedTab: _selectedStatTab,
                        onTabSelected: _onStatTabSelected,
                      ),

                      // Weekly Attendance Strip for Crimson Wave
                      if (_currentTheme == DashboardThemeVariant.crimsonWave && _selectedStatTab == QuickStatTab.attendance)
                        const WeeklyAttendanceStrip(),

                      const SizedBox(height: 4),

                      // 5. Two-Column Intelligence Section (Fixed 358px Height)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          height: kIntelligenceSectionHeight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              VerticalNavigationRail(
                                height: kIntelligenceSectionHeight,
                                selectedTab: _selectedRailTab,
                                onTabSelected: _onRailTabSelected,
                              ),

                              const SizedBox(width: 6),

                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    switchInCurve: Curves.easeOut,
                                    switchOutCurve: Curves.easeIn,
                                    child: SizedBox(
                                      key: ValueKey('$_selectedStatTab$_selectedRailTab$_currentTheme'),
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

                      // 6. Theme-Adaptive Bottom Section
                      ThemeAdaptiveBottomSection(
                        variant: _currentTheme,
                        data: _data,
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
