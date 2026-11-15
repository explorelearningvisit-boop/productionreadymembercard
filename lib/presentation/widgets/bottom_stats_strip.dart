import 'package:flutter/material.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class BottomStatsStrip extends StatelessWidget {
  const BottomStatsStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEAD9C3),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Streak
          Expanded(
            child: _buildItem(
              icon: Icons.local_fire_department_rounded,
              iconColor: const Color(0xFFEA580C),
              value: '6 Days',
              label: 'Streak',
            ),
          ),
          Container(width: 1, height: 24, color: const Color(0xFFF1E8DF)),

          // 2. Best
          Expanded(
            child: _buildItem(
              icon: Icons.emoji_events_rounded,
              iconColor: const Color(0xFFD4AF37),
              value: '97%',
              label: 'Best',
            ),
          ),
          Container(width: 1, height: 24, color: const Color(0xFFF1E8DF)),

          // 3. Plan Days
          Expanded(
            child: _buildItem(
              icon: Icons.calendar_month_rounded,
              iconColor: const Color(0xFFDC2626),
              value: '22/30',
              label: 'Plan Days',
            ),
          ),
          Container(width: 1, height: 24, color: const Color(0xFFF1E8DF)),

          // 4. Next Goal
          Expanded(
            child: _buildItem(
              icon: Icons.track_changes_rounded,
              iconColor: const Color(0xFFDC2626),
              value: '90%',
              label: 'Next Goal',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: 16),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: BadGymTypography.fontHeading,
              fontWeight: FontWeight.w900,
              fontSize: 13.0,
              color: Color(0xFF1A1A1A),
              height: 1.05,
            ),
          ),
        ),
        const SizedBox(height: 1.5),
        Text(
          label,
          style: const TextStyle(
            fontFamily: BadGymTypography.fontBody,
            fontWeight: FontWeight.w500,
            fontSize: 8.5,
            color: Color(0xFF6B6B6B),
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
