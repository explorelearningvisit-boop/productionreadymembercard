import 'package:flutter/material.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/presentation/widgets/attendance_calendar_grid.dart';
import 'package:bad_gym/presentation/widgets/attendance_trend_chart.dart';

class AttendanceTrendContainerCard extends StatelessWidget {
  final MemberIntelligenceData data;

  const AttendanceTrendContainerCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAD9C3), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AttendanceTrendChart(points: data.trendPoints),
          const Divider(height: 18, thickness: 0.7),
          AttendanceCalendarGrid(
            days: data.calendarDays,
            year: data.attendanceYear,
            month: data.attendanceMonth,
          ),
        ],
      ),
    );
  }
}
