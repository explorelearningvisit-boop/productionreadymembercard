import 'package:flutter/material.dart';

void main() => runApp(const BadGymDesignLab());

class BadGymDesignLab extends StatelessWidget {
  const BadGymDesignLab({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'BAD GYM Design Lab',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFFF8D9),
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF4C400)),
    ),
    home: const MemberIntelligenceDashboard(),
  );
}

abstract final class C {
  static const ink = Color(0xFF211D16);
  static const muted = Color(0xFF777166);
  static const yellow = Color(0xFFFFD21A);
  static const gold = Color(0xFFE7A900);
  static const green = Color(0xFF168B35);
  static const red = Color(0xFFD92D2D);
  static const purple = Color(0xFF913BE0);
  static const blue = Color(0xFF1688D4);
  static const ivory = Color(0xFFFFFEF9);
  static const line = Color(0xFFE9DCA9);
  static const canvas = Color(0xFFFFF8D9);
}

class MemberIntelligenceDashboard extends StatefulWidget {
  const MemberIntelligenceDashboard({super.key});
  @override
  State<MemberIntelligenceDashboard> createState() => _MemberIntelligenceDashboardState();
}

class _MemberIntelligenceDashboardState extends State<MemberIntelligenceDashboard> {
  int tab = 0;
  int rail = 0;
  int monthOffset = 0;
  final tabs = const ['Attendance', 'Workout', 'Payment', 'Body'];
  final rails = const ['Calendar', 'Trend', 'Record', 'Insight', 'Goal', 'More'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, bounds) {
          final compact = bounds.maxWidth < 380;
          final pad = compact ? 9.0 : 13.0;
          return Padding(
            padding: EdgeInsets.fromLTRB(pad, 5, pad, 7),
            child: Column(
              children: [
                _header(compact),
                const SizedBox(height: 7),
                _memberCard(compact),
                const SizedBox(height: 7),
                _sponsor(compact),
                const SizedBox(height: 7),
                _metricTabs(compact),
                const SizedBox(height: 7),
                Expanded(child: _workspace(compact)),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _header(bool compact) => SizedBox(
    height: compact ? 39 : 45,
    child: Row(children: [
      Container(
        width: compact ? 34 : 40, height: compact ? 34 : 40,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFFE56B), C.gold]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: const [BoxShadow(color: Color(0x33B58A00), blurRadius: 5, offset: Offset(0, 2))],
        ),
        child: Padding(padding: const EdgeInsets.all(6), child: Image.asset('assets/images/logo_dumbbell.png', fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.fitness_center, color: C.ink, size: 21))),
      ),
      const SizedBox(width: 8),
      Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        RichText(text: const TextSpan(style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w900, fontSize: 20, height: 1), children: [
          TextSpan(text: 'BAD ', style: TextStyle(color: C.ink)),
          TextSpan(text: 'GYM', style: TextStyle(color: C.red)),
        ])),
        const Text('MEMBER INTELLIGENCE', style: TextStyle(fontSize: 8, letterSpacing: 1.2, fontWeight: FontWeight.w700, color: C.muted)),
      ])),
      _headerAction(Icons.search),
      const SizedBox(width: 5),
      _headerAction(Icons.notifications_none, dot: true),
      const SizedBox(width: 5),
      _headerAction(Icons.qr_code_scanner),
    ]),
  );

  Widget _headerAction(IconData icon, {bool dot = false}) => Stack(clipBehavior: Clip.none, children: [
    Container(width: 34, height: 34, decoration: BoxDecoration(
      color: C.ivory, borderRadius: BorderRadius.circular(12), border: Border.all(color: C.line),
      boxShadow: const [BoxShadow(color: Color(0x1A806600), blurRadius: 4, offset: Offset(0, 2))],
    ), child: Icon(icon, color: C.ink, size: 19)),
    if (dot) Positioned(right: -2, top: -3, child: Container(width: 11, height: 11, decoration: BoxDecoration(color: C.red, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)))),
  ]);

  Widget _memberCard(bool compact) => Container(
    padding: EdgeInsets.all(compact ? 9 : 12),
    decoration: BoxDecoration(
      color: C.ivory, borderRadius: BorderRadius.circular(19),
      border: Border.all(color: C.gold, width: 1.2),
      boxShadow: const [BoxShadow(color: Color(0x26A77D00), blurRadius: 8, offset: Offset(0, 3))],
    ),
    child: Column(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(width: compact ? 61 : 70, height: compact ? 61 : 70,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFFFE7A1), Color(0xFFEAC044)]),
            borderRadius: BorderRadius.circular(16), border: Border.all(color: C.gold, width: 1.5)),
          child: ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset('assets/images/avatar_ashwani_hq.png', fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 43, color: Color(0xFF7A4A23))))),
        const SizedBox(width: 9),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(spacing: 5, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
            _pill('✓ CHECKED-IN', C.green, Colors.white),
            const Text('16 Oct · 07:12 AM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: C.muted)),
          ]),
          const SizedBox(height: 4),
          const Text('Ashwani Kumar Sharma Vishwakarma', maxLines: 2, overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, height: 1.12, fontWeight: FontWeight.w900, color: C.ink)),
          const SizedBox(height: 3),
          const Text('BG215  ·  28 Yrs  ·  ♂ Male', style: TextStyle(fontSize: 9, color: C.muted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Wrap(spacing: 5, children: [_pill('✓ Active', C.green, Colors.white), _pill('♛ Gold Plan', C.yellow, C.ink)]),
        ])),
        const SizedBox(width: 4),
        const Icon(Icons.qr_code_2, size: 28, color: C.ink),
      ]),
      const SizedBox(height: 8),
      Container(height: 1, color: C.line),
      const SizedBox(height: 6),
      Row(children: [
        const Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Membership  22 / 30 Days', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: C.ink)),
          SizedBox(height: 4),
          ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20)), child: LinearProgressIndicator(value: .73, minHeight: 6, backgroundColor: Color(0xFFE8E3D6), valueColor: AlwaysStoppedAnimation(C.green))),
        ])),
        const SizedBox(width: 7),
        _pill('73%', const Color(0xFFFFE58A), C.ink),
        const SizedBox(width: 7),
        Container(width: 1, height: 28, color: C.line),
        const SizedBox(width: 7),
        const Icon(Icons.event, size: 17, color: C.red),
        const SizedBox(width: 4),
        const Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('24 Oct 2026', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: C.red)),
          Text('Expires · 8 days left', style: TextStyle(fontSize: 8, color: C.muted)),
        ])),
      ]),
    ]),
  );

  Widget _pill(String text, Color bg, Color fg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white, width: .8)),
    child: Text(text, style: TextStyle(fontSize: 8, height: 1.1, fontWeight: FontWeight.w800, color: fg)),
  );

  Widget _sponsor(bool compact) => Container(
    height: compact ? 47 : 56,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFFFFE875), Color(0xFFFFC400), Color(0xFFFFF1A9)]),
      borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white, width: 1.5),
      boxShadow: const [BoxShadow(color: Color(0x2AA77D00), blurRadius: 5, offset: Offset(0, 2))],
    ),
    child: Row(children: [
      const Expanded(flex: 3, child: Text('amazon', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: C.ink))),
      Container(width: 1, height: 27, color: Color(0x668C6800)),
      const SizedBox(width: 7),
      const Expanded(flex: 4, child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('GREAT INDIAN FESTIVAL', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: C.red)),
        Text('Up to 40% OFF · Fitness', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: C.ink)),
      ])),
      Image.asset('assets/images/shaker_badgym.png', width: 27, height: 39, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.fitness_center, size: 22, color: C.ink)),
      const SizedBox(width: 3),
      _pill('SPONSORED', C.green, Colors.white),
    ]),
  );

  Widget _metricTabs(bool compact) {
    final data = [
      (Icons.calendar_month, 'Attendance', '81%', '+6%', C.green),
      (Icons.fitness_center, 'Workout', '58 min', '+12%', C.purple),
      (Icons.account_balance_wallet, 'Payment', '₹500 Due', 'SBI offer', C.red),
      (Icons.monitor_weight, 'Body', '69.5 kg', '-0.8 kg', C.blue),
    ];
    return SizedBox(height: compact ? 70 : 78, child: Row(children: List.generate(data.length, (i) {
      final d = data[i];
      final selected = tab == i;
      return Expanded(child: Padding(padding: EdgeInsets.only(right: i == 3 ? 0 : 5), child: InkWell(
        borderRadius: BorderRadius.circular(13), onTap: () => setState(() { tab = i; rail = 0; }),
        child: AnimatedContainer(duration: const Duration(milliseconds: 180), padding: EdgeInsets.symmetric(horizontal: 4, vertical: compact ? 3 : 6),
          decoration: BoxDecoration(
            gradient: selected ? const LinearGradient(colors: [Color(0xFFFFF1B0), Color(0xFFFFD84A)]) : const LinearGradient(colors: [Colors.white, Color(0xFFFFFCF2)]),
            borderRadius: BorderRadius.circular(13), border: Border.all(color: selected ? C.gold : C.line, width: selected ? 1.4 : .8),
            boxShadow: const [BoxShadow(color: Color(0x18866A00), blurRadius: 4, offset: Offset(0, 2))]),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(d.$1, color: d.$5, size: compact ? 15 : 17),
            SizedBox(height: compact ? 1 : 2),
            Text(d.$2, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: C.ink)),
            FittedBox(fit: BoxFit.scaleDown, child: Text(d.$3, style: TextStyle(fontSize: compact ? 12 : 13, fontWeight: FontWeight.w900, color: d.$5))),
            Text(d.$4, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 7, fontWeight: FontWeight.w800, color: d.$5)),
          ]),
        ),
      )));
    })));
  }

  Widget _workspace(bool compact) {
    final titles = ['Attendance Intelligence', 'Workout Intelligence', 'Payment Intelligence', 'Body Intelligence'];
    final activeRails = tab == 0 ? rails : (tab == 1 ? ['Sessions', 'Volume', 'History', 'Goals'] : tab == 2 ? ['Due', 'Payments', 'Offers', 'History'] : ['Weight', 'Measures', 'Progress', 'Goals']);
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(color: C.ivory, borderRadius: BorderRadius.circular(17), border: Border.all(color: C.gold, width: 1.1),
        boxShadow: const [BoxShadow(color: Color(0x22A77D00), blurRadius: 7, offset: Offset(0, 3))]),
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(width: 48, child: Container(
          decoration: BoxDecoration(color: const Color(0xFFFFF6D7), borderRadius: BorderRadius.circular(12), border: Border.all(color: C.line)),
          child: Column(children: List.generate(activeRails.length, (i) => Expanded(child: InkWell(
            onTap: () => setState(() => rail = i),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
              decoration: BoxDecoration(
                color: rail == i ? C.yellow : Colors.transparent,
                borderRadius: BorderRadius.circular(9),
                border: rail == i ? Border.all(color: C.gold, width: .8) : null),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(_railIcon(i), size: 15, color: C.ink),
                const SizedBox(height: 1),
                Text(activeRails[i], maxLines: 1, overflow: TextOverflow.clip, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.w700, color: C.ink)),
              ]),
            ),
          )))),
        )),
        const SizedBox(width: 6),
        Expanded(child: Column(children: [
          Row(children: [
            Expanded(child: Text(titles[tab], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: C.ink))),
            if (tab == 0 && rail == 0) InkWell(onTap: () => setState(() => monthOffset++), child: Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFFFF2C4), borderRadius: BorderRadius.circular(12), border: Border.all(color: C.line)), child: Text(_monthLabel(), style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800)))),
          ]),
          const SizedBox(height: 5),
          Expanded(child: _selectedContent(compact)),
        ])),
      ]),
    );
  }

  IconData _railIcon(int i) => switch (i) { 0 => Icons.calendar_month, 1 => Icons.query_stats, 2 => Icons.history, 3 => Icons.auto_awesome, 4 => Icons.track_changes, _ => Icons.more_horiz };

  String _monthLabel() {
    final date = DateTime(2026, 10 + monthOffset, 1);
    const names = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${names[date.month - 1]} ${date.year}  ›';
  }

  Widget _selectedContent(bool compact) {
    if (tab == 0) {
      return switch (rail) {
        0 => _attendanceCalendar(compact),
        1 => _attendanceTrend(compact),
        2 => _attendanceRecord(compact),
        3 => _attendanceInsights(compact),
        4 => _attendanceGoals(compact),
        _ => _morePanel('Attendance', Icons.calendar_month_rounded),
      };
    }
    if (tab == 1) {
      return switch (rail) {
        0 => _workoutSessions(compact),
        1 => _workoutVolume(compact),
        2 => _workoutHistory(compact),
        _ => _workoutGoals(compact),
      };
    }
    if (tab == 2) {
      return switch (rail) {
        0 => _paymentDue(compact),
        1 => _paymentHistory(compact),
        2 => _paymentOffers(compact),
        _ => _paymentHistory(compact),
      };
    }
    return switch (rail) {
      0 => _bodyWeight(compact),
      1 => _bodyMeasures(compact),
      2 => _bodyProgress(compact),
      _ => _bodyGoals(compact),
    };
  }

  Widget _attendanceCalendar(bool compact) => Column(children: [
    SizedBox(height: compact ? 66 : 76, child: Row(children: [
      Expanded(flex: 3, child: Center(child: SizedBox(
        width: compact ? 48 : 56, height: compact ? 48 : 56,
        child: CustomPaint(painter: _RingPainter(.81), child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: const [
          Text('81%', style: TextStyle(fontSize: 13, height: 1, fontWeight: FontWeight.w900, color: C.ink)),
          Text('25 / 31', style: TextStyle(fontSize: 7, height: 1.1, fontWeight: FontWeight.w700, color: C.muted)),
        ]))),
      ))),
      Expanded(flex: 4, child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        _legendRow(C.green, 'Present', '23', .81),
        _legendRow(C.gold, 'Late', '2', .07),
        _legendRow(C.red, 'Absent', '2', .07),
        _legendRow(const Color(0xFF9CA3AF), 'Holiday', '4', .13),
      ]))),
      Expanded(flex: 3, child: Center(child: FittedBox(fit: BoxFit.scaleDown, child: Column(mainAxisSize: MainAxisSize.min, children: const [
        Text('🔥 5 DAYS', style: TextStyle(fontSize: 10, height: 1, fontWeight: FontWeight.w900, color: C.red)),
        SizedBox(height: 4),
        Text('🏆 14 BEST', style: TextStyle(fontSize: 9, height: 1, fontWeight: FontWeight.w800, color: C.ink)),
      ])))),
    ])),
    const SizedBox(height: 4),
    Expanded(child: _calendar()),
  ]);

  Widget _attendanceTrend(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Monthly attendance trend', 'Daily consistency · Oct 2026', Icons.query_stats),
    const SizedBox(height: 8),
    Expanded(child: Container(
      padding: const EdgeInsets.all(9),
      decoration: _innerDecoration(),
      child: Column(children: [
        Expanded(child: CustomPaint(size: Size.infinite, painter: _MiniTrendPainter())),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('1 OCT', style: TextStyle(fontSize: 8, color: C.muted, fontWeight: FontWeight.w700)),
          Text('10 OCT', style: TextStyle(fontSize: 8, color: C.muted, fontWeight: FontWeight.w700)),
          Text('20 OCT', style: TextStyle(fontSize: 8, color: C.muted, fontWeight: FontWeight.w700)),
          Text('31 OCT', style: TextStyle(fontSize: 8, color: C.muted, fontWeight: FontWeight.w700)),
        ]),
      ]),
    )),
    const SizedBox(height: 7),
    Row(children: [
      _smallMetric('Average', '81%', C.green),
      const SizedBox(width: 5),
      _smallMetric('Peak', '97%', C.goldDark),
      const SizedBox(width: 5),
      _smallMetric('Low', '58%', C.red),
    ]),
  ]);

  Widget _attendanceRecord(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Attendance record', 'Recent check-in activity', Icons.history_rounded),
    const SizedBox(height: 8),
    _recordRow('16 Oct 2026', '07:12 AM', 'Present', C.green),
    _recordRow('15 Oct 2026', '06:45 PM', 'Present', C.green),
    _recordRow('14 Oct 2026', '07:05 AM', 'Present', C.green),
    _recordRow('13 Oct 2026', '07:30 AM', 'Present', C.green),
    const Spacer(),
    _artTile('assets/images/illustration_3d_attendance_calendar.png', 'Attendance history', 'Recorded check-ins', compact),
  ]);

  Widget _attendanceInsights(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Attendance insights', 'Consistency overview', Icons.auto_awesome),
    const SizedBox(height: 8),
    Row(children: [
      Expanded(child: _highlightMetric('81%', 'Attendance', C.green)),
      const SizedBox(width: 6),
      Expanded(child: _highlightMetric('5 days', 'Current streak', C.goldDark)),
    ]),
    const SizedBox(height: 7),
    _recordRow('Best streak', '14 days', 'Personal best', C.gold),
    _recordRow('Present', '23 days', 'This month', C.green),
    _recordRow('Late', '2 days', 'This month', C.gold),
    _recordRow('Absent', '2 days', 'This month', C.red),
    const Spacer(),
    _artTile('assets/badges/streak_flame_3d.png', 'Keep the streak alive', 'Build a consistent routine', compact),
  ]);

  Widget _attendanceGoals(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Attendance goal', 'Monthly target', Icons.track_changes),
    const SizedBox(height: 12),
    _highlightMetric('25 / 31', 'Days attended', C.green),
    const SizedBox(height: 10),
    ClipRRect(borderRadius: BorderRadius.circular(20), child: const LinearProgressIndicator(value: .81, minHeight: 10, backgroundColor: Color(0xFFEAE4D6), valueColor: AlwaysStoppedAnimation(C.green))),
    const SizedBox(height: 6),
    const Text('81% of calendar days recorded as attended', style: TextStyle(fontSize: 9, color: C.muted)),
    const Spacer(),
    _artTile('assets/images/illustration_3d_attendance_calendar.png', 'Stay consistent', 'Attendance goal progress', compact),
  ]);

  Widget _workoutSessions(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Workout sessions', 'Today’s training snapshot', Icons.fitness_center_rounded),
    const SizedBox(height: 7),
    Row(children: [
      Expanded(child: _highlightMetric('58 min', 'Workout duration', C.goldDark)),
      const SizedBox(width: 6),
      Expanded(child: _highlightMetric('+12%', 'Change', C.green)),
    ]),
    const SizedBox(height: 7),
    _artTile('assets/images/illustration_3d_workout_dumbbells.png', 'Training session', 'Workout duration recorded today', compact),
    const SizedBox(height: 6),
    _recordRow('Session status', 'Recorded', 'Today', C.green),
  ]);

  Widget _workoutVolume(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Workout volume', 'Training overview', Icons.bar_chart_rounded),
    const SizedBox(height: 8),
    _highlightMetric('58 min', 'Recorded workout time', C.goldDark),
    const SizedBox(height: 8),
    _artTile('assets/images/illustration_3d_workout_bench.png', 'Workout overview', 'Detailed set and load records are not connected in this build', compact),
  ]);

  Widget _workoutHistory(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Workout history', 'Recent activity', Icons.history_rounded),
    const SizedBox(height: 8),
    _recordRow('Today', '58 min', 'Recorded', C.green),
    const Spacer(),
    _artTile('assets/images/illustration_3d_workout_dumbbells.png', 'Workout history', 'Only the current duration metric is available', compact),
  ]);

  Widget _workoutGoals(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Workout goals', 'Training consistency', Icons.flag_rounded),
    const SizedBox(height: 8),
    _highlightMetric('58 min', 'Today’s duration', C.goldDark),
    const Spacer(),
    _artTile('assets/images/illustration_3d_workout_bench.png', 'Training progress', 'Set a goal when workout target data is connected', compact),
  ]);

  Widget _paymentDue(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Payment due', 'Membership billing', Icons.account_balance_wallet_rounded),
    const SizedBox(height: 8),
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFF2C5), Color(0xFFFFE18A)]),
        borderRadius: BorderRadius.circular(13), border: Border.all(color: C.gold),
      ),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('OUTSTANDING AMOUNT', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: C.muted)),
          SizedBox(height: 2),
          Text('₹500 Due', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: C.red)),
          Text('Next due · 24 Oct 2026', style: TextStyle(fontSize: 8, color: C.ink)),
        ])),
        Image.asset('assets/images/illustration_3d_payment_wallet.png', width: compact ? 54 : 66, height: compact ? 54 : 66, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.account_balance_wallet, size: 42, color: C.goldDark)),
      ]),
    ),
    const SizedBox(height: 8),
    _recordRow('Membership plan', 'Gold Plan', 'Active', C.goldDark),
    _recordRow('Payment status', 'Due', 'Action required', C.red),
    const Spacer(),
    _actionStrip('Review payment', Icons.arrow_forward_rounded, C.red),
  ]);

  Widget _paymentHistory(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Payment history', 'Billing records', Icons.receipt_long_rounded),
    const SizedBox(height: 8),
    _recordRow('Current balance', '₹500 Due', 'Outstanding', C.red),
    _recordRow('Next due date', '24 Oct 2026', 'Upcoming', C.goldDark),
    const Spacer(),
    _artTile('assets/images/illustration_3d_payment_wallet.png', 'Billing history', 'Transaction history is not connected in this build', compact),
  ]);

  Widget _paymentOffers(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Member offers', 'Available promotions', Icons.local_offer_rounded),
    const SizedBox(height: 8),
    _highlightMetric('SBI offer', 'Offer shown on member dashboard', C.blue),
    const Spacer(),
    _artTile('assets/images/illustration_3d_payment_wallet.png', 'Payment offers', 'Offer details depend on the active campaign', compact),
  ]);

  Widget _bodyWeight(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Body weight', 'Current measurement', Icons.monitor_weight_rounded),
    const SizedBox(height: 7),
    Row(children: [
      Expanded(child: _highlightMetric('69.5 kg', 'Current weight', C.blue)),
      const SizedBox(width: 6),
      Expanded(child: _highlightMetric('−0.8 kg', 'Change shown', C.green)),
    ]),
    const SizedBox(height: 5),
    _artTile('assets/images/illustration_3d_body_scale.png', 'Body composition', 'Current recorded weight', compact),
  ]);

  Widget _bodyMeasures(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Body measurements', 'Measurement workspace', Icons.straighten_rounded),
    const SizedBox(height: 8),
    _highlightMetric('69.5 kg', 'Current recorded weight', C.blue),
    const Spacer(),
    _artTile('assets/images/illustration_3d_mannequin.png', 'Measurements', 'Other body measurements are not connected in this build', compact),
  ]);

  Widget _bodyProgress(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Body progress', 'Weight change', Icons.trending_down_rounded),
    const SizedBox(height: 8),
    _highlightMetric('−0.8 kg', 'Change shown on member card', C.green),
    const Spacer(),
    _artTile('assets/images/illustration_3d_body_scale.png', 'Progress tracking', 'Historical measurement series is not connected in this build', compact),
  ]);

  Widget _bodyGoals(bool compact) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    _workspaceHeading('Body goals', 'Goal tracking', Icons.flag_rounded),
    const SizedBox(height: 8),
    _highlightMetric('69.5 kg', 'Current weight', C.blue),
    const Spacer(),
    _artTile('assets/images/illustration_3d_mannequin.png', 'Personal goals', 'Connect a member goal to show target progress', compact),
  ]);

  Widget _morePanel(String title, IconData icon) => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Icon(icon, size: 28, color: C.goldDark),
    const SizedBox(height: 6),
    Text('$title tools', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: C.ink)),
    const Text('More member details', style: TextStyle(fontSize: 9, color: C.muted)),
  ]));

  Widget _workspaceHeading(String title, String subtitle, IconData icon) => Row(children: [
    Container(width: 25, height: 25, decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFFFFD84A), Color(0xFFE7A900)]),
      borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, color: C.ink, size: 14)),
    const SizedBox(width: 6),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: C.ink)),
      Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 8, color: C.muted)),
    ])),
  ]);

  BoxDecoration _innerDecoration() => BoxDecoration(
    color: const Color(0xFFFFFCF3), borderRadius: BorderRadius.circular(11),
    border: Border.all(color: C.line),
  );

  Widget _smallMetric(String label, String value, Color color) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
    decoration: _innerDecoration(),
    child: Column(children: [
      Text(label, style: const TextStyle(fontSize: 7, color: C.muted, fontWeight: FontWeight.w700)),
      Text(value, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w900)),
    ]),
  ));

  Widget _highlightMetric(String value, String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
    decoration: _innerDecoration(),
    child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 8, color: C.muted, fontWeight: FontWeight.w700)),
      const SizedBox(height: 2),
      FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text(value, style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.w900))),
    ]),
  );

  Widget _recordRow(String label, String value, String detail, Color color) => Container(
    margin: const EdgeInsets.only(bottom: 5),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
    decoration: _innerDecoration(),
    child: Row(children: [
      Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 6),
      Expanded(child: Text(label, style: const TextStyle(fontSize: 8, color: C.muted, fontWeight: FontWeight.w700))),
      Text(value, style: const TextStyle(fontSize: 9, color: C.ink, fontWeight: FontWeight.w900)),
      const SizedBox(width: 5),
      Text(detail, style: TextStyle(fontSize: 7, color: color, fontWeight: FontWeight.w800)),
    ]),
  );

  Widget _artTile(String asset, String title, String subtitle, bool compact) => Expanded(child: Container(
    width: double.infinity,
    padding: const EdgeInsets.all(6),
    decoration: _innerDecoration(),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(child: Image.asset(asset, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.fitness_center_rounded, size: 38, color: C.goldDark))),
      const SizedBox(height: 3),
      Text(title, style: const TextStyle(fontSize: 10, color: C.ink, fontWeight: FontWeight.w900)),
      Text(subtitle, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 7, color: C.muted)),
    ]),
  ));

  Widget _actionStrip(String label, IconData icon, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(color: color.withValues(alpha: .08), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withValues(alpha: .3))),
    child: Row(children: [
      Expanded(child: Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: color))),
      Icon(icon, size: 15, color: color),
    ]),
  );

  Widget _legendRow(Color color, String label, String count, double progress) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [
      Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 4),
      Expanded(child: Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: C.ink))),
      Text(count, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900)),
      const SizedBox(width: 4),
      SizedBox(width: 27, child: ClipRRect(borderRadius: BorderRadius.circular(9), child: LinearProgressIndicator(value: progress, minHeight: 4, backgroundColor: const Color(0xFFECE8DD), valueColor: AlwaysStoppedAnimation(color)))),
    ]),
  );

  Widget _calendar() {
    const weekdays = ['M','T','W','T','F','S','S'];
    final states = <int, int>{1:0,2:0,3:1,4:0,5:1,6:1,7:1,8:1,9:1,10:2,11:0,12:1,13:1,14:1,15:1,16:1,17:3,18:1,19:1,20:1,21:2,22:1,23:3,24:3,25:4,26:1,27:1,28:2,29:1,30:1,31:1};
    final firstWeekday = DateTime(2026, 10 + monthOffset, 1).weekday - 1;
    final days = DateTime(2026, 10 + monthOffset + 1, 0).day;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: const Color(0xFFFFFCF3), borderRadius: BorderRadius.circular(11), border: Border.all(color: C.line)),
      child: Column(children: [
        Row(
          children: [
            for (var i = 0; i < 7; i++)
              Expanded(
                child: Center(
                  child: Text(
                    weekdays[i],
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: i > 4 ? C.red : C.muted,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Expanded(child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 3, crossAxisSpacing: 3, childAspectRatio: 1.55),
          itemCount: firstWeekday + days,
          itemBuilder: (context, index) {
            if (index < firstWeekday) return const SizedBox.shrink();
            final day = index - firstWeekday + 1;
            final state = states[day] ?? 0;
            final isSunday = (firstWeekday + day - 1) % 7 == 6;
            final color = isSunday || state == 0 || state == 4 ? const Color(0xFFE4E5E8) : switch (state) { 1 => C.green, 2 => C.gold, 3 => C.red, _ => const Color(0xFFE4E5E8) };
            final textColor = isSunday || state == 0 || state == 4 ? C.muted : Colors.white;
            return Container(
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20), border: day == 16 ? Border.all(color: C.ink, width: 1.2) : null,
                boxShadow: state == 0 ? null : const [BoxShadow(color: Color(0x18000000), blurRadius: 2, offset: Offset(0, 1))]),
              alignment: Alignment.center,
              child: Text(isSunday ? 'OFF' : '$day', style: TextStyle(fontSize: isSunday ? 6.5 : 8, fontWeight: FontWeight.w900, color: textColor)),
            );
          },
        )),
      ]),
    );
  }
}

class _MiniTrendPainter extends CustomPainter {
  const _MiniTrendPainter();

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final values = <double>[.70, .97, .88, .76, .60, .72, .82, .58, .85, .72, .86, .74, .78, .81];
    final chart = Rect.fromLTWH(4, 8, size.width - 8, size.height - 16);
    final gridPaint = Paint()
      ..color = const Color(0xFFE9DFC7)
      ..strokeWidth = 1;
    for (var i = 0; i < 4; i++) {
      final y = chart.top + chart.height * i / 3;
      canvas.drawLine(Offset(chart.left, y), Offset(chart.right, y), gridPaint);
    }
    final points = <Offset>[
      for (var i = 0; i < values.length; i++)
        Offset(chart.left + chart.width * i / (values.length - 1),
            chart.bottom - chart.height * values[i]),
    ];
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      final previous = points[i - 1];
      final current = points[i];
      final mid = (previous.dx + current.dx) / 2;
      path.cubicTo(mid, previous.dy, mid, current.dy, current.dx, current.dy);
    }
    final fill = Path.from(path)
      ..lineTo(chart.right, chart.bottom)
      ..lineTo(chart.left, chart.bottom)
      ..close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x66E7A900), Color(0x00E7A900)],
        ).createShader(chart),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFF168B35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    for (final point in points) {
      canvas.drawCircle(point, 2.6, Paint()..color = const Color(0xFF168B35));
      canvas.drawCircle(
        point,
        1.2,
        Paint()..color = Colors.white,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MiniTrendPainter oldDelegate) => false;
}

class _RingPainter extends CustomPainter {
  final double value;
  const _RingPainter(this.value);
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final p = Paint()..style = PaintingStyle.stroke..strokeWidth = 6..strokeCap = StrokeCap.round;
    p.color = const Color(0xFFE7E4DA);
    canvas.drawArc(rect.deflate(4), -1.5708, 6.2832, false, p);
    p.shader = const SweepGradient(colors: [C.green, Color(0xFF8BD34B), C.green]).createShader(rect);
    canvas.drawArc(rect.deflate(4), -1.5708, 6.2832 * value, false, p);
  }
  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) => oldDelegate.value != value;
}
