import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

enum RailTab {
  intelligence,
  calendar,
  history,
  trend,
  more,
  // Backwards compatibility aliases
  home,
  members,
  workout,
  payment,
  progress,
  reports,
  streak,
  analysis,
  goals,
  offers,
  overview,
  attendance,
  body,
}

class VerticalNavigationRail extends StatelessWidget {
  final RailTab selectedTab;
  final ValueChanged<RailTab>? onTabSelected;
  final double? height;

  const VerticalNavigationRail({
    super.key,
    required this.selectedTab,
    this.onTabSelected,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66,
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2A2A2E),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildItem(
            tab: RailTab.intelligence,
            aliases: [
              RailTab.intelligence,
              RailTab.home,
              RailTab.overview,
              RailTab.attendance
            ],
            icon: Icons.bar_chart_rounded,
            label: 'Intelligence',
          ),
          _buildItem(
            tab: RailTab.calendar,
            aliases: [RailTab.calendar],
            icon: Icons.calendar_month_outlined,
            label: 'Calendar',
          ),
          _buildItem(
            tab: RailTab.history,
            aliases: [RailTab.history],
            icon: Icons.history_rounded,
            label: 'History',
          ),
          _buildItem(
            tab: RailTab.trend,
            aliases: [RailTab.trend, RailTab.progress],
            icon: Icons.trending_up_rounded,
            label: 'Trend',
          ),
          _buildItem(
            tab: RailTab.more,
            aliases: [RailTab.more, RailTab.reports],
            icon: Icons.more_horiz_rounded,
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required RailTab tab,
    required List<RailTab> aliases,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = aliases.contains(selectedTab);

    if (isSelected) {
      return Container(
        width: 58,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE50914),
              Color(0xFF9E0010),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE50914).withValues(alpha: 0.45),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: BadGymTypography.fontHeading,
                  fontWeight: FontWeight.w800,
                  fontSize: 8.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTabSelected?.call(tab);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 58,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFFA1A1AA), size: 19),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: BadGymTypography.fontBody,
                  fontWeight: FontWeight.w600,
                  fontSize: 8.0,
                  color: Color(0xFFA1A1AA),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
