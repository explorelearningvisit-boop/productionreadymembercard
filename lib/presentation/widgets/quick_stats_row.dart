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
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Row(
        children: [
          // 1. Attendance (Rich Crimson Red Card with Yellow text if active, or matching image)
          Expanded(
            child: _buildAttendanceCard(),
          ),
          const SizedBox(width: 6),

          // 2. Workout (White card, red dumbbell icon)
          Expanded(
            child: _buildStandardCard(
              tab: QuickStatTab.workout,
              icon: Icons.fitness_center_rounded,
              title: 'Workout',
              value: data.workoutTime,
              valueColor: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(width: 6),

          // 3. Payment (White card, red wallet icon)
          Expanded(
            child: _buildStandardCard(
              tab: QuickStatTab.payment,
              icon: Icons.account_balance_wallet_rounded,
              title: 'Payment',
              value: data.paymentStatus,
              valueColor: const Color(0xFFD6001C),
            ),
          ),
          const SizedBox(width: 6),

          // 4. Body (White card, red scale icon)
          Expanded(
            child: _buildStandardCard(
              tab: QuickStatTab.body,
              icon: Icons.monitor_weight_outlined,
              title: 'Body',
              value: data.bodyWeight,
              valueColor: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard() {
    final bool isSelected = selectedTab == QuickStatTab.attendance;

    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTabSelected?.call(QuickStatTab.attendance);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE50914),
                    Color(0xFFBA0018),
                    Color(0xFF8B0012),
                  ],
                )
              : const LinearGradient(
                  colors: [Colors.white, Color(0xFFFFF0F2)],
                ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFF5268)
                : const Color(0xFFFFCCD3),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0xFFBA0018).withValues(alpha: 0.35)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: isSelected ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gold Checkmark Calendar Icon in Red rounded box
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6B000B) : const Color(0xFFFFECEF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFFFDF7A).withValues(alpha: 0.4)
                      : const Color(0xFFFFCCD3),
                  width: 0.8,
                ),
              ),
              child: Icon(
                Icons.event_available_rounded,
                color: isSelected ? const Color(0xFFFFE600) : const Color(0xFFD6001C),
                size: 16,
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Attendance',
                    style: TextStyle(
                      fontFamily: BadGymTypography.fontBody,
                      fontSize: 8.5,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white.withValues(alpha: 0.9) : const Color(0xFF64748B),
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${data.attendanceRate}%',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: isSelected ? const Color(0xFFFFE600) : const Color(0xFFD6001C),
                        height: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardCard({
    required QuickStatTab tab,
    required IconData icon,
    required String title,
    required String value,
    required Color valueColor,
  }) {
    final bool isSelected = selectedTab == tab;

    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTabSelected?.call(tab);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF7F8) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFD6001C).withValues(alpha: 0.8)
                : const Color(0xFFF1F5F9),
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0xFFD6001C).withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: isSelected ? 6 : 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Red icon container
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFFFECEF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFFFCCD3),
                  width: 0.8,
                ),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFD6001C),
                size: 16,
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: BadGymTypography.fontBody,
                      fontSize: 8.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: valueColor,
                        height: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
