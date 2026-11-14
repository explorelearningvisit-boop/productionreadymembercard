import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

enum QuickStatTab {
  attendance,
  workout,
  payment,
  body,
}

class QuickStatsRow extends StatelessWidget {
  final MemberIntelligenceData data;
  final QuickStatTab selectedTab;
  final ValueChanged<QuickStatTab>? onTabSelected;

  const QuickStatsRow({
    super.key,
    required this.data,
    this.selectedTab = QuickStatTab.attendance,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        children: [
          // 1. Attendance: 81% (Pastel Pink)
          Expanded(
            child: _buildStatCard(
              tab: QuickStatTab.attendance,
              icon: Icons.event_available_rounded,
              iconColor: const Color(0xFFD6001C),
              title: 'Attendance',
              value: '${data.attendanceRate}%',
              valueColor: const Color(0xFFD6001C),
              gradientColors: const [Color(0xFFFFF0F2), Color(0xFFFFE4E8)],
              borderColor: const Color(0xFFFFCCD3),
            ),
          ),
          const SizedBox(width: 6),

          // 2. Workout: 58 min (Pastel Lavender)
          Expanded(
            child: _buildStatCard(
              tab: QuickStatTab.workout,
              icon: Icons.fitness_center_rounded,
              iconColor: const Color(0xFF8A2BE2),
              title: 'Workout',
              value: data.workoutTime,
              valueColor: const Color(0xFF1E293B),
              gradientColors: const [Color(0xFFF7F0FF), Color(0xFFEDE2FE)],
              borderColor: const Color(0xFFE2D0FC),
            ),
          ),
          const SizedBox(width: 6),

          // 3. Payment: Due (Pastel Amber)
          Expanded(
            child: _buildStatCard(
              tab: QuickStatTab.payment,
              icon: Icons.account_balance_wallet_rounded,
              iconColor: const Color(0xFFEA580C),
              title: 'Payment',
              value: data.paymentStatus,
              valueColor: const Color(0xFFD6001C),
              gradientColors: const [Color(0xFFFFF7ED), Color(0xFFFFEDD5)],
              borderColor: const Color(0xFFFED7AA),
            ),
          ),
          const SizedBox(width: 6),

          // 4. Body: 69.5 kg (Pastel Ice Blue)
          Expanded(
            child: _buildStatCard(
              tab: QuickStatTab.body,
              icon: Icons.person_rounded,
              iconColor: const Color(0xFF0284C7),
              title: 'Body',
              value: data.bodyWeight,
              valueColor: const Color(0xFF1E293B),
              gradientColors: const [Color(0xFFF0F9FF), Color(0xFFE0F2FE)],
              borderColor: const Color(0xFFBAE6FD),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required QuickStatTab tab,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required Color valueColor,
    required List<Color> gradientColors,
    required Color borderColor,
  }) {
    final isSelected = tab == selectedTab;

    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTabSelected?.call(tab);
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isSelected
                ? [Colors.white, gradientColors[0]]
                : gradientColors,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFD6001C).withValues(alpha: 0.8)
                : borderColor,
            width: isSelected ? 1.6 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0xFFD6001C).withValues(alpha: 0.22)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: isSelected ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
            const SizedBox(height: 3),

            // Title
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: BadGymTypography.fontBody,
                  fontWeight: FontWeight.w600,
                  fontSize: 9.5,
                  color: Color(0xFF475569),
                  letterSpacing: -0.2,
                ),
              ),
            ),
            const SizedBox(height: 2),

            // Value
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: BadGymTypography.fontHeading,
                  fontWeight: FontWeight.w900,
                  fontSize: 12.5,
                  color: valueColor,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
