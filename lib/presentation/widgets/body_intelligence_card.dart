import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class BodyIntelligenceCard extends StatelessWidget {
  final MemberIntelligenceData data;
  final VoidCallback? onLogWeightPressed;
  final VoidCallback? onScanPressed;

  const BodyIntelligenceCard({
    super.key,
    required this.data,
    this.onLogWeightPressed,
    this.onScanPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: BadGymColors.borderSubtle,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: BadGymColors.purpleRail.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Header: Icon Badge | Title | Goal Pill
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF06B6D4),
                      Color(0xFF0891B2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.monitor_weight_outlined,
                  color: Colors.white,
                  size: 14,
                ),
              ),
              const SizedBox(width: 5),
              const Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Body Intelligence',
                    style: TextStyle(
                      fontFamily: BadGymTypography.fontHeading,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.5,
                      color: Color(0xFF1E0E38),
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 2.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFBAE6FD),
                    width: 1,
                  ),
                ),
                child: const Text(
                  'Goal: 72.0 kg',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0369A1),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 2. Metric Grid: Weight, Body Fat, Muscle Mass
          Row(
            children: [
              Expanded(
                child: _buildMetricPill(
                  label: 'Current Weight',
                  value: data.bodyWeight,
                  icon: Icons.scale_rounded,
                  color: const Color(0xFF0891B2),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildMetricPill(
                  label: 'Body Fat',
                  value: '14.2%',
                  icon: Icons.pie_chart_rounded,
                  color: BadGymColors.emerald,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildMetricPill(
                  label: 'Muscle Mass',
                  value: '34.8 kg',
                  icon: Icons.fitness_center_rounded,
                  color: const Color(0xFF8B5CF6),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 3. Body Composition & Measurements
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF7FE),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFEDE9FE),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Circumferences',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontWeight: FontWeight.w800,
                        fontSize: 10.5,
                        color: Color(0xFF1E0E38),
                      ),
                    ),
                    Text(
                      'BMI: 22.4 (Healthy)',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontBody,
                        fontWeight: FontWeight.w600,
                        fontSize: 8.5,
                        color: BadGymColors.emerald,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                _buildMeasurementRow(
                  part: 'Chest Circumference',
                  value: '39.5 inches',
                  change: '+0.5 in',
                  isGain: true,
                ),
                const SizedBox(height: 4),
                _buildMeasurementRow(
                  part: 'Arms (Flexed Bicep)',
                  value: '14.2 inches',
                  change: '+0.3 in',
                  isGain: true,
                ),
                const SizedBox(height: 4),
                _buildMeasurementRow(
                  part: 'Waist Circumference',
                  value: '31.0 inches',
                  change: '-0.2 in',
                  isGain: false,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 4. Action Row: Log Weight / InBody Scan
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    if (onLogWeightPressed != null) {
                      onLogWeightPressed!();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Weight logged: 69.5 kg (+0.2 kg since Tuesday)'),
                          backgroundColor: Color(0xFF0891B2),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.5),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF06B6D4),
                          Color(0xFF0284C7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF06B6D4).withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_rounded, size: 12, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'Log Weight',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontHeading,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              InkWell(
                onTap: () {
                  HapticFeedback.selectionClick();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('InBody 570 3D body scan synced successfully'),
                      backgroundColor: BadGymColors.purpleCardStart,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF7FE),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFEDE9FE),
                      width: 1,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.qr_code_scanner_rounded, size: 12, color: Color(0xFF0891B2)),
                      SizedBox(width: 3),
                      Text(
                        'InBody',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w700,
                          fontSize: 9.5,
                          color: Color(0xFF0891B2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricPill({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7FE),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFEDE9FE),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 11, color: color),
              const SizedBox(width: 2.5),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: BadGymTypography.fontBody,
                    fontWeight: FontWeight.w500,
                    fontSize: 8,
                    color: Color(0xFF6B7280),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontFamily: BadGymTypography.fontHeading,
              fontWeight: FontWeight.w800,
              fontSize: 10.5,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementRow({
    required String part,
    required String value,
    required String change,
    required bool isGain,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          part,
          style: const TextStyle(
            fontFamily: BadGymTypography.fontHeading,
            fontWeight: FontWeight.w600,
            fontSize: 9,
            color: Color(0xFF1E0E38),
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontFamily: BadGymTypography.fontHeading,
                fontWeight: FontWeight.w700,
                fontSize: 9.5,
                color: Color(0xFF1E0E38),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: (isGain ? BadGymColors.emerald : const Color(0xFF0284C7)).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                change,
                style: TextStyle(
                  fontFamily: BadGymTypography.fontBody,
                  fontSize: 7.5,
                  fontWeight: FontWeight.w700,
                  color: isGain ? BadGymColors.emerald : const Color(0xFF0284C7),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
