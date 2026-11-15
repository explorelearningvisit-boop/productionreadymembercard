import 'package:flutter/material.dart';

class WeeklyAttendanceStrip extends StatelessWidget {
  const WeeklyAttendanceStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final days = [
      _DayItem(day: 14, status: _Status.present),
      _DayItem(day: 15, status: _Status.present),
      _DayItem(day: 16, status: _Status.today),
      _DayItem(day: 17, status: _Status.absent),
      _DayItem(day: 18, status: _Status.present),
      _DayItem(day: 19, status: _Status.present),
      _DayItem(day: 20, status: _Status.upcoming),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days.map((d) => _buildDayChip(d)).toList(),
      ),
    );
  }

  Widget _buildDayChip(_DayItem item) {
    Color bg;
    Color iconColor = Colors.white;
    IconData? icon;
    bool isToday = item.status == _Status.today;

    switch (item.status) {
      case _Status.present:
        bg = const Color(0xFF00C853);
        icon = Icons.check;
        break;
      case _Status.today:
        bg = const Color(0xFF00C853);
        icon = Icons.check;
        break;
      case _Status.absent:
        bg = const Color(0xFFE50914);
        icon = Icons.close;
        break;
      case _Status.upcoming:
        bg = const Color(0xFFE0E0E0);
        iconColor = Colors.black45;
        icon = Icons.remove;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
            border: isToday
                ? Border.all(color: const Color(0xFF69F0AE), width: 3)
                : null,
            boxShadow: isToday
                ? [
                    BoxShadow(
                      color: const Color(0xFF00C853).withValues(alpha: 0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${item.day}',
                style: TextStyle(
                  color: iconColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
              if (icon != null)
                Icon(icon, size: 11, color: iconColor),
            ],
          ),
        ),
      ],
    );
  }
}

enum _Status { present, today, absent, upcoming }

class _DayItem {
  final int day;
  final _Status status;
  _DayItem({required this.day, required this.status});
}
