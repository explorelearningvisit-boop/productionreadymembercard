import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/member_theme.dart';
import 'dashboard_primitives.dart';

class AttendancePanel extends StatelessWidget {
  const AttendancePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final palette = MemberPlanTheme.of(context);
        const fullHeight = 370.0;
        const compactHeight = 286.0;
        final availableHeight = constraints.maxHeight;
        if (availableHeight < compactHeight) {
          return FittedBox(
            key: const ValueKey('attendance-panel'),
            fit: BoxFit.scaleDown,
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: constraints.maxWidth,
              height: compactHeight,
              child: _panel(compact: true, palette: palette),
            ),
          );
        }
        final compact = availableHeight < fullHeight;
        return SizedBox(
          key: const ValueKey('attendance-panel'),
          width: constraints.maxWidth,
          height: availableHeight,
          child: _panel(compact: compact, palette: palette),
        );
      },
    );
  }

  Widget _panel({bool compact = false, required MemberPlanPalette palette}) {
    final headerHeight = compact ? 22.0 : 26.0;
    final offerHeight = compact ? 24.0 : 30.0;
    final chartHeight = compact ? 70.0 : 82.0;
    final ringSize = compact ? 62.0 : 74.0;
    final recoveryHeight = compact ? 23.0 : 30.0;
    final calendarTitleHeight = compact ? 23.0 : 27.0;
    final cellHeight = compact ? 28.0 : 34.0;
    final summaryHeight = compact ? 15.0 : 18.0;

    return Container(
      padding: EdgeInsets.fromLTRB(7, compact ? 4 : 6, 7, compact ? 4 : 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFFFF), palette.accentSoft, palette.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: palette.panelEdge, width: 1.35),
        boxShadow: const [
          BoxShadow(color: palette.accent.withOpacity(0.12), blurRadius: 5, offset: Offset(0, 1)),
          BoxShadow(color: Color(0x88FFFFFF), blurRadius: 2),
        ],
      ),
      child: Column(
        // Spread the analytics blocks through the available panel height.
        // This avoids the large dead zone below the calendar in tall layouts.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _header(compact: compact, height: headerHeight, palette: palette),
          SizedBox(height: compact ? 2 : 3),
          _offerBanner(compact: compact, height: offerHeight),
          SizedBox(height: compact ? 2 : 3),
          SizedBox(
            height: chartHeight,
            child: Row(
              children: [
                SizedBox(
                  width: compact ? 66 : 76,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: ringSize,
                        height: ringSize,
                        child: CustomPaint(
                          painter: const _AttendanceRingPainter(),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '81%',
                                  style: TextStyle(
                                    color: MemberTheme.ink,
                                    fontSize: compact ? 17 : 20,
                                    height: 1,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  '25/31',
                                  style: TextStyle(
                                    color: MemberTheme.ink,
                                    fontSize: compact ? 8 : 9,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: compact ? 2 : 4),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AttendanceLegend(
                        compact: compact,
                        color: const Color(0xFF0CCB60),
                        label: 'Present',
                        count: '23',
                        percent: '74%',
                      ),
                      AttendanceLegend(
                        compact: compact,
                        color: const Color(0xFFE52B52),
                        label: 'Absent',
                        count: '2',
                        percent: '6%',
                      ),
                      AttendanceLegend(
                        compact: compact,
                        color: const Color(0xFF8A35D5),
                        label: 'Holiday',
                        count: '4',
                        percent: '13%',
                      ),
                      AttendanceLegend(
                        compact: compact,
                        color: const Color(0xFFFFB21C),
                        label: 'Late',
                        count: '2',
                        percent: '6%',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: compact ? 1 : 2),
          const Divider(height: 1, color: Color(0xFFD8C6E9)),
          SizedBox(height: compact ? 1 : 2),
          Row(
            children: [
              Expanded(child: _MiniStat(icon: '🔥', value: '5d', label: 'Streak', compact: compact)),
              Expanded(child: _MiniStat(icon: '🏆', value: '14d', label: 'Best', compact: compact)),
              Expanded(child: _MiniStat(icon: '↗', value: '+6%', label: 'This Month', compact: compact)),
            ],
          ),
          SizedBox(height: compact ? 1 : 2),
          _recoveryBanner(compact: compact, height: recoveryHeight),
          SizedBox(height: compact ? 1 : 2),
          _calendarTitle(compact: compact, height: calendarTitleHeight, palette: palette),
          SizedBox(
            height: summaryHeight,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '23 present  •  2 late  •  2 absent  •  4 holiday',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: MemberTheme.ink,
                  fontSize: compact ? 8 : 9,
                  height: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Row(
            children: [
              WeekdayLabel('Mon', compact: compact),
              WeekdayLabel('Tue', compact: compact),
              WeekdayLabel('Wed', compact: compact),
              WeekdayLabel('Thu', compact: compact),
              WeekdayLabel('Fri', compact: compact),
              WeekdayLabel('Sat', compact: compact),
              WeekdayLabel('Sun', compact: compact),
            ],
          ),
          Row(
            children: [
              AttendanceDayCell(
                '13',
                height: cellHeight,
                compact: compact,
                key: const ValueKey('attendance-day-13'),
              ),
              AttendanceDayCell('14', height: cellHeight, compact: compact),
              AttendanceDayCell('15', height: cellHeight, compact: compact),
              AttendanceDayCell(
                '16',
                selected: true,
                height: cellHeight,
                compact: compact,
              ),
              AttendanceDayCell(
                '17',
                color: const Color(0xFFFFDDE2),
                height: cellHeight,
                compact: compact,
              ),
              AttendanceDayCell(
                '18',
                color: const Color(0xFFE5E2E9),
                off: true,
                height: cellHeight,
                compact: compact,
              ),
              AttendanceDayCell('19', height: cellHeight, compact: compact),
            ],
          ),
          Row(
            children: [
              AttendanceDayCell('20', height: cellHeight, compact: compact),
              AttendanceDayCell(
                '21',
                color: const Color(0xFFFFEDC7),
                height: cellHeight,
                compact: compact,
              ),
              AttendanceDayCell('22', height: cellHeight, compact: compact),
              AttendanceDayCell(
                '23',
                color: const Color(0xFFFFDDE2),
                height: cellHeight,
                compact: compact,
              ),
              AttendanceDayCell('24', height: cellHeight, compact: compact),
              AttendanceDayCell(
                '25',
                color: const Color(0xFFE5E2E9),
                off: true,
                height: cellHeight,
                compact: compact,
              ),
              AttendanceDayCell('', height: cellHeight, compact: compact),
            ],
          ),
          Text(
            'Sample data • API connection required for live records',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MemberTheme.muted,
              fontSize: compact ? 5.5 : 6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _header({required bool compact, required double height, required MemberPlanPalette palette}) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Container(
            width: compact ? 20 : 23,
            height: compact ? 20 : 23,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [palette.accent, palette.accent.withOpacity(0.78)],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.trending_up_rounded,
              color: Colors.white,
              size: compact ? 14 : 16,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              'Attendance Analytics',
              maxLines: 1,
              style: TextStyle(
                color: MemberTheme.ink,
                fontSize: compact ? 14.2 : 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Icon(
            Icons.notifications_active,
            color: palette.accent,
            size: compact ? 16 : 18,
          ),
          const SizedBox(width: 4),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 6 : 8,
              vertical: compact ? 2 : 3,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE5E8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.redAccent),
            ),
            child: Text(
              '● DEMO',
              style: TextStyle(
                color: Colors.red,
                fontSize: compact ? 8 : 9,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _offerBanner({required bool compact, required double height}) {
    return _smallBanner(
      compact: compact,
      height: height,
      asset: 'assets/member_card/05_blinkit_grocery_bag.webp',
      assetWidth: compact ? 31 : 40,
      title: 'Healthy Snacks & Gym Essentials',
      subtitle: 'Member partner offer • Up to 30% OFF',
      colors: const [Color(0xFFFFF3C7), Color(0xFFF4D9FF)],
    );
  }

  Widget _recoveryBanner({required bool compact, required double height}) {
    return _smallBanner(
      compact: compact,
      height: height,
      asset: 'assets/member_card/03_whey_protein_tub.webp',
      assetWidth: compact ? 25 : 31,
      title: 'Recovery Combo',
      subtitle: 'Up to 30% OFF',
      colors: const [Color(0xFFF9E9FF), Color(0xFFE5C4FF)],
    );
  }

  Widget _smallBanner({
    required bool compact,
    required double height,
    required String asset,
    required double assetWidth,
    required String title,
    required String subtitle,
    required List<Color> colors,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD8B3F3)),
        boxShadow: const [BoxShadow(color: Color(0x448B40C4), blurRadius: 4)],
      ),
      child: Row(
        children: [
          Image.asset(
            asset,
            width: assetWidth,
            height: height - 3,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MemberTheme.ink,
                    fontSize: compact ? 9 : 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF6E258F),
                    fontSize: compact ? 7.5 : 8.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: MemberTheme.ink,
            size: compact ? 16 : 20,
          ),
        ],
      ),
    );
  }

  Widget _calendarTitle({required bool compact, required double height, required MemberPlanPalette palette}) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Image.asset(
            'assets/member_card/25_calendar_graphic.webp',
            width: compact ? 18 : 21,
            height: compact ? 18 : 21,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              'October attendance',
              maxLines: 1,
              style: TextStyle(
                color: MemberTheme.ink,
                fontSize: compact ? 14.3 : 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 5 : 7,
              vertical: compact ? 2 : 3,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [palette.accent, palette.railGradient.last],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/member_card/27_dumbbell_promo_graphic.webp',
                  width: compact ? 18 : 22,
                  height: compact ? 18 : 22,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 2),
                Text(
                  'Train More • 15% OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: compact ? 7 : 8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.compact,
  });

  final String icon;
  final String value;
  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: TextStyle(fontSize: compact ? 9 : 11)),
            const SizedBox(width: 3),
            Text(
              value,
              style: TextStyle(
                color: MemberTheme.purple,
                fontSize: compact ? 9 : 11,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: TextStyle(
            color: MemberTheme.muted,
            fontSize: compact ? 5.5 : 6.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _AttendanceRingPainter extends CustomPainter {
  const _AttendanceRingPainter();

  static const _segments = <(double, Color)>[
    (23, Color(0xFF13CA69)),
    (2, Color(0xFFE52B52)),
    (4, Color(0xFF8A35D5)),
    (2, Color(0xFFFFB21C)),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width < 64 ? 8.0 : 9.5;
    final rect = Offset(stroke / 2, stroke / 2) &
        Size(size.width - stroke, size.height - stroke);
    final track = Paint()
      ..color = const Color(0xFFE3D7EC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas.drawArc(rect, 0, math.pi * 2, false, track);

    var start = -math.pi / 2;
    const gap = 0.035;
    for (final segment in _segments) {
      final sweep = math.pi * 2 * segment.$1 / 31;
      final paint = Paint()
        ..color = segment.$2
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        rect,
        start + gap / 2,
        math.max(0.0, sweep - gap),
        false,
        paint,
      );
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _AttendanceRingPainter oldDelegate) => false;
}
