import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class WorkoutIntelligenceCard extends StatelessWidget {
  final MemberIntelligenceData data;
  final VoidCallback? onLogSetPressed;
  final VoidCallback? onRoutineDetailsPressed;

  const WorkoutIntelligenceCard({
    super.key,
    required this.data,
    this.onLogSetPressed,
    this.onRoutineDetailsPressed,
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
          // 1. Header: Icon Badge | Title | Routine Pill
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF8B5CF6),
                      Color(0xFF6D28D9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.fitness_center_rounded,
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
                    'Workout Intelligence',
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
                  color: const Color(0xFFFAF7FE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE5DEEE),
                    width: 1,
                  ),
                ),
                child: const Text(
                  'Chest & Arms',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6D28D9),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 2. Metric Grid: Duration, Burn, Sets, Volume
          Row(
            children: [
              Expanded(
                child: _buildMetricPill(
                  label: 'Duration',
                  value: data.workoutTime,
                  icon: Icons.timer_outlined,
                  color: const Color(0xFF8B5CF6),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildMetricPill(
                  label: 'Burn',
                  value: '420 kcal',
                  icon: Icons.local_fire_department_rounded,
                  color: const Color(0xFFEA580C),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildMetricPill(
                  label: 'Sets Done',
                  value: '16 / 18',
                  icon: Icons.check_circle_outline_rounded,
                  color: BadGymColors.emerald,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 3. Today's Exercise Routine Breakdown
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
                      'Today\'s Program',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontWeight: FontWeight.w800,
                        fontSize: 10.5,
                        color: Color(0xFF1E0E38),
                      ),
                    ),
                    Text(
                      'Intensity: High 🔥',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontBody,
                        fontWeight: FontWeight.w600,
                        fontSize: 8.5,
                        color: Color(0xFFEA580C),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                _buildExerciseRow(
                  name: 'Incline Dumbbell Press',
                  detail: '4 sets × 10 reps (24 kg)',
                  isCompleted: true,
                ),
                const SizedBox(height: 4),
                _buildExerciseRow(
                  name: 'Flat Barbell Bench',
                  detail: '4 sets × 8 reps (70 kg)',
                  isCompleted: true,
                ),
                const SizedBox(height: 4),
                _buildExerciseRow(
                  name: 'Cable Flyes (Pec Deck)',
                  detail: '4 sets × 12 reps (15 kg)',
                  isCompleted: true,
                ),
                const SizedBox(height: 4),
                _buildExerciseRow(
                  name: 'Triceps Overhead Rope',
                  detail: '4 sets × 12 reps (22.5 kg)',
                  isCompleted: false,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 4. Action Row: Log Set / Rest Timer
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    if (onLogSetPressed != null) {
                      onLogSetPressed!();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logged Set 4 for Triceps Rope Pushdown (22.5 kg)'),
                          backgroundColor: Color(0xFF6D28D9),
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
                          BadGymColors.purpleCardStart,
                          BadGymColors.neonViolet,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: BadGymColors.neonViolet.withValues(alpha: 0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_task_rounded, size: 12, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'Log Next Set',
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
                      content: Text('Rest timer set: 90 seconds remaining'),
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
                      Icon(Icons.timer_outlined, size: 12, color: Color(0xFF6D28D9)),
                      SizedBox(width: 3),
                      Text(
                        '01:30',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w700,
                          fontSize: 9.5,
                          color: Color(0xFF6D28D9),
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

  Widget _buildExerciseRow({
    required String name,
    required String detail,
    required bool isCompleted,
  }) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? BadGymColors.emerald : Colors.transparent,
            border: Border.all(
              color: isCompleted ? BadGymColors.emerald : const Color(0xFF9CA3AF),
              width: 1.2,
            ),
          ),
          alignment: Alignment.center,
          child: isCompleted
              ? const Icon(Icons.check, size: 9, color: Colors.white)
              : null,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: BadGymTypography.fontHeading,
                  fontWeight: FontWeight.w700,
                  fontSize: 9.5,
                  color: isCompleted ? const Color(0xFF1E0E38) : const Color(0xFF6B7280),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                detail,
                style: const TextStyle(
                  fontFamily: BadGymTypography.fontBody,
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
