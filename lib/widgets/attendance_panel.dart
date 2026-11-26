import 'package:flutter/material.dart';

import '../theme/member_theme.dart';
import 'dashboard_primitives.dart';

class AttendancePanel extends StatelessWidget {
  const AttendancePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const fullHeight = 340.0;
        const compactHeight = 280.0;
        final availableHeight = constraints.maxHeight;
        if (availableHeight < compactHeight) {
          return FittedBox(
            key: const ValueKey('attendance-panel'),
            fit: BoxFit.scaleDown,
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: constraints.maxWidth,
              height: compactHeight,
              child: _panel(compact: true),
            ),
          );
        }
        final compact = availableHeight < fullHeight;
        return SizedBox(
          key: const ValueKey('attendance-panel'),
          width: constraints.maxWidth,
          height: availableHeight,
          child: _panel(compact: compact),
        );
      },
    );
  }

  Widget _panel({bool compact = false}) {
    final headerHeight = compact ? 20.0 : 24.0;
    final offerHeight = compact ? 23.0 : 30.0;
    final chartHeight = compact ? 58.0 : 68.0;
    final ringSize = compact ? 56.0 : 62.0;
    final ringWidth = compact ? 8.0 : 9.0;
    final recoveryHeight = compact ? 23.0 : 30.0;
    final calendarTitleHeight = compact ? 20.0 : 24.0;
    final cellHeight = compact ? 26.0 : 30.0;
    final summaryHeight = compact ? 14.0 : 16.0;

    return Container(
      padding: EdgeInsets.fromLTRB(7, compact ? 4 : 5, 7, compact ? 4 : 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFDFF), Color(0xFFEAD9FF), Color(0xFFF5E9FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: const Color(0xFFEBCFFF), width: 1.6),
        boxShadow: const [
          BoxShadow(color: Color(0x669B4CFF), blurRadius: 9),
          BoxShadow(color: Color(0x44FFFFFF), blurRadius: 2),
        ],
      ),
      child: Column(
        // Spread the analytics blocks through the available panel height.
        // This avoids the large dead zone below the calendar in tall layouts.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _header(compact: compact, height: headerHeight),
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
                        child: CircularProgressIndicator(
                          value: 0.81,
                          strokeWidth: ringWidth,
                          backgroundColor: const Color(0xFFE3D5F2),
                          valueColor: const AlwaysStoppedAnimation<Color>(MemberTheme.green),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '81%',
                            style: TextStyle(
                              color: MemberTheme.ink,
                              fontSize: compact ? 17 : 20,
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
              Expanded(child: _MiniStat(icon: '🔥', value: '5d', compact: compact)),
              Expanded(child: _MiniStat(icon: '🏆', value: '14d', compact: compact)),
              Expanded(child: _MiniStat(icon: '↗', value: '+6%', compact: compact)),
            ],
          ),
          SizedBox(height: compact ? 1 : 2),
          _recoveryBanner(compact: compact, height: recoveryHeight),
          SizedBox(height: compact ? 1 : 2),
          _calendarTitle(compact: compact, height: calendarTitleHeight),
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

  Widget _header({required bool compact, required double height}) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Container(
            width: compact ? 18 : 21,
            height: compact ? 18 : 21,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8D27DC), Color(0xFF4B0A91)],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.trending_up_rounded,
              color: Colors.white,
              size: compact ? 13 : 15,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              'Attendance Analytics',
              maxLines: 1,
              style: TextStyle(
                color: MemberTheme.ink,
                fontSize: compact ? 13 : 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Icon(
            Icons.notifications_active,
            color: MemberTheme.purple,
            size: compact ? 14 : 17,
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
                fontSize: compact ? 7 : 8,
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
      asset: 'reference_library/recovered_from_history/assets/material_pack/pulsevault/13_blinkit_grocery_bag_cutout.png',
      assetWidth: compact ? 30 : 39,
      title: 'Healthy Snacks & Gym Essentials',
      subtitle: 'Member partner offer • Up to 30% OFF',
      colors: const [Color(0xFFFFF3C7), Color(0xFFF4D9FF)],
    );
  }

  Widget _recoveryBanner({required bool compact, required double height}) {
    return _smallBanner(
      compact: compact,
      height: height,
      asset: 'reference_library/recovered_from_history/assets/material_pack/pulsevault/06_whey_recovery_tub_cutout.png',
      assetWidth: compact ? 23 : 29,
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
                    fontSize: compact ? 7.5 : 9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF6E258F),
                    fontSize: compact ? 6 : 7,
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

  Widget _calendarTitle({required bool compact, required double height}) {
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
                fontSize: compact ? 13.5 : 15.5,
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
                colors: [Color(0xFF7D16B9), Color(0xFF3B0878)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '🏋 Train More • 15% OFF',
              style: TextStyle(
                color: Colors.white,
                fontSize: compact ? 5.5 : 7,
                fontWeight: FontWeight.w900,
              ),
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
    required this.compact,
  });

  final String icon;
  final String value;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(icon, style: TextStyle(fontSize: compact ? 9 : 10)),
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
    );
  }
}
