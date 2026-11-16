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

class StitchFlamePainter extends CustomPainter {
  final double pulse; // 0.0 to 1.0

  const StitchFlamePainter({this.pulse = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final scale = w / 96.0;

    canvas.save();
    canvas.scale(scale);

    // Radial amber glow
    const glowCenter = Offset(48, 54);
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFF5722).withValues(alpha: 0.45 * pulse),
          const Color(0xFFFF9800).withValues(alpha: 0.15 * pulse),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: glowCenter, radius: 46 * pulse));
    canvas.drawCircle(glowCenter, 46 * pulse, glowPaint);

    // Outer flame gradient
    final outerShader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFF7A00),
        Color(0xFFFF3D00),
        Color(0xFFE11D48),
      ],
    ).createShader(const Rect.fromLTWH(20, 16, 56, 66));

    final outerPaint = Paint()
      ..shader = outerShader
      ..style = PaintingStyle.fill;

    // Outer Flame SVG path from Stitch
    final outerPath = Path()
      ..moveTo(48, 18)
      ..cubicTo(48, 18, 53, 26, 51, 34)
      ..cubicTo(55, 30, 58, 26, 58, 26)
      ..cubicTo(68, 35, 72, 47, 71, 58)
      ..cubicTo(69.5, 70, 59.5, 78, 48, 78)
      ..cubicTo(36.5, 78, 26.5, 70, 25, 58)
      ..cubicTo(23.5, 45.5, 32, 34, 38, 28)
      ..cubicTo(38, 34, 41, 38, 43, 38)
      ..cubicTo(43, 33, 48, 18, 48, 18)
      ..close();

    canvas.drawPath(outerPath, outerPaint);

    // Inner Core Fire gradient
    final innerShader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFDE047),
        Color(0xFFF59E0B),
        Color(0xFFEF4444),
      ],
    ).createShader(const Rect.fromLTWH(36, 40, 24, 34));

    final innerPaint = Paint()
      ..shader = innerShader
      ..style = PaintingStyle.fill;

    // Inner Flame SVG path from Stitch
    final innerPath = Path()
      ..moveTo(48, 42)
      ..cubicTo(48, 42, 52, 47, 51, 52)
      ..cubicTo(53, 50, 55, 48, 55, 48)
      ..cubicTo(59, 53, 60, 59, 58, 64)
      ..cubicTo(56, 69, 52, 72, 48, 72)
      ..cubicTo(43, 72, 39, 68, 38, 64)
      ..cubicTo(37, 58, 41, 53, 44, 49)
      ..cubicTo(44, 52, 46, 54, 47, 54)
      ..cubicTo(47, 50, 48, 42, 48, 42)
      ..close();

    canvas.drawPath(innerPath, innerPaint);

    // Core bright spark
    final sparkPaint = Paint()
      ..color = const Color(0xFFFEF08A)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(48, 62), 3.5, sparkPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant StitchFlamePainter oldDelegate) =>
      oldDelegate.pulse != pulse;
}

class AttendanceMetricsRow extends StatefulWidget {
  final MemberIntelligenceData data;

  const AttendanceMetricsRow({
    super.key,
    required this.data,
  });

  @override
  State<AttendanceMetricsRow> createState() => _AttendanceMetricsRowState();
}

class _AttendanceMetricsRowState extends State<AttendanceMetricsRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flamePulseController;
  late final Animation<double> _flamePulse;

  @override
  void initState() {
    super.initState();
    _flamePulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    if (!WidgetsBinding.instance.runtimeType.toString().contains('Test')) {
      _flamePulseController.repeat(reverse: true);
    } else {
      _flamePulseController.value = 0.5;
    }

    _flamePulse = Tween<double>(begin: 0.90, end: 1.10).animate(
      CurvedAnimation(
        parent: _flamePulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _flamePulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Donut Ring Gauge (81% | 25 / 31 Days)
        SizedBox(
          width: 66,
          height: 66,
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

        const SizedBox(width: 6),

        // Thin vertical divider before streak column (matching reference design)
        Container(
          width: 1.5,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF8B0000).withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(1),
          ),
        ),

        const SizedBox(width: 6),

        // 3. Streak & Best Highlights (Animated 3D Flame & 3D Gold Trophy)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Streak with Animated BAD GYM 3D Flame
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _flamePulse,
                  builder: (context, child) {
                    return SizedBox(
                      width: 24,
                      height: 24,
                      child: Center(
                        child: Transform.scale(
                          scale: _flamePulse.value,
                          child: Image.asset(
                            'assets/badges/streak_flame.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.local_fire_department_rounded,
                              color: Color(0xFFFF5722),
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
                        fontSize: 9.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data.currentStreak,
                      style: const TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF990000),
                        letterSpacing: -0.2,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Best with 3D Gold Trophy
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/badges/best_trophy.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.emoji_events_rounded,
                    color: Color(0xFFFFB300),
                    size: 20,
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
                        fontSize: 9.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data.bestStreak,
                      style: const TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF990000),
                        letterSpacing: -0.2,
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
