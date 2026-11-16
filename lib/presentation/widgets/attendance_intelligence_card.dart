import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';
import 'package:bad_gym/presentation/widgets/attendance_calendar_grid.dart';
import 'package:bad_gym/presentation/widgets/attendance_donut_chart.dart';

class AttendanceIntelligenceCard extends StatelessWidget {
  final MemberIntelligenceData data;
  final VoidCallback? onMonthDropdownPressed;
  final VoidCallback? onInfoPressed;
  final VoidCallback? onScrollDownPressed;

  const AttendanceIntelligenceCard({
    super.key,
    required this.data,
    this.onMonthDropdownPressed,
    this.onInfoPressed,
    this.onScrollDownPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFDCC8F6),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Header: Red Icon Chip | Title | Info | Month Dropdown
          Row(
            children: [
              // Red rounded squircle icon badge
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF7621D6),
                      Color(0xFF4D138F),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7621D6).withValues(alpha: 0.35),
                      blurRadius: 4,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.bar_chart_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 6),

              // Title with Info Icon
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Attendance Intelligence',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontHeading,
                            fontWeight: FontWeight.w800,
                            fontSize: 12.5,
                            color: Color(0xFF1E293B),
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: onInfoPressed,
                      child: const Icon(
                        Icons.info_outline_rounded,
                        size: 13,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 4),

              // Month selector pill: Oct 2026 ▼
              InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onMonthDropdownPressed?.call();
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.attendanceMonthLabel,
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 14,
                        color: Color(0xFF1E293B),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 2. Metrics Row: Donut Chart | Legend | Streaks
          AttendanceMetricsRow(data: data),

          const SizedBox(height: 10),

          // 3. Calendar Grid & Legend
          AttendanceCalendarGrid(days: data.calendarDays, year: data.attendanceYear, month: data.attendanceMonth),
        ],
      ),
    );
  }
}
