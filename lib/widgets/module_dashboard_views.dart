
import 'package:flutter/material.dart';

import '../data/dashboard_navigation.dart';
import '../data/sample_member.dart';
import '../theme/member_theme.dart';
import 'member_charts.dart';

/// Reference-led content for the 24 member intelligence destinations.
/// Illustrative data is marked as preview; verified history requires a service.
class ModuleDashboardView extends StatefulWidget {
  const ModuleDashboardView({
    required this.module,
    required this.sectionIndex,
    required this.compact,
    required this.palette,
    required this.member,
    super.key,
  });

  final DashboardModule module;
  final int sectionIndex;
  final bool compact;
  final MemberPlanPalette palette;
  final MemberSample member;

  @override
  State<ModuleDashboardView> createState() => _ModuleDashboardViewState();
}

enum _PreviewRange { week, month, quarter, year }

class _ModuleDashboardViewState extends State<ModuleDashboardView> {
  _PreviewRange _range = _PreviewRange.month;
  DateTime _calendarMonth = DateTime(2026, 10);
  int? _selectedCalendarDay = 16;

  bool get compact => widget.compact;
  MemberPlanPalette get palette => widget.palette;
  MemberSample get member => widget.member;
  double get gap => compact ? 3 : 6;

  @override
  Widget build(BuildContext context) => switch (widget.module) {
        DashboardModule.attendance => _attendance(),
        DashboardModule.workout => _workout(),
        DashboardModule.payment => _payment(),
        DashboardModule.body => _body(),
      };

  Widget _attendance() => switch (widget.sectionIndex) {
        0 => _page([
            _pairStats('Attendance rate', member.attendance, 'Attendance data',
                'Sample only', MemberTheme.green, palette.accent),
            _donutBreakdown(
              'Attendance distribution',
              'Illustrative monthly counts · not a live record',
              const [23, 2, 2, 4],
              const [MemberTheme.green, MemberTheme.amber, MemberTheme.rose, MemberTheme.purple],
              const [['Present', '23'], ['Late', '2'], ['Absent', '2'], ['Holiday', '4']],
            ),
            _note('Attendance overview',
                'Connect the attendance service to replace this preview with dated visits',
                Icons.event_available_rounded),
          ]),
        1 => _page([
            _donutBreakdown(
              'Attendance distribution',
              'Present · late · absent · holiday · Demo',
              const [23, 2, 2, 4],
              const [MemberTheme.green, MemberTheme.amber, MemberTheme.rose, MemberTheme.purple],
              const [['Present', '23'], ['Late', '2'], ['Absent', '2'], ['Holiday', '4']],
            ),
            _note('WEEKLY ACTIVITY',
                'Visit consistency · illustrative sample',
                Icons.show_chart_rounded),
          ]),
        2 => _calendar(),
        3 => _page([
            _pairStats('Attendance rate', member.attendance, 'Verified visits',
                'Not synced', MemberTheme.green, palette.accent),
            _historyCard('Gym check-in',
                'No dated check-in records have been returned by the attendance service',
                Icons.history_rounded),
            _note('History is waiting for sync',
                'A visit appears here only after the gym server confirms it',
                Icons.verified_user_outlined),
          ]),
        4 => _page([
            _pairStats('Attendance trend', member.attendance, 'Tracked months',
                'Not available', MemberTheme.green, palette.accent),
            _trendChart('Attendance trend',
                'Attendance rate (%) · illustrative only',
                const [68, 72, 74, 70, 58, 76, 81, 78, 83, 75, 81, 81],
                MemberTheme.green, unit: '%'),
            _note('Attendance trend is not connected',
                'Dated monthly check-ins are required for a reliable trend',
                Icons.show_chart_rounded),
          ]),
        5 => _page([
            _goal('Monthly attendance', 'Suggested target · not saved', 0, MemberTheme.green),
            _goal('Attendance consistency', 'Set a personal target after history sync', 0, palette.accent),
            _goal('Weekly routine', 'Coach-defined schedule required', 0, MemberTheme.amber),
            _note('Goal guidance',
                'Goals remain suggestions until a member or coach saves them',
                Icons.flag_rounded),
          ]),
        _ => const SizedBox.shrink(),
      };

  Widget _calendar() {
    const weekdayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final firstWeekday = DateTime(_calendarMonth.year, _calendarMonth.month, 1).weekday - 1;
    final daysInMonth = DateTime(_calendarMonth.year, _calendarMonth.month + 1, 0).day;
    final cellCount = ((firstWeekday + daysInMonth + 6) ~/ 7) * 7;
    final monthName = _monthName(_calendarMonth.month);
    final selectedStatus = _selectedCalendarDay == null
        ? 'No date selected'
        : _calendarStatus(_selectedCalendarDay!);

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              key: const ValueKey('calendar-prev'),
              tooltip: 'Previous month',
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 28, height: 28),
              onPressed: () => setState(() {
                _calendarMonth = DateTime(_calendarMonth.year, _calendarMonth.month - 1);
                _selectedCalendarDay = null;
              }),
              icon: const Icon(Icons.chevron_left_rounded, size: 20),
              color: palette.accent,
            ),
            Expanded(
              child: Text('$monthName ${_calendarMonth.year}',
                  key: const ValueKey('calendar-month-label'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: MemberTheme.ink, fontSize: 12, fontWeight: FontWeight.w900)),
            ),
            IconButton(
              key: const ValueKey('calendar-next'),
              tooltip: 'Next month',
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 28, height: 28),
              onPressed: () => setState(() {
                _calendarMonth = DateTime(_calendarMonth.year, _calendarMonth.month + 1);
                _selectedCalendarDay = null;
              }),
              icon: const Icon(Icons.chevron_right_rounded, size: 20),
              color: palette.accent,
            ),
          ],
        ),
        SizedBox(height: gap),
        Row(
          children: [
            for (final label in weekdayLabels)
              Expanded(
                child: Center(
                  child: Text(label,
                      style: const TextStyle(color: MemberTheme.muted, fontSize: 8, fontWeight: FontWeight.w800)),
                ),
              ),
          ],
        ),
        SizedBox(height: gap),
        Expanded(
          child: Column(
            children: [
              for (var row = 0; row < cellCount ~/ 7; row++)
                Expanded(
                  child: Row(
                    children: [
                      for (var col = 0; col < 7; col++)
                        Expanded(child: _calendarCell(row * 7 + col - firstWeekday + 1, daysInMonth)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: compact ? 3 : 5),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 5,
          runSpacing: 2,
          children: [
            _legend(MemberTheme.green, 'Present'),
            _legend(MemberTheme.amber, 'Late'),
            _legend(MemberTheme.rose, 'Absent'),
            _legend(MemberTheme.purple, 'Holiday'),
            _legend(const Color(0xFFE5E1EB), 'Off'),
          ],
        ),
        SizedBox(height: compact ? 3 : 5),
        _note('Calendar preview · $selectedStatus',
            'Sample status colours only; no live attendance dates are stored',
            Icons.calendar_month_rounded),
      ],
    );
  }

  Widget _calendarCell(int day, int daysInMonth) {
    if (day < 1 || day > daysInMonth) return const SizedBox.expand();
    final date = DateTime(_calendarMonth.year, _calendarMonth.month, day);
    final isOff = date.weekday == DateTime.sunday;
    final status = _calendarStatus(day);
    final tint = isOff ? const Color(0xFFE5E1EB) : _calendarColor(status);
    final selected = day == _selectedCalendarDay;

    return Semantics(
      button: true,
      selected: selected,
      label: 'Day $day, $status, sample preview',
      child: InkWell(
        onTap: () => setState(() => _selectedCalendarDay = day),
        borderRadius: BorderRadius.circular(7),
        child: Container(
          margin: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: selected ? palette.accent : Colors.white,
                width: selected ? 1.8 : 0.8),
          ),
          child: Center(
            child: Text('$day',
                style: TextStyle(color: MemberTheme.ink, fontSize: compact ? 9 : 10,
                    fontWeight: FontWeight.w800)),
          ),
        ),
      ),
    );
  }

  String _calendarStatus(int day) {
    final date = DateTime(_calendarMonth.year, _calendarMonth.month, day);
    if (date.weekday == DateTime.sunday) return 'Off';
    if (day == 3 || day == 17 || day == 24) return 'Absent';
    if (day == 7 || day == 21) return 'Late';
    if (day == 10 || day == 25) return 'Holiday';
    return 'Present';
  }

  Color _calendarColor(String status) => switch (status) {
        'Present' => const Color(0xFFD9F5E2),
        'Late' => const Color(0xFFFFE9BD),
        'Absent' => const Color(0xFFFFDDE4),
        'Holiday' => const Color(0xFFEBDDFC),
        _ => const Color(0xFFE5E1EB),
      };

  String _monthName(int month) => const [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ][month - 1];

  Widget _workout() => switch (widget.sectionIndex) {
        0 => _page([
            _pairStats('Workout average', member.workout, 'Session history',
                'Not synced', palette.accent, MemberTheme.green),
            _chart('DAILY WORKOUT TREND', 'Training minutes · illustrative preview',
                const [32, 48, 26, 64, 42, 76, 58], palette.accent, unit: 'min', bars: true),
            _note('Workout overview',
                'Session totals and personal averages need a connected workout log',
                Icons.fitness_center_rounded),
          ]),
        1 => _page([
            _donutBreakdown(
              'Training distribution',
              'Muscle-group split · illustrative sample',
              const [22, 18, 16, 14, 20, 10],
              const [MemberTheme.purple, MemberTheme.green, MemberTheme.amber,
                Color(0xFF3298D4), Color(0xFFE56AB2), Color(0xFF7F8B9D)],
              const [['Chest', '22%'], ['Back', '18%'], ['Legs', '16%'],
                ['Shoulder', '14%'], ['Arms', '20%'], ['Core', '10%']],
            ),
            _note('Workout insights not connected',
                'Exercise frequency, PRs and training load need dated session records',
                Icons.insights_rounded),
          ]),
        2 => _page([
            _pairStats('Latest workout summary', 'Not synced', 'Exercise sets',
                'Not available', palette.accent, MemberTheme.green),
            _historyCard('Workout log',
                'No workout sessions or exercise sets have been synced for this member',
                Icons.receipt_long_rounded),
            _note('Workout log',
                'Add a session to record exercises, sets, reps, load and duration',
                Icons.fitness_center_rounded),
          ]),
        3 => _page([
            _pairStats('Training duration', member.workout, 'Date range',
                _rangeLabel, palette.accent, MemberTheme.green),
            _trendChart('WORKOUT MINUTES • LAST 7 DAYS',
                'Duration (min) · illustrative preview',
                const [32, 48, 26, 64, 42, 76, 58], palette.accent,
                unit: 'min', bars: true),
            _note('Workout trend preview',
                'Best session and monthly totals appear after dated workout sync',
                Icons.timeline_rounded),
          ]),
        4 => _page([
            _pairStats('Sleep', 'Not connected', 'Hydration', 'Not connected',
                const Color(0xFF6C5BA7), const Color(0xFF278FC2)),
            _assetFeature('Recovery products', 'PulseVault recovery artwork',
                'Demo creative · no product or health data connected',
                '03_whey_protein_tub.webp', MemberTheme.lavender),
            _goal('Sleep routine', 'Connect a wearable or recovery log', 0, const Color(0xFF6C5BA7)),
            _note('Recovery data unavailable',
                'Sleep, mobility and hydration values are not inferred',
                Icons.spa_rounded),
          ]),
        5 => _page([
            _goal('Weekly sessions', 'Suggested goal · not saved', 0, palette.accent),
            _goal('Workout consistency', 'Coach-defined programme required', 0, MemberTheme.green),
            _goal('Recovery routine', 'Sleep and mobility data not connected', 0, MemberTheme.amber),
            _note('Coaching goal guidance',
                'Training targets become personal after a coach saves the programme',
                Icons.flag_rounded),
          ]),
        _ => const SizedBox.shrink(),
      };

  Widget _payment() => switch (widget.sectionIndex) {
        0 => _page([
            _pairStats('Payment due', member.paymentDue, 'Days remaining',
                member.daysRemaining.toString(), MemberTheme.rose, palette.accent),
            _paymentStatus(),
            _goal('Membership period used',
                '${member.membershipDays} / ${member.membershipTotalDays} days · sample',
                member.membershipProgress.clamp(0.0, 1.0).toDouble(), MemberTheme.green),
            _note('Membership balance',
                'The displayed balance is local sample data until billing sync is connected',
                Icons.account_balance_wallet_rounded),
          ]),
        1 => _page([
            _pairStats('Payment due', member.paymentDue, 'Ledger status',
                'Not connected', MemberTheme.rose, palette.accent),
            _donutBreakdown(
              'Payment behaviour',
              'On time · early · late · illustrative only',
              const [64, 22, 14],
              const [MemberTheme.green, Color(0xFF3298D4), MemberTheme.amber],
              const [['On time', '64%'], ['Early', '22%'], ['Late', '14%']],
            ),
            _note('Payment insights not connected',
                'Payment reliability must be calculated from a verified transaction ledger',
                Icons.insights_rounded),
          ]),
        2 => _page([
            _pairStats('Outstanding membership amount', member.paymentDue,
                'Invoice status', 'Not generated', MemberTheme.rose, palette.accent),
            _historyCard('Membership balance',
                'Invoice number, billing date and receipt will appear after billing integration',
                Icons.request_quote_rounded),
            _note('Invoice preview',
                'No invoice ID or payment receipt is generated in this local preview',
                Icons.description_rounded),
          ]),
        3 => _page([
            _pairStats('Outstanding membership amount', member.paymentDue, 'Settled transactions',
                'Not synced', MemberTheme.rose, MemberTheme.green),
            _historyCard('Payment history',
                'No verified transactions have been returned by the gym billing service',
                Icons.history_rounded),
            _note('Transaction timeline',
                'Only server-confirmed payments and receipts can be shown here',
                Icons.verified_user_outlined),
          ]),
        4 => _page([
            _assetFeature('Payment method preview', 'Secure payment setup',
                'Payment-card artwork · Demo only',
                '29_sbi_payment_card_graphic.webp', MemberTheme.sky),
            _pairStats('UPI', 'Not saved', 'Card', 'Not saved',
                palette.accent, const Color(0xFF328BC0)),
            _note('Payment methods are not connected',
                'No card credentials or UPI handles are stored in this app preview',
                Icons.security_rounded),
          ]),
        5 => _page([
            _assetFeature('Member reward preview', 'Payment and rewards artwork',
                'Campaign creative only · no live offer',
                '29_sbi_payment_card_graphic.webp', MemberTheme.lavender),
            _pairStats('Reward points', 'Not linked', 'Cashback', 'Not linked',
                MemberTheme.amber, MemberTheme.green),
            _note('Rewards not connected',
                'Reward balances and eligibility need a configured campaign service',
                Icons.card_giftcard_rounded),
          ]),
        _ => const SizedBox.shrink(),
      };

  Widget _body() => switch (widget.sectionIndex) {
        0 => _page([
            _pairStats('Current weight', member.bodyWeight, 'Target weight',
                'Not set', MemberTheme.green, palette.accent),
            _assetFeature('Body overview', 'Member transformation artwork',
                'Current weight only · target not recorded',
                '01_member_bodybuilder.webp', MemberTheme.mint),
            _note('Body Intelligence',
                'Composition and circumference values need dated assessment records',
                Icons.monitor_weight_rounded),
          ]),
        1 => _page([
            _pairStats('Current weight', member.bodyWeight, 'Composition records',
                'Not recorded', MemberTheme.green, palette.accent),
            _historyCard('Composition indicators',
                'BMI, body fat, muscle mass and visceral-fat values are not recorded',
                Icons.health_and_safety_rounded),
            _note('Body insights not connected',
                'Only verified measurements can be used to calculate personal indicators',
                Icons.insights_rounded),
          ]),
        2 => _page([
            _pairStats('Latest recorded weight', member.bodyWeight, 'Weight goal',
                'Not set', MemberTheme.green, palette.accent),
            _trendChart('Weight & body trend',
                'Weight (kg) · illustrative layout only',
                const [66, 67, 67.5, 68.2, 69.5, 69.2, 69.5],
                MemberTheme.green, unit: 'kg', minimum: 60, maximum: 76),
            _note('Weight trend preview',
                'A real trend requires multiple dated measurements',
                Icons.timeline_rounded),
          ]),
        3 => _page([
            _pairStats('Body weight', member.bodyWeight, 'Measurements',
                'Not recorded', MemberTheme.green, palette.accent),
            _historyCard('Body measurements',
                'Chest, waist, arms and hips have not been recorded yet',
                Icons.straighten_rounded),
            _note('Measurement history',
                'Add a dated assessment to compare current values with a baseline',
                Icons.monitor_weight_rounded),
          ]),
        4 => _page([
            _assetFeature('Nutrition offer preview', 'Nutrition and meal artwork',
                'PulseVault transparent product graphics · Demo',
                '28_protinex_tub.webp', MemberTheme.mint),
            _pairStats('Calories today', 'Not logged', 'Macros', 'Not logged',
                MemberTheme.green, palette.accent),
            _note('Nutrition data unavailable',
                'Protein, carbs, fats, calories and meal history need a nutrition log',
                Icons.restaurant_menu_rounded),
          ]),
        5 => _page([
            _goal('Weight target', 'Set a personal target first', 0, palette.accent),
            _goal('Body composition', 'Add a baseline assessment', 0, MemberTheme.green),
            _goal('Measurement milestone', 'Add dated circumference records', 0, MemberTheme.amber),
            _assetFeature('Transformation gallery', 'Before / after photo space',
                'No member photos have been added',
                '01_member_bodybuilder.webp', MemberTheme.lavender),
            _note('Set a body goal',
                'Progress goals are not inferred from the sample member record',
                Icons.flag_rounded),
          ]),
        _ => const SizedBox.shrink(),
      };

  String get _rangeLabel => switch (_range) {
        _PreviewRange.week => '7 days',
        _PreviewRange.month => '30 days',
        _PreviewRange.quarter => '90 days',
        _PreviewRange.year => '12 months',
      };

  List<double> _rangeValues(List<double> source) {
    final count = switch (_range) {
      _PreviewRange.week => 7,
      _PreviewRange.month => 8,
      _PreviewRange.quarter => 10,
      _PreviewRange.year => 12,
    };
    if (count == source.length) return source;
    return List<double>.generate(count,
        (index) => source[(index * source.length / count).floor()]);
  }

  List<String> _rangeLabels() => switch (_range) {
        _PreviewRange.week => const ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
        _PreviewRange.month => const ['1', '5', '9', '13', '17', '21', '25', '30'],
        _PreviewRange.quarter => const ['W1', 'W2', 'W3', 'W4', 'W5', 'W6', 'W7', 'W8', 'W9', 'W10'],
        _PreviewRange.year => const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
      };

  String _rangeKey(_PreviewRange range) => switch (range) {
        _PreviewRange.week => '7D',
        _PreviewRange.month => '30D',
        _PreviewRange.quarter => '90D',
        _PreviewRange.year => '12M',
      };

  Widget _periodFilter() => Wrap(
        spacing: 2,
        runSpacing: 2,
        children: [
          for (final range in _PreviewRange.values)
            ChoiceChip(
              key: ValueKey(_rangeKey(range)),
              label: Text(_rangeKey(range)),
              selected: _range == range,
              onSelected: (_) => setState(() => _range = range),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              labelPadding: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 2),
              side: BorderSide(color: _range == range
                  ? palette.accent.withOpacity(0.35)
                  : MemberTheme.glassEdge),
              backgroundColor: Colors.white,
              selectedColor: MemberTheme.lavender,
              labelStyle: TextStyle(
                color: _range == range ? palette.accent : MemberTheme.muted,
                fontSize: 8,
                fontWeight: FontWeight.w800,
              ),
            ),
        ],
      );

  Widget _trendChart(
    String title,
    String subtitle,
    List<double> values,
    Color tint, {
    required String unit,
    bool bars = false,
    double minimum = 0,
    double? maximum,
  }) {
    final rangeValues = _rangeValues(values);
    final labels = _rangeLabels();
    final chartMaximum = maximum ??
        (rangeValues.isEmpty ? 1 : rangeValues.reduce((a, b) => a > b ? a : b) * 1.2);
    final chart = bars
        ? GlassBarChart(values: rangeValues, color: tint, maxY: chartMaximum,
            highlightIndex: rangeValues.length - 1)
        : GlassLineChart(series: [rangeValues], colors: [tint],
            minY: minimum, maxY: chartMaximum);

    return Expanded(
      child: GlassChartFrame(
        title: title,
        subtitle: subtitle,
        child: Column(
          children: [
            Expanded(child: chart),
            const SizedBox(height: 2),
            Row(
              children: [
                for (final label in labels)
                  Expanded(
                    child: Center(
                      child: Text(label, maxLines: 1,
                          style: const TextStyle(color: MemberTheme.muted,
                              fontSize: 7, fontWeight: FontWeight.w700)),
                    ),
                  ),
              ],
            ),
            SizedBox(height: compact ? 2 : 4),
            Row(
              children: [
                Expanded(
                  child: Text('Illustrative preview · $unit',
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: MemberTheme.muted,
                          fontSize: 7.5, fontWeight: FontWeight.w700)),
                ),
                _periodFilter(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chart(String title, String subtitle, List<double> values, Color tint,
          {required String unit, bool bars = false}) =>
      _trendChart(title, subtitle, values, tint, unit: unit, bars: bars);

  Widget _pairStats(String labelA, String valueA, String labelB, String valueB,
          Color colorA, Color colorB) =>
      Row(
        children: [
          Expanded(child: _metric(labelA, valueA, Icons.insights_rounded, colorA)),
          SizedBox(width: gap),
          Expanded(child: _metric(labelB, valueB, Icons.track_changes_rounded, colorB)),
        ],
      );

  Widget _metric(String label, String value, IconData icon, Color tint) =>
      GlassMetricCard(label: label, value: value, icon: icon, tint: tint,
          compact: compact, caption: 'Demo / preview');

  Widget _donutBreakdown(String title, String subtitle, List<double> values,
          List<Color> colors, List<List<String>> labels) =>
      Expanded(
        child: GlassChartFrame(
          title: title,
          subtitle: subtitle,
          child: Row(
            children: [
              SizedBox(
                width: compact ? 82 : 98,
                child: GlassDonutChart(
                  values: values,
                  colors: colors,
                  centerValue: 'Demo',
                  centerLabel: 'sample',
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < labels.length; i++)
                      _legendValue(colors[i], labels[i][0], labels[i][1]),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _historyCard(String title, String message, IconData icon) =>
      Expanded(
        child: GlassChartFrame(
          title: title,
          subtitle: 'Verified records only',
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: palette.accent, size: compact ? 23 : 28),
                  SizedBox(height: compact ? 4 : 6),
                  Text('No records synced',
                      style: TextStyle(color: MemberTheme.ink,
                          fontSize: compact ? 10 : 11, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 3),
                  Text(message, maxLines: 2, textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: MemberTheme.muted,
                          fontSize: 8, height: 1.15, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _paymentStatus() => Container(
        padding: EdgeInsets.all(compact ? 7 : 9),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFE5F9EA), Color(0xFFF4E9FF)]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFB9E7C9)),
        ),
        child: Row(
          children: [
            Icon(member.paymentDue == '₹0'
                    ? Icons.verified_rounded
                    : Icons.pending_actions_rounded,
                color: member.paymentDue == '₹0' ? MemberTheme.green : MemberTheme.rose,
                size: 22),
            const SizedBox(width: 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Payment status',
                      style: TextStyle(color: MemberTheme.ink, fontSize: 9, fontWeight: FontWeight.w800)),
                  Text(member.paymentDue == '₹0' ? 'Paid' : 'Due',
                      style: TextStyle(color: member.paymentDue == '₹0'
                          ? MemberTheme.green : MemberTheme.rose,
                          fontSize: 16, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(member.plan,
                    style: const TextStyle(color: MemberTheme.ink, fontSize: 9, fontWeight: FontWeight.w800)),
                Text('${member.membershipTotalDays} day plan · sample',
                    style: const TextStyle(color: MemberTheme.muted, fontSize: 8, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      );

  Widget _goal(String label, String subtitle, double value, Color tint) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: compact ? 3 : 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: MemberTheme.ink,
                          fontSize: 10, fontWeight: FontWeight.w800)),
                ),
                Text(value > 0 ? '${(value * 100).round()}%' : 'Not set',
                    style: TextStyle(color: tint, fontSize: 9, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 3),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: value.clamp(0.0, 1.0),
                minHeight: compact ? 5 : 6,
                backgroundColor: MemberTheme.glassEdge.withOpacity(0.5),
                valueColor: AlwaysStoppedAnimation<Color>(tint),
              ),
            ),
            Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: MemberTheme.muted,
                    fontSize: 8, fontWeight: FontWeight.w600)),
          ],
        ),
      );

  Widget _assetFeature(String title, String subtitle, String caption,
          String file, Color tint) =>
      Container(
        width: double.infinity,
        height: compact ? 48 : 60,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.white, tint.withOpacity(0.45)]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MemberTheme.glassEdge),
        ),
        child: Row(
          children: [
            Image.asset('assets/material_pack/inbox/PulseVault/$file',
                width: compact ? 44 : 56, height: compact ? 40 : 52,
                fit: BoxFit.contain),
            const SizedBox(width: 7),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: MemberTheme.ink,
                          fontSize: 10, fontWeight: FontWeight.w900)),
                  Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: MemberTheme.muted,
                          fontSize: 8, fontWeight: FontWeight.w600)),
                  Text(caption, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: MemberTheme.purple,
                          fontSize: 7, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const Text('DEMO',
                style: TextStyle(color: MemberTheme.purple, fontSize: 7, fontWeight: FontWeight.w900)),
          ],
        ),
      );

  Widget _note(String title, String description, IconData icon) => Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: compact ? 5 : 7),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFF2E7FF), Colors.white]),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MemberTheme.glassEdge.withOpacity(0.8)),
        ),
        child: Row(
          children: [
            Icon(icon, color: MemberTheme.purple, size: 17),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: MemberTheme.ink,
                          fontSize: 9, fontWeight: FontWeight.w900)),
                  Text(description, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: MemberTheme.muted,
                          fontSize: 7.5, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _legend(Color color, String label) => Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 6, height: 6,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 3),
            Text(label, style: const TextStyle(color: MemberTheme.muted,
                fontSize: 7, fontWeight: FontWeight.w700)),
          ],
        ),
      );

  Widget _legendValue(Color color, String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Container(width: 7, height: 7,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 4),
            Expanded(
              child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: MemberTheme.ink,
                      fontSize: 8, fontWeight: FontWeight.w700)),
            ),
            Text(value, style: const TextStyle(color: MemberTheme.muted,
                fontSize: 8, fontWeight: FontWeight.w800)),
          ],
        ),
      );

  Widget _page(List<Widget> children) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(height: gap),
            children[i],
          ],
        ],
      );
}
