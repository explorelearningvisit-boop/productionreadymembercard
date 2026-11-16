import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';
import 'package:bad_gym/presentation/widgets/attendance_intelligence_card.dart';
import 'package:bad_gym/presentation/widgets/attendance_calendar_grid.dart';
import 'package:bad_gym/presentation/widgets/attendance_trend_chart.dart';
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
import 'package:bad_gym/core/services/update_center_service.dart';

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
  final UpdateCenterService _updates = UpdateCenterService();

  RailTab _selectedRailTab = RailTab.intelligence;
  QuickStatTab _selectedStatTab = QuickStatTab.attendance;
  bool _checkingUpdates = false;

  @override
  void initState() {
    super.initState();
    _data = widget.initialData ?? MemberIntelligenceData.ashwaniKumarSingh;
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkForUpdates());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _checkForUpdates({bool showNoUpdate = false}) async {
    if (_checkingUpdates || !mounted) return;
    setState(() => _checkingUpdates = true);
    try {
      final update = await _updates.checkForUpdate();
      if (!mounted) return;
      if (update == null) {
        if (showNoUpdate) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('BAD GYM is up to date.')),
          );
        }
        return;
      }
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text('BAD GYM update ${update.versionName}'),
          content: SingleChildScrollView(
            child: Text(update.notes.isEmpty
                ? 'A new version is ready.'
                : update.notes),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Later'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                try {
                  await _updates.install(update);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Verified update sent to Android Installer. Complete confirmation to update BAD GYM.'),
                      ),
                    );
                  }
                } catch (error) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Update could not start: $error')),
                    );
                  }
                }
              },
              child: const Text('Update'),
            ),
          ],
        ),
      );
    } catch (error) {
      if (showNoUpdate && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update check failed: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _checkingUpdates = false);
    }
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
    // If user tapped a specific rail sub-view within attendance
    if (_selectedStatTab == QuickStatTab.attendance) {
      switch (_selectedRailTab) {
        case RailTab.intelligence:
        case RailTab.attendance:
        case RailTab.home:
        case RailTab.overview:
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
        case RailTab.calendar:
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Attendance Calendar',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 8),
                AttendanceCalendarGrid(
                  days: _data.calendarDays,
                  year: _data.attendanceYear,
                  month: _data.attendanceMonth,
                ),
              ],
            ),
          );
        case RailTab.trend:
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Attendance Trend',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: AttendanceTrendChart(
                    points: _data.trendPoints,
                    monthLabel: _data.attendanceMonthLabel,
                  ),
                ),
              ],
            ),
          );
        case RailTab.history:
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Attendance History',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 12),
                _historyRow('Present', '${_data.presentCount} days',
                    const Color(0xFF22C55E)),
                _historyRow(
                    'Late', '${_data.lateCount} days', const Color(0xFFEAB308)),
                _historyRow('Absent', '${_data.absentCount} days',
                    const Color(0xFFEF4444)),
                _historyRow('Holiday', '${_data.holidayCount} days',
                    const Color(0xFFA855F7)),
              ],
            ),
          );
        default:
          return AttendanceIntelligenceCard(
            key: const ValueKey('attendance_card'),
            data: _data,
          );
      }
    }

    switch (_selectedStatTab) {
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
      case QuickStatTab.attendance:
        return AttendanceIntelligenceCard(
          key: const ValueKey('attendance_card'),
          data: _data,
        );
    }
  }

  Widget _historyRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF334155)),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 12,
                color: Color(0xFF0F172A)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double kIntelligenceSectionHeight = 372.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EF),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 16),
          child: Container(
            key: const ValueKey('member_dashboard_outer_card'),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFEFD),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFE4D5C7),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Top Brand Header Bar
                TopBrandBar(
                  data: _data,
                  onMenuPressed: () {
                    HapticFeedback.lightImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('BAD GYM Menu'),
                        backgroundColor: BadGymColors.primary,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  onNotificationPressed: () => NotificationSheet.show(context),
                  onCalendarPressed: () {
                    setState(() {
                      _selectedStatTab = QuickStatTab.attendance;
                      _selectedRailTab = RailTab.calendar;
                    });
                  },
                ),

                // 2. Check-In Success Hero Banner with Athlete & Weights
                CheckInHeroBanner(
                  data: _data,
                  onCheckInPressed: () {
                    MemberQrSheet.show(context, _data);
                  },
                ),

                // 3. Member Profile Card (Ashwani Kumar Singh, 22/30 Days, Due/Expiry)
                MemberProfileCard(
                  data: _data,
                  onPaymentDetailsPressed: () =>
                      _onStatTabSelected(QuickStatTab.payment),
                  onRenewPressed: () => RenewalSheet.show(context, _data),
                  onQrPassPressed: () => MemberQrSheet.show(context, _data),
                ),

                // 4. Quick Stats Row (Attendance 81%, Workout 58 min, Payment Due, Body 69.5 kg)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: QuickStatsRow(
                    data: _data,
                    selectedTab: _selectedStatTab,
                    onTabSelected: _onStatTabSelected,
                  ),
                ),

                const SizedBox(height: 6),

                // 5. Two-Column Intelligence Section (Fixed 358px Height - Zero Height Jitter)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    key: const ValueKey('fixed_intelligence_viewport'),
                    height: kIntelligenceSectionHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Left Column: Vertical Navigation Rail (Fixed Height 358)
                        VerticalNavigationRail(
                          key: const ValueKey('contextual_navigation_rail'),
                          height: kIntelligenceSectionHeight,
                          selectedTab: _selectedRailTab,
                          onTabSelected: _onRailTabSelected,
                        ),

                        const SizedBox(width: 8),

                        // Right Column: Dynamic Intelligence Card Viewport
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              switchInCurve: Curves.easeOut,
                              switchOutCurve: Curves.easeIn,
                              child: SizedBox(
                                key: ValueKey(
                                    '${_selectedStatTab.name}_${_selectedRailTab.name}'),
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

                const SizedBox(height: 8),

                // 6. Bottom Promotional Banner: FITNESS NUTRITION - PROTEIN BURGER
                BottomPromoBanner(
                  onOrderPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Order placed for Protein Burger! 50% OFF applied! 🍔'),
                        backgroundColor: Color(0xFFD6001C),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
