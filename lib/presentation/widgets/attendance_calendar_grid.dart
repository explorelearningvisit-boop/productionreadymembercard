import 'package:flutter/material.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class AttendanceCalendarGrid extends StatelessWidget {
  final List<CalendarDayItem> days;
  final int year;
  final int month;
  final bool showHeader;
  final VoidCallback? onPreviousMonth;
  final VoidCallback? onNextMonth;

  const AttendanceCalendarGrid({
    super.key,
    required this.days,
    this.year = 2026,
    this.month = 10,
    this.showHeader = true,
    this.onPreviousMonth,
    this.onNextMonth,
  }) : assert(month >= 1 && month <= 12);

  static const _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const _dayHeaderStyle = TextStyle(
    fontFamily: BadGymTypography.fontBody,
    fontSize: 9.5,
    fontWeight: FontWeight.w700,
    color: Color(0xFF334155),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showHeader) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1E5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  IconButton(
                    key: const ValueKey('attendance_previous_month'),
                    visualDensity: VisualDensity.compact,
                    constraints:
                        const BoxConstraints.tightFor(width: 28, height: 28),
                    padding: EdgeInsets.zero,
                    onPressed: onPreviousMonth,
                    icon: const Icon(Icons.chevron_left_rounded,
                        size: 20, color: Color(0xFF8F1F2D)),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '${_monthNames[month - 1]} $year',
                        key: const ValueKey('attendance_month_label'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    key: const ValueKey('attendance_next_month'),
                    visualDensity: VisualDensity.compact,
                    constraints:
                        const BoxConstraints.tightFor(width: 28, height: 28),
                    padding: EdgeInsets.zero,
                    onPressed: onNextMonth,
                    icon: const Icon(Icons.chevron_right_rounded,
                        size: 20, color: Color(0xFF1E293B)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
          ],
          const Row(
            children: [
              Expanded(
                  child: Center(child: Text('Mon', style: _dayHeaderStyle))),
              Expanded(
                  child: Center(child: Text('Tue', style: _dayHeaderStyle))),
              Expanded(
                  child: Center(child: Text('Wed', style: _dayHeaderStyle))),
              Expanded(
                  child: Center(child: Text('Thu', style: _dayHeaderStyle))),
              Expanded(
                  child: Center(child: Text('Fri', style: _dayHeaderStyle))),
              Expanded(
                  child: Center(child: Text('Sat', style: _dayHeaderStyle))),
              Expanded(
                  child: Center(child: Text('Sun', style: _dayHeaderStyle))),
            ],
          ),
          const SizedBox(height: 5),
          _buildCalendarRows(),
          const SizedBox(height: 8),
          const FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendItem(label: 'Present', color: Color(0xFF22C55E)),
                SizedBox(width: 6),
                _LegendItem(label: 'Late', color: Color(0xFFEAB308)),
                SizedBox(width: 6),
                _LegendItem(label: 'Absent', color: Color(0xFFEF4444)),
                SizedBox(width: 6),
                _LegendItem(label: 'Holiday', color: Color(0xFFA855F7)),
                SizedBox(width: 6),
                _LegendItem(label: 'Off', color: Color(0xFFD1D5DB)),
                SizedBox(width: 6),
                _LegendItem(
                    label: 'Today', color: Color(0xFF22C55E), isRing: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarRows() {
    final firstWeekday = DateTime(year, month, 1).weekday;
    final dayCount = DateTime(year, month + 1, 0).day;
    final byDay = {for (final item in days) item.day: item};
    final slots = <Widget>[
      for (var i = 1; i < firstWeekday; i++) const SizedBox.shrink(),
      for (var day = 1; day <= dayCount; day++)
        _buildDayCell(DateTime(year, month, day), byDay[day]),
    ];

    while (slots.length % 7 != 0) {
      slots.add(const SizedBox.shrink());
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var row = 0; row < slots.length ~/ 7; row++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.2),
            child: Row(
              children: [
                for (var column = 0; column < 7; column++)
                  Expanded(child: Center(child: slots[row * 7 + column])),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDayCell(DateTime date, CalendarDayItem? item) {
    final isSunday = date.weekday == DateTime.sunday;
    final status = item?.status ?? DayAttendanceStatus.empty;
    final isOff = isSunday;
    final isHoliday = !isSunday && status == DayAttendanceStatus.holiday;

    final label = isOff
        ? 'OFF'
        : isHoliday
            ? 'HOL'
            : '';

    final bgColor = isOff || status == DayAttendanceStatus.empty
        ? const Color(0xFFE2E8F0)
        : switch (status) {
            DayAttendanceStatus.present => const Color(0xFF22C55E),
            DayAttendanceStatus.late => const Color(0xFFEAB308),
            DayAttendanceStatus.absent => const Color(0xFFEF4444),
            DayAttendanceStatus.holiday => const Color(0xFFA855F7),
            DayAttendanceStatus.empty => const Color(0xFFE2E8F0),
          };

    final textColor = isOff || status == DayAttendanceStatus.empty
        ? const Color(0xFF64748B)
        : Colors.white;

    final isToday = item?.isToday == true || date.day == 16;

    Widget pill = Container(
      width: 29,
      height: 20,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${date.day}',
            style: TextStyle(
              fontFamily: BadGymTypography.fontHeading,
              fontSize: label.isNotEmpty ? 8.5 : 9.5,
              fontWeight: FontWeight.w900,
              color: textColor,
              height: 1.0,
            ),
          ),
          if (label.isNotEmpty)
            Text(
              label,
              style: TextStyle(
                fontFamily: BadGymTypography.fontBody,
                fontSize: 5.8,
                fontWeight: FontWeight.w800,
                color: textColor,
                height: 1.0,
              ),
            ),
        ],
      ),
    );

    if (isToday) {
      return Container(
        key: ValueKey('attendance_day_${date.day}'),
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF16A34A),
            width: 1.4,
          ),
        ),
        child: pill,
      );
    }

    return Semantics(
      label:
          '${date.day} ${isOff ? 'Sunday off' : isHoliday ? 'Holiday' : status.name}',
      child: KeyedSubtree(
        key: ValueKey('attendance_day_${date.day}'),
        child: pill,
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  final bool isRing;

  const _LegendItem({
    required this.label,
    required this.color,
    this.isRing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isRing ? Colors.transparent : color,
            shape: BoxShape.circle,
            border: isRing ? Border.all(color: color, width: 1.5) : null,
          ),
        ),
        const SizedBox(width: 3.5),
        Text(
          label,
          style: const TextStyle(
            fontFamily: BadGymTypography.fontBody,
            fontSize: 8.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
          ),
        ),
      ],
    );
  }
}
