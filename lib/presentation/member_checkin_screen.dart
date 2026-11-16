import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/presentation/widgets/attendance_calendar_grid.dart';
import 'package:bad_gym/presentation/widgets/attendance_trend_chart.dart';
import 'package:bad_gym/presentation/widgets/member_qr_sheet.dart';
import 'package:bad_gym/presentation/widgets/notification_sheet.dart';
import 'package:bad_gym/presentation/widgets/renewal_sheet.dart';
import 'package:bad_gym/presentation/widgets/quick_stats_row.dart';
import 'package:bad_gym/core/services/update_center_service.dart';

enum _WorkspaceView { calendar, trend, history, insights, sessions, program, payments, plan, measurements, goals }

class MemberCheckInScreen extends StatefulWidget {
  final MemberIntelligenceData? initialData;
  const MemberCheckInScreen({super.key, this.initialData});

  @override
  State<MemberCheckInScreen> createState() => _MemberCheckInScreenState();
}

class _MemberCheckInScreenState extends State<MemberCheckInScreen> {
  late final MemberIntelligenceData _data;
  QuickStatTab _selectedTab = QuickStatTab.attendance;
  _WorkspaceView _selectedView = _WorkspaceView.calendar;
  bool _checkingUpdates = false;
  final UpdateCenterService _updates = UpdateCenterService();

  @override
  void initState() {
    super.initState();
    _data = widget.initialData ?? MemberIntelligenceData.ashwaniKumarSingh;
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkForUpdates());
  }

  Future<void> _checkForUpdates({bool showNoUpdate = false}) async {
    if (_checkingUpdates || !mounted) return;
    setState(() => _checkingUpdates = true);
    try {
      final update = await _updates.checkForUpdate();
      if (!mounted) return;
      if (update == null) {
        if (showNoUpdate) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('BAD GYM is up to date.')));
        return;
      }
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text('BAD GYM update ${update.versionName}'),
          content: SingleChildScrollView(child: Text(update.notes.isEmpty ? 'A new version is ready.' : update.notes)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Later')),
            FilledButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                try {
                  await _updates.install(update);
                  if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Verified update sent to Android Installer. Complete the system confirmation to update BAD GYM.')));
                } catch (error) {
                  if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update could not start: $error')));
                }
              },
              child: const Text('Update'),
            ),
          ],
        ),
      );
    } catch (error) {
      if (showNoUpdate && mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update check failed: $error')));
    } finally {
      if (mounted) setState(() => _checkingUpdates = false);
    }
  }

  void _selectTab(QuickStatTab tab) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedTab = tab;
      _selectedView = switch (tab) {
        QuickStatTab.attendance => _WorkspaceView.calendar,
        QuickStatTab.workout => _WorkspaceView.sessions,
        QuickStatTab.payment => _WorkspaceView.payments,
        QuickStatTab.body => _WorkspaceView.measurements,
      };
    });
  }

  List<({String label, IconData icon, _WorkspaceView view})> get _railItems => switch (_selectedTab) {
    QuickStatTab.attendance => [
      (label: 'Calendar', icon: Icons.calendar_month_rounded, view: _WorkspaceView.calendar),
      (label: 'Trend', icon: Icons.show_chart_rounded, view: _WorkspaceView.trend),
      (label: 'History', icon: Icons.history_rounded, view: _WorkspaceView.history),
      (label: 'Insights', icon: Icons.insights_rounded, view: _WorkspaceView.insights),
    ],
    QuickStatTab.workout => [
      (label: 'Sessions', icon: Icons.fitness_center_rounded, view: _WorkspaceView.sessions),
      (label: 'Program', icon: Icons.view_list_rounded, view: _WorkspaceView.program),
    ],
    QuickStatTab.payment => [
      (label: 'Payments', icon: Icons.receipt_long_rounded, view: _WorkspaceView.payments),
      (label: 'Plan', icon: Icons.card_membership_rounded, view: _WorkspaceView.plan),
    ],
    QuickStatTab.body => [
      (label: 'Measure', icon: Icons.monitor_weight_rounded, view: _WorkspaceView.measurements),
      (label: 'Goals', icon: Icons.flag_rounded, view: _WorkspaceView.goals),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E9),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 650;
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
              child: Container(
                key: const ValueKey('member_dashboard_outer_card'),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFEFB),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFDCCDB8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildMemberHeader(compact),
                    SizedBox(height: compact ? 6 : 9),
                    QuickStatsRow(data: _data, selectedTab: _selectedTab, onTabSelected: _selectTab),
                    SizedBox(height: compact ? 5 : 8),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildContextRail(compact),
                          const SizedBox(width: 7),
                          Expanded(child: _buildWorkspace(compact)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    _buildFooter(compact),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMemberHeader(bool compact) {
    final nameStyle = TextStyle(fontSize: compact ? 14 : 16, fontWeight: FontWeight.w900, color: const Color(0xFF241D1B), height: 1.1);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFF9F1D2D), borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 17),
            const SizedBox(width: 7),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Last Check-In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11)),
              Text('${_data.checkInDate} · ${_data.checkInTime}', style: const TextStyle(color: Color(0xFFFFE8E5), fontSize: 9)),
            ])),
            IconButton(
              key: const ValueKey('header_notification_button'),
              onPressed: () => NotificationSheet.show(context),
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints.tightFor(width: 30, height: 30),
              padding: EdgeInsets.zero,
              icon: Badge(label: Text('${_data.notificationCount}'), child: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 19)),
            ),
          ]),
        ),
        SizedBox(height: compact ? 6 : 8),
        Row(children: [
          Container(
            width: compact ? 42 : 48, height: compact ? 42 : 48,
            decoration: BoxDecoration(color: const Color(0xFFF5E8D2), shape: BoxShape.circle, border: Border.all(color: const Color(0xFFD2AD55), width: 2)),
            child: const Icon(Icons.person_rounded, color: Color(0xFF8E2633), size: 27),
          ),
          const SizedBox(width: 9),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(_data.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: nameStyle),
            const SizedBox(height: 2),
            Text('${_data.memberId}  ·  ${_data.age} yrs  ·  ${_data.gender}', style: const TextStyle(fontSize: 9, color: Color(0xFF746B64), fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            Row(children: [
              _pill(_data.isActive ? 'Active' : 'Inactive', const Color(0xFFE3F5E9), const Color(0xFF168447)),
              const SizedBox(width: 5),
              _pill(_data.planName, const Color(0xFFFFF0C8), const Color(0xFF8B6418)),
            ]),
          ])),
          IconButton(
            key: const ValueKey('member_avatar_button'),
            onPressed: () => MemberQrSheet.show(context, _data),
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.qr_code_2_rounded, color: Color(0xFF9F1D2D)),
          ),
        ]),
        SizedBox(height: compact ? 5 : 7),
        Row(children: [
          Expanded(child: _infoTile('Payment Due', _data.paymentAmount, Icons.account_balance_wallet_rounded, () {})),
          const SizedBox(width: 6),
          Expanded(child: _infoTile('${_data.daysLeft} Days Left', 'Expires ${_data.renewDate}', Icons.calendar_month_rounded, () => RenewalSheet.show(context, _data))),
        ]),
        const SizedBox(height: 5),
        Row(children: [
          Expanded(child: Text(_data.membershipDaysLabel, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF342A26)))),
          Text('${_data.membershipPercent}%', style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFF8B6418))),
        ]),
        const SizedBox(height: 3),
        ClipRRect(borderRadius: BorderRadius.circular(5), child: LinearProgressIndicator(value: _data.membershipProgress, minHeight: 5, backgroundColor: const Color(0xFFEFE7DC), color: const Color(0xFFB51F31))),
      ],
    );
  }

  Widget _pill(String text, Color bg, Color fg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
    child: Text(text, style: TextStyle(fontSize: 8, color: fg, fontWeight: FontWeight.w800)),
  );

  Widget _infoTile(String title, String value, IconData icon, VoidCallback onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(color: const Color(0xFFFFF4F3), border: Border.all(color: const Color(0xFFF1D6D6)), borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        Icon(icon, size: 15, color: const Color(0xFFB51F31)),
        const SizedBox(width: 5),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 8, color: Color(0xFF766B66))),
          Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF9F1D2D))),
        ])),
      ]),
    ),
  );

  Widget _buildContextRail(bool compact) => Container(
    key: const ValueKey('contextual_navigation_rail'),
    width: compact ? 55 : 61,
    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
    decoration: BoxDecoration(color: const Color(0xFFF7F0E6), border: Border.all(color: const Color(0xFFE4D6C3)), borderRadius: BorderRadius.circular(13)),
    child: Column(children: [
      for (final item in _railItems)
        Expanded(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: InkWell(
            key: ValueKey('rail_${item.view.name}'),
            borderRadius: BorderRadius.circular(9),
            onTap: () => setState(() => _selectedView = item.view),
            child: Container(
              decoration: BoxDecoration(color: _selectedView == item.view ? const Color(0xFF9F1D2D) : Colors.transparent, borderRadius: BorderRadius.circular(9)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(item.icon, size: compact ? 15 : 17, color: _selectedView == item.view ? Colors.white : const Color(0xFF8B5960)),
                const SizedBox(height: 2),
                FittedBox(fit: BoxFit.scaleDown, child: Text(item.label, style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.w700, color: _selectedView == item.view ? Colors.white : const Color(0xFF756A63)))),
              ]),
            ),
          ),
        )),
    ]),
  );

  Widget _buildWorkspace(bool compact) {
    final content = switch (_selectedView) {
      _WorkspaceView.calendar => _buildCalendar(),
      _WorkspaceView.trend => AttendanceTrendChart(points: _data.trendPoints, monthLabel: _data.attendanceMonthLabel),
      _WorkspaceView.history => _buildHistory(),
      _WorkspaceView.insights => _buildInsights(),
      _WorkspaceView.sessions || _WorkspaceView.program => _metricPanel('Workout', _data.workoutTime, 'Today\'s recorded workout time', Icons.fitness_center_rounded, const Color(0xFF9F1D2D)),
      _WorkspaceView.payments || _WorkspaceView.plan => _metricPanel('Payment', _data.paymentAmount, 'Next due: ${_data.paymentNextDue}', Icons.receipt_long_rounded, const Color(0xFF9F1D2D)),
      _WorkspaceView.measurements || _WorkspaceView.goals => _metricPanel('Body', _data.bodyWeight, 'Current recorded body weight', Icons.monitor_weight_rounded, const Color(0xFF9F1D2D)),
    };
    return Container(
      key: const ValueKey('fixed_intelligence_viewport'),
      padding: EdgeInsets.all(compact ? 7 : 9),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFE5D9C9))),
      child: ClipRect(child: content),
    );
  }

  Widget _buildCalendar() => Column(
    key: const ValueKey('attendance_calendar_view'),
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text('Attendance Calendar', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF2A2420))),
      const SizedBox(height: 5),
      Expanded(child: AttendanceCalendarGrid(days: _data.calendarDays, year: _data.attendanceYear, month: _data.attendanceMonth)),
    ],
  );

  Widget _buildHistory() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Attendance History', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
    const SizedBox(height: 10),
    _historyLine('Present', '${_data.presentCount} days', const Color(0xFF168447)),
    _historyLine('Late', '${_data.lateCount} days', const Color(0xFFD39B19)),
    _historyLine('Absent', '${_data.absentCount} days', const Color(0xFFD33A45)),
    _historyLine('Holiday', '${_data.holidayCount} days', const Color(0xFF8A8179)),
  ]);

  Widget _historyLine(String label, String value, Color color) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), const SizedBox(width: 8), Expanded(child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700))), Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900))]),
  );

  Widget _buildInsights() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Attendance Insights', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
    const SizedBox(height: 14),
    SizedBox(height: 105, child: _metricPanel('Attendance rate', '${_data.attendanceRate}%', 'Current period', Icons.trending_up_rounded, const Color(0xFF168447))),
    const SizedBox(height: 10),
    SizedBox(height: 105, child: _metricPanel('Current streak', _data.currentStreak, 'Best: ${_data.bestStreak}', Icons.local_fire_department_rounded, const Color(0xFFD39B19))),
  ]);

  Widget _metricPanel(String title, String value, String detail, IconData icon, Color color) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 28, color: color),
      const SizedBox(height: 8),
      Text(title, style: const TextStyle(fontSize: 11, color: Color(0xFF756A63), fontWeight: FontWeight.w700)),
      const SizedBox(height: 3),
      FittedBox(fit: BoxFit.scaleDown, child: Text(value, style: const TextStyle(fontSize: 24, color: Color(0xFF28211E), fontWeight: FontWeight.w900))),
      Text(detail, textAlign: TextAlign.center, style: const TextStyle(fontSize: 9, color: Color(0xFF81766D))),
    ]));

  Widget _buildFooter(bool compact) => Row(children: [
    Expanded(child: Text('${_data.attendanceRate}% attendance  ·  ${_data.currentStreak} streak', style: TextStyle(fontSize: compact ? 8 : 9, color: const Color(0xFF746B64), fontWeight: FontWeight.w700))),
    TextButton.icon(
      onPressed: _checkingUpdates ? null : () => _checkForUpdates(showNoUpdate: true),
      icon: const Icon(Icons.system_update_alt_rounded, size: 13),
      label: Text(_checkingUpdates ? 'Checking' : 'Updates', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800)),
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF9F1D2D), visualDensity: VisualDensity.compact, padding: const EdgeInsets.symmetric(horizontal: 5)),
    ),
    const Text('BAD GYM', style: TextStyle(fontSize: 8, letterSpacing: 1.1, color: Color(0xFF9F1D2D), fontWeight: FontWeight.w900)),
  ]);
}
