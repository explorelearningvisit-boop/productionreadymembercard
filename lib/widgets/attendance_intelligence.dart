import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../data/sample_member.dart';
import '../theme/member_theme.dart';

class AttendanceIntelligence extends StatelessWidget {
  final int section;
  final ValueChanged<int> onSelect;

  const AttendanceIntelligence({
    super.key,
    required this.section,
    required this.onSelect,
  });

  static const labels = ['Attendance', 'Trend', 'History', 'More'];
  static const icons = <IconData>[
    Icons.calendar_month_rounded,
    Icons.stacked_line_chart_rounded,
    Icons.history_rounded,
    Icons.tune_rounded,
  ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _MetricRow(),
          const SizedBox(height: 7),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Rail(section: section, onSelect: onSelect),
                const SizedBox(width: 6),
                Expanded(child: _Panel(section: section)),
              ],
            ),
          ),
        ],
      );
}

class _Rail extends StatelessWidget {
  final int section;
  final ValueChanged<int> onSelect;

  const _Rail({required this.section, required this.onSelect});

  @override
  Widget build(BuildContext context) => Container(
        width: 46,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF9333EA), Color(0xFF6D28D9), Color(0xFF4C1D95)],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x886D28D9),
              blurRadius: 14,
              offset: Offset(0, 5),
            ),
          ],
          border: Border.all(color: const Color(0xFFFFD76A), width: 1.2),
        ),
        child: Column(
          children: List.generate(AttendanceIntelligence.labels.length, (index) {
            final selected = section == index;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    key: ValueKey('rail-${AttendanceIntelligence.labels[index]}'),
                    onTap: () => onSelect(index),
                    borderRadius: BorderRadius.circular(15),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: selected
                            ? const Color(0xFFFFF8E8)
                            : Colors.transparent,
                        border: selected
                            ? Border.all(
                                color: const Color(0xFFFFD76A), width: 1)
                            : null,
                        boxShadow: selected
                            ? const [
                                BoxShadow(
                                  color: Color(0x66FFFFFF),
                                  blurRadius: 8,
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            AttendanceIntelligence.icons[index],
                            size: 17,
                            color: selected
                                ? MemberTheme.deepPurple
                                : Colors.white,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            AttendanceIntelligence.labels[index],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 7,
                              fontWeight: FontWeight.w900,
                              color: selected
                                  ? MemberTheme.deepPurple
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
}

class _MetricRow extends StatelessWidget {
  const _MetricRow();

  @override
  Widget build(BuildContext context) => const Row(
        children: [
          Expanded(
            child: _MetricTile(
              icon: Icons.calendar_month_rounded,
              label: 'Attendance',
              value: MemberSample.attendancePercentLabel,
              background: Color(0xFFDCFCE7),
              accent: MemberTheme.greenInk,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: _MetricTile(
              icon: Icons.fitness_center_rounded,
              label: 'Workout',
              value: '${MemberSample.workoutMinutes} min',
              background: Color(0xFFF3E8FF),
              accent: MemberTheme.purple,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: _MetricTile(
              icon: Icons.account_balance_wallet_rounded,
              label: 'Payment',
              value: MemberSample.dueLabel,
              background: Color(0xFFFFEDD5),
              accent: Color(0xFFEA580C),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: _MetricTile(
              icon: Icons.monitor_weight_rounded,
              label: 'Body',
              value: MemberSample.bodyLabel,
              background: Color(0xFFE0F2FE),
              accent: Color(0xFF0284C7),
            ),
          ),
        ],
      );
}

class _MetricTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color background;
  final Color accent;
  const _MetricTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.background,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: const [
            BoxShadow(
                color: Color(0x187A18D1), blurRadius: 8, offset: Offset(0, 3))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: accent, size: 18),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: MemberTheme.ink),
            ),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w900, color: accent),
            ),
          ],
        ),
      );
}

class _Panel extends StatelessWidget {
  final int section;
  const _Panel({required this.section});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
        decoration: MemberTheme.glass(radius: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _PanelHeader(),
            const SizedBox(height: 5),
            switch (section) {
              0 => const _HomeOverview(),
              1 => const _WorkoutOverview(),
              2 => const _HistoryOverview(),
              _ => const _MoreOverview(),
            },
          ],
        ),
      );
}

class _PanelHeader extends StatelessWidget {
  const _PanelHeader();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [MemberTheme.violet, MemberTheme.deepPurple]),
            ),
            child: const Icon(Icons.insights_rounded,
                color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Attendance Intelligence',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: MemberTheme.ink),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1F2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFB7185)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: MemberTheme.red, shape: BoxShape.circle),
                  child: SizedBox(width: 7, height: 7),
                ),
                SizedBox(width: 4),
                Text('LIVE',
                    style: TextStyle(
                        color: MemberTheme.red,
                        fontSize: 10,
                        fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ],
      );
}

class _HomeOverview extends StatelessWidget {
  const _HomeOverview();

  @override
  Widget build(BuildContext context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Home overview',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: MemberTheme.deepPurple)),
          SizedBox(height: 2),
          Text(
            'Check-in complete · ${MemberSample.checkInTime}',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: MemberTheme.ink),
          ),
          SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _AttendanceDonut(),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    _StatLine(
                        color: MemberTheme.green,
                        label: 'Present',
                        count: '25',
                        percent: '81%',
                        value: 0.81),
                    _StatLine(
                        color: MemberTheme.red,
                        label: 'Absent',
                        count: '2',
                        percent: '6%',
                        value: 0.06),
                    _StatLine(
                        color: MemberTheme.purple,
                        label: 'Holiday',
                        count: '4',
                        percent: '13%',
                        value: 0.13),
                    _StatLine(
                        color: MemberTheme.goldDeep,
                        label: 'Payment',
                        count: '1/1',
                        percent: '100%',
                        value: 1),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(height: 1, color: MemberTheme.line),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: _Foot(
                      icon: Icons.local_fire_department_rounded,
                      value: MemberSample.streakLabel,
                      color: MemberTheme.red)),
              Expanded(
                  child: _Foot(
                      icon: Icons.emoji_events_rounded,
                      value: MemberSample.trophyLabel,
                      color: MemberTheme.purple)),
              Expanded(
                  child: _Foot(
                      icon: Icons.trending_up_rounded,
                      value: MemberSample.trendLabel,
                      color: MemberTheme.greenInk)),
            ],
          ),
          SizedBox(height: 6),
          Text(MemberSample.sampleNote,
              style: TextStyle(
                  fontSize: 8,
                  color: MemberTheme.muted,
                  fontWeight: FontWeight.w600)),
        ],
      );
}

class _AttendanceDonut extends StatelessWidget {
  const _AttendanceDonut();

  @override
  Widget build(BuildContext context) => const SizedBox(
        width: 78,
        height: 78,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(size: Size(78, 78), painter: _DonutPainter()),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('81%',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: MemberTheme.ink,
                        height: 1)),
                Text(MemberSample.attendedLabel,
                    style: TextStyle(
                        fontSize: 10,
                        color: MemberTheme.muted,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      );
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect.deflate(6), 0, math.pi * 2, false,
        stroke..color = const Color(0xFFFCE7F3));
    stroke.color = MemberTheme.green;
    canvas.drawArc(
        rect.deflate(6), -math.pi / 2, math.pi * 2 * 0.81, false, stroke);
    stroke.color = const Color(0xFFF472B6);
    canvas.drawArc(rect.deflate(6), -math.pi / 2 + math.pi * 2 * 0.81,
        math.pi * 2 * 0.16, false, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StatLine extends StatelessWidget {
  final Color color;
  final String label;
  final String count;
  final String percent;
  final double value;
  const _StatLine({
    required this.color,
    required this.label,
    required this.count,
    required this.percent,
    required this.value,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Row(
          children: [
            Container(
                width: 8,
                height: 8,
                decoration:
                    BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 4),
            SizedBox(
              width: 48,
              child: Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w800)),
            ),
            SizedBox(
              width: 24,
              child: Text(count,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w900)),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 7,
                  backgroundColor: color.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 32,
              child: Text(percent,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      fontSize: 9,
                      color: MemberTheme.muted,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
}

class _Foot extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;
  const _Foot({required this.icon, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 3),
          Text(value,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w900, color: color)),
        ],
      );
}

class _AttendCalendar extends StatelessWidget {
  const _AttendCalendar();

  @override
  Widget build(BuildContext context) {
    const heads = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    final leading = DateTime(2026, 10, 1).weekday % 7;
    final cells = <Widget>[
      for (final head in heads)
        Center(
            child: Text(head,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: MemberTheme.muted))),
      for (var i = 0; i < leading; i++) const SizedBox.shrink(),
      for (var day = 1; day <= MemberSample.monthDays; day++)
        _DayCell(day: day),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('October attendance',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: MemberTheme.deepPurple)),
        const SizedBox(height: 2),
        const Text('25 present · 2 absent · 4 holiday',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.05,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          children: cells,
        ),
        const SizedBox(height: 6),
        const Text(MemberSample.sampleNote,
            style: TextStyle(fontSize: 8, color: MemberTheme.muted)),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  const _DayCell({required this.day});

  @override
  Widget build(BuildContext context) {
    final kind = MemberSample.kindFor(day);
    final color = switch (kind) {
      DayKind.present => const Color(0xFFDCFCE7),
      DayKind.absent => const Color(0xFFFFE4E6),
      DayKind.holiday => const Color(0xFFF3E8FF),
    };
    final ink = switch (kind) {
      DayKind.present => MemberTheme.greenInk,
      DayKind.absent => MemberTheme.red,
      DayKind.holiday => MemberTheme.purple,
    };
    final today = day == MemberSample.today;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: today ? MemberTheme.purple : Colors.white,
            width: today ? 1.6 : 1),
      ),
      child: Center(
        child: Text(
          '$day',
          style:
              TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: ink),
        ),
      ),
    );
  }
}

class _WorkoutOverview extends StatelessWidget {
  const _WorkoutOverview();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Workout overview',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: MemberTheme.deepPurple)),
          const SizedBox(height: 4),
          const Text('58 min',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: MemberTheme.ink,
                  height: 1)),
          const Text('Today · strength and cardio',
              style: TextStyle(
                  fontSize: 11,
                  color: MemberTheme.muted,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          for (final block in MemberSample.blocks)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  SizedBox(
                      width: 72,
                      child: Text(block.name,
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w800))),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: block.minutes / MemberSample.workoutMinutes,
                        minHeight: 8,
                        backgroundColor: const Color(0xFFF3E8FF),
                        valueColor:
                            const AlwaysStoppedAnimation(MemberTheme.purple),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 36,
                    child: Text('${block.minutes}m',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
            ),
          const Text(MemberSample.sampleNote,
              style: TextStyle(fontSize: 8, color: MemberTheme.muted)),
        ],
      );
}

class _PaymentOverview extends StatelessWidget {
  const _PaymentOverview();

  @override
  Widget build(BuildContext context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment overview',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: MemberTheme.deepPurple)),
          SizedBox(height: 6),
          Text(MemberSample.plan,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: MemberTheme.goldDeep)),
          Text(MemberSample.dueLabel,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFEA580C),
                  height: 1.1)),
          Text('Due before ${MemberSample.expiresLabel}',
              style: TextStyle(
                  fontSize: 11,
                  color: MemberTheme.muted,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text('8 days left on the 30-day Gold cycle.',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: MemberTheme.ink)),
          SizedBox(height: 8),
          Text(MemberSample.sampleNote,
              style: TextStyle(fontSize: 8, color: MemberTheme.muted)),
        ],
      );
}

class _OffersOverview extends StatelessWidget {
  const _OffersOverview();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Member offers',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: MemberTheme.deepPurple)),
          const Text('Big Billion Sale gear locker',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          for (final offer in MemberSample.offers)
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F1FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(offer.name,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w900)),
                        Text(offer.off,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: MemberTheme.purple)),
                      ],
                    ),
                  ),
                  Text(offer.price,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          const Text(MemberSample.sampleNote,
              style: TextStyle(fontSize: 8, color: MemberTheme.muted)),
        ],
      );
}

class _MoreOverview extends StatelessWidget {
  const _MoreOverview();

  @override
  Widget build(BuildContext context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More member insights',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: MemberTheme.deepPurple,
            ),
          ),
          SizedBox(height: 8),
          _AttendCalendar(),
          SizedBox(height: 12),
          Divider(height: 1, color: MemberTheme.line),
          SizedBox(height: 10),
          _PaymentOverview(),
          SizedBox(height: 12),
          Divider(height: 1, color: MemberTheme.line),
          SizedBox(height: 10),
          _OffersOverview(),
        ],
      );
}

class _HistoryOverview extends StatelessWidget {
  const _HistoryOverview();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Check-in history',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: MemberTheme.deepPurple)),
          const SizedBox(height: 6),
          for (final record in MemberSample.history)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: switch (record.kind) {
                        DayKind.present => MemberTheme.green,
                        DayKind.absent => MemberTheme.red,
                        DayKind.holiday => MemberTheme.purple,
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                      width: 52,
                      child: Text(record.day,
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w800))),
                  Expanded(
                      child: Text(record.label,
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600))),
                  Text(record.time,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: MemberTheme.muted)),
                ],
              ),
            ),
          const SizedBox(height: 4),
          const Text(MemberSample.sampleNote,
              style: TextStyle(fontSize: 8, color: MemberTheme.muted)),
        ],
      );
}
