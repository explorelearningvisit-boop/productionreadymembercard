import 'package:flutter/material.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class AttendanceCalendarGrid extends StatelessWidget {
  final List<CalendarDayItem> days;
  final int year;
  final int month;
  final VoidCallback? onPreviousMonth;
  final VoidCallback? onNextMonth;

  const AttendanceCalendarGrid({
    super.key,
    required this.days,
    this.year = 2026,
    this.month = 10,
    this.onPreviousMonth,
    this.onNextMonth,
  }) : assert(month >= 1 && month <= 12);

  static const _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  static const _dayHeaderStyle = TextStyle(
    fontFamily: BadGymTypography.fontBody,
    fontSize: 9.5,
    fontWeight: FontWeight.w600,
    color: Color(0xFF6B7280),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE7FA),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  key: const ValueKey('attendance_previous_month'),
                  visualDensity: VisualDensity.compact,
                  constraints: const BoxConstraints.tightFor(width: 28, height: 28),
                  padding: EdgeInsets.zero,
                  onPressed: onPreviousMonth,
                  icon: const Icon(Icons.chevron_left_rounded, size: 20, color: Color(0xFF1E293B)),
                ),
                Text(
                  '${_monthNames[month - 1]} $year',
                  key: const ValueKey('attendance_month_label'),
                  style: const TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    color: Color(0xFF1E293B),
                  ),
                ),
                IconButton(
                  key: const ValueKey('attendance_next_month'),
                  visualDensity: VisualDensity.compact,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  padding: EdgeInsets.zero,
                  onPressed: onNextMonth,
                  icon: const Icon(Icons.chevron_right_rounded, size: 20, color: Color(0xFF1E293B)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Row(
            children: [
              Expanded(child: Center(child: Text('Mon', style: _dayHeaderStyle))),
              Expanded(child: Center(child: Text('Tue', style: _dayHeaderStyle))),
              Expanded(child: Center(child: Text('Wed', style: _dayHeaderStyle))),
              Expanded(child: Center(child: Text('Thu', style: _dayHeaderStyle))),
              Expanded(child: Center(child: Text('Fri', style: _dayHeaderStyle))),
              Expanded(child: Center(child: Text('Sat', style: _dayHeaderStyle))),
              Expanded(child: Center(child: Text('Sun', style: _dayHeaderStyle))),
            ],
          ),
          const SizedBox(height: 5),
          _buildCalendarRows(),
          const SizedBox(height: 8),
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 4,
            children: [
              _LegendItem(label: 'Present', color: Color(0xFF079B43)),
              _LegendItem(label: 'Absent', color: Color(0xFFEF4444)),
              _LegendItem(label: 'Late', color: Color(0xFFEAB308)),
              _LegendItem(label: 'Holiday', color: Color(0xFF8B35EA)),
              _LegendItem(label: 'Sunday Off', color: Color(0xFF9CA3AF)),
            ],
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
            padding: const EdgeInsets.symmetric(vertical: 2),
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
    final color = isOff || status == DayAttendanceStatus.empty
        ? const Color(0xFF9CA3AF)
        : switch (status) {
            DayAttendanceStatus.present => const Color(0xFF079B43),
            DayAttendanceStatus.late => const Color(0xFFEAB308),
            DayAttendanceStatus.absent => const Color(0xFFEF4444),
            DayAttendanceStatus.holiday => const Color(0xFF8B35EA),
            DayAttendanceStatus.empty => const Color(0xFF9CA3AF),
          };

    final label = isOff ? 'OFF' : isHoliday ? 'HOL' : '';
    final isToday = item?.isToday == true;

    return Semantics(
      label: '${date.day} ${isOff ? 'Sunday off' : isHoliday ? 'Holiday' : status.name}',
      child: Container(
        key: ValueKey('attendance_day_${date.day}'),
        width: 31,
        height: 29,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(7),
          border: isToday ? Border.all(color: const Color(0xFF079B43), width: 1.4) : null,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${date.day}',
              style: TextStyle(
                fontFamily: BadGymTypography.fontHeading,
                fontSize: 9.5,
                height: 1,
                fontWeight: isToday ? FontWeight.w900 : FontWeight.w700,
                color: color,
              ),
            ),
            if (label.isNotEmpty)
              Text(
                label,
                style: TextStyle(
                  fontFamily: BadGymTypography.fontBody,
                  fontSize: 6.2,
                  height: 1,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;

  const _LegendItem({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 3),
        Text(
          label,
          style: const TextStyle(
            fontFamily: BadGymTypography.fontBody,
            fontSize: 8,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
      ],
    );
  }
}
