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
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      child: Row(
        children: [
          _cardSlot(
            tab: QuickStatTab.attendance,
            icon: Icons.event_available_rounded,
            label: 'Attendance',
            value: '${data.attendanceRate}%',
            delta: '+6%',
            isPositive: true,
          ),
          const SizedBox(width: 4),
          _cardSlot(
            tab: QuickStatTab.workout,
            icon: Icons.fitness_center_rounded,
            label: 'Workout',
            value: data.workoutTime,
            delta: '+12%',
            isPositive: true,
          ),
          const SizedBox(width: 4),
          _cardSlot(
            tab: QuickStatTab.payment,
            icon: Icons.account_balance_wallet_rounded,
            label: 'Payment',
            value: data.paymentAmount.replaceAll(' Due', '').replaceAll(' Paid', ''),
            delta: data.paymentStatus,
            isPositive: data.paymentStatus.toLowerCase().contains('paid'),
          ),
          const SizedBox(width: 4),
          _cardSlot(
            tab: QuickStatTab.body,
            icon: Icons.monitor_weight_outlined,
            label: 'Body',
            value: data.bodyWeight,
            delta: '-0.8 kg',
            isPositive: true,
          ),
        ],
      ),
    );
  }

  Widget _cardSlot({
    required QuickStatTab tab,
    required IconData icon,
    required String label,
    required String value,
    required String delta,
    required bool isPositive,
  }) {
    return Expanded(
      child: _buildCard(
        tab: tab,
        icon: icon,
        label: label,
        value: value,
        delta: delta,
        isPositive: isPositive,
      ),
    );
  }

  Widget _buildCard({
    required QuickStatTab tab,
    required IconData icon,
    required String label,
    required String value,
    required String delta,
    required bool isPositive,
  }) {
    final bool isSelected = selectedTab == tab;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTabSelected?.call(tab);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? null : Colors.white,
            gradient: isSelected ? const LinearGradient(colors: [Color(0xFFFFF1F2), Color(0xFFFFFFFF)]) : null,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? const Color(0xFFB91C2C) : const Color(0xFFEAD9C3),
              width: isSelected ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? const Color(0xFFDC2626).withValues(alpha: 0.18)
                    : Colors.black.withValues(alpha: 0.04),
                blurRadius: isSelected ? 7 : 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Red icon in soft rounded box
              Container(
                width: 23,
                height: 23,
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
                  color: const Color(0xFFDC2626),
                  size: 14,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                maxLines: 1,
                style: const TextStyle(
                  fontFamily: BadGymTypography.fontBody,
                  fontSize: 8.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B6B6B),
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1A1A1A),
                    height: 1.05,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              // Delta badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                decoration: BoxDecoration(
                  color: isPositive ? const Color(0xFFDCFCE7) : const Color(0xFFFFE4E6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  delta,
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontWeight: FontWeight.w800,
                    fontSize: 7.5,
                    color: isPositive ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                    height: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
