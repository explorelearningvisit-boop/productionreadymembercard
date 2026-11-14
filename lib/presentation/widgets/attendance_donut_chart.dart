import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class DonutChartPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0
  final Color strokeColor;
  final Color trackColor;
  final double strokeWidth;

  const DonutChartPainter({
    required this.progress,
    required this.strokeColor,
    required this.trackColor,
    this.strokeWidth = 6.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    // Background track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    // Progress arc with gradient shader
    final rect = Rect.fromCircle(center: center, radius: radius);
    const gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: 3 * math.pi / 2,
      colors: [
        Color(0xFFFF1744),
        Color(0xFFD50000),
        Color(0xFFFF5252),
        Color(0xFFFF1744),
      ],
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant DonutChartPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class AttendanceMetricsRow extends StatelessWidget {
  final MemberIntelligenceData data;

  const AttendanceMetricsRow({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Donut Ring Gauge (81% | 25 / 31 Days)
        SizedBox(
          width: 68,
          height: 68,
          child: CustomPaint(
            painter: const DonutChartPainter(
              progress: 0.81,
              strokeColor: Color(0xFFD6001C),
              trackColor: Color(0xFFFFE8EE),
              strokeWidth: 5.5,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${data.attendanceRate}%',
                  style: const TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: Color(0xFF1E293B),
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  '25 / 31',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontBody,
                    fontWeight: FontWeight.w600,
                    fontSize: 8.5,
                    color: Color(0xFF6B7280),
                    height: 1.0,
                  ),
                ),
                const Text(
                  'Days',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontBody,
                    fontWeight: FontWeight.w500,
                    fontSize: 8,
                    color: Color(0xFF6B7280),
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 8),

        // 2. Attendance Breakdown (Present, Late, Absent, Holiday)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLegendRow(
                color: const Color(0xFF22C55E),
                label: 'Present',
                count: data.presentCount,
              ),
              const SizedBox(height: 2.5),
              _buildLegendRow(
                color: const Color(0xFFEAB308),
                label: 'Late',
                count: data.lateCount,
              ),
              const SizedBox(height: 2.5),
              _buildLegendRow(
                color: const Color(0xFFEF4444),
                label: 'Absent',
                count: data.absentCount,
              ),
              const SizedBox(height: 2.5),
              _buildLegendRow(
                color: const Color(0xFFA855F7),
                label: 'Holiday',
                count: data.holidayCount,
              ),
            ],
          ),
        ),

        const SizedBox(width: 4),

        // 3. Streak & Best Highlights (3D Flame & Trophy)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Streak
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/badges/streak_flame.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.local_fire_department_rounded,
                    color: Color(0xFFFF6D00),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Streak',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontBody,
                        fontSize: 8.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6B7280),
                        height: 1.0,
                      ),
                    ),
                    Text(
                      data.currentStreak,
                      style: const TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E293B),
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Best
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/badges/best_trophy.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.emoji_events_rounded,
                    color: Color(0xFFFFB300),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Best',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontBody,
                        fontSize: 8.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6B7280),
                        height: 1.0,
                      ),
                    ),
                    Text(
                      data.bestStreak,
                      style: const TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E293B),
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendRow({
    required Color color,
    required String label,
    required int count,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7.5,
            height: 7.5,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: BadGymTypography.fontBody,
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4B5563),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$count',
            style: const TextStyle(
              fontFamily: BadGymTypography.fontHeading,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}
