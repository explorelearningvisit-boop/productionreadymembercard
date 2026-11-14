import 'package:flutter/material.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class AttendanceCalendarGrid extends StatelessWidget {
  final List<CalendarDayItem> days;
  final VoidCallback? onPreviousMonth;
  final VoidCallback? onNextMonth;

  const AttendanceCalendarGrid({
    super.key,
    required this.days,
    this.onPreviousMonth,
    this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Month navigation header: < October 2026 > in soft rounded container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: onPreviousMonth,
                  borderRadius: BorderRadius.circular(12),
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 20,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
                const Text(
                  'October 2026',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    color: Color(0xFF1E293B),
                  ),
                ),
                InkWell(
                  onTap: onNextMonth,
                  borderRadius: BorderRadius.circular(12),
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // Day of week labels: Mon Tue Wed Thu Fri Sat Sun
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

          // Calendar Grid Rows
          _buildCalendarRows(),

          const SizedBox(height: 8),

          // Calendar Bottom Legend: Present | Late | Absent | Holiday | Today
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Present (Green Capsule Pill)
                _buildLegendCapsule(
                  icon: Icons.check_circle_rounded,
                  iconColor: const Color(0xFF22C55E),
                  label: 'Present',
                ),
                const SizedBox(width: 8),

                // Late (Yellow Capsule Pill)
                _buildLegendCapsule(
                  icon: Icons.access_time_filled_rounded,
                  iconColor: const Color(0xFFEAB308),
                  label: 'Late',
                ),
                const SizedBox(width: 8),

                // Absent (Red Capsule Pill)
                _buildLegendCapsule(
                  icon: Icons.cancel_rounded,
                  iconColor: const Color(0xFFEF4444),
                  label: 'Absent',
                ),
                const SizedBox(width: 8),

                // Holiday (Purple Capsule Pill)
                _buildLegendCapsule(
                  icon: Icons.calendar_month_rounded,
                  iconColor: const Color(0xFFA855F7),
                  label: 'Holiday',
                ),
                const SizedBox(width: 8),

                // Today (Green Halo Ring)
                _buildLegendCapsule(
                  customIcon: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF22C55E),
                        width: 2.0,
                      ),
                    ),
                  ),
                  label: 'Today',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const TextStyle _dayHeaderStyle = TextStyle(
    fontFamily: BadGymTypography.fontBody,
    fontSize: 9.5,
    fontWeight: FontWeight.w600,
    color: Color(0xFF6B7280),
  );

  Widget _buildLegendCapsule({
    IconData? icon,
    Color? iconColor,
    Widget? customIcon,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        customIcon ??
            Icon(
              icon,
              size: 13,
              color: iconColor,
            ),
        const SizedBox(width: 3.5),
        Text(
          label,
          style: const TextStyle(
            fontFamily: BadGymTypography.fontBody,
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarRows() {
    final items = <Widget>[];

    // October 2026 starts on Thursday (index 3). Mon, Tue, Wed are empty slots
    items.add(const SizedBox());
    items.add(const SizedBox());
    items.add(const SizedBox());

    for (final dayItem in days) {
      items.add(_buildDayChip(dayItem));
    }

    // Pad remaining slots to complete last row
    while (items.length % 7 != 0) {
      items.add(const SizedBox());
    }

    final rows = <Widget>[];
    for (int i = 0; i < items.length; i += 7) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: [
              for (int j = 0; j < 7; j++)
                Expanded(
                  child: Center(child: items[i + j]),
                ),
            ],
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }

  Widget _buildDayChip(CalendarDayItem item) {
    if (item.status == DayAttendanceStatus.empty) {
      // Off / inactive day chip (grey)
      return Container(
        width: 26,
        height: 21,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          '${item.day}',
          style: const TextStyle(
            fontFamily: BadGymTypography.fontHeading,
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF4B5563),
          ),
        ),
      );
    }

    final Color chipColor = switch (item.status) {
      DayAttendanceStatus.present => const Color(0xFF22C55E),
      DayAttendanceStatus.late => const Color(0xFFEAB308),
      DayAttendanceStatus.absent => const Color(0xFFEF4444),
      DayAttendanceStatus.holiday => const Color(0xFFA855F7),
      DayAttendanceStatus.empty => const Color(0xFFE5E7EB),
    };

    if (item.isToday) {
      // Today (Oct 16): Green pill with outer concentric halo ring
      return Container(
        width: 29,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF22C55E),
            width: 1.6,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF22C55E).withValues(alpha: 0.45),
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(1.5),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF22C55E),
            borderRadius: BorderRadius.circular(9),
          ),
          alignment: Alignment.center,
          child: Text(
            '${item.day}',
            style: const TextStyle(
              fontFamily: BadGymTypography.fontHeading,
              fontSize: 9.5,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Container(
      width: 26,
      height: 21,
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: chipColor.withValues(alpha: 0.35),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        '${item.day}',
        style: const TextStyle(
          fontFamily: BadGymTypography.fontHeading,
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}
