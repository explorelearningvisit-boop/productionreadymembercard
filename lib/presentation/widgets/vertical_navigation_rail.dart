import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

enum RailTab {
  intelligence,
  calendar,
  history,
  trend,
  more,
  // backwards compatible aliases
  streak,
  analysis,
  goals,
  reports,
  offers,
  overview,
  attendance,
  workout,
  body,
  payment,
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
      width: 64,
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF380008),
            Color(0xFF220004),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFF334B).withValues(alpha: 0.3),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: const Color(0xFFBA0018).withValues(alpha: 0.2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1. Intelligence (Active)
          _buildRailItem(
            tab: RailTab.intelligence,
            icon: Icons.bar_chart_rounded,
            label: 'Intelligence',
          ),

          // 2. Calendar
          _buildRailItem(
            tab: RailTab.calendar,
            icon: Icons.calendar_month_outlined,
            label: 'Calendar',
          ),

          // 3. History
          _buildRailItem(
            tab: RailTab.history,
            icon: Icons.history_rounded,
            label: 'History',
          ),

          // 4. Trend
          _buildRailItem(
            tab: RailTab.trend,
            icon: Icons.trending_up_rounded,
            label: 'Trend',
          ),

          // 5. More
          _buildRailItem(
            tab: RailTab.more,
            icon: Icons.more_horiz_rounded,
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget _buildRailItem({
    required RailTab tab,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = tab == selectedTab ||
        (tab == RailTab.intelligence &&
            (selectedTab == RailTab.intelligence ||
                selectedTab == RailTab.attendance ||
                selectedTab == RailTab.overview));

    if (isSelected) {
      // Active State: Glowing Strawberry Red Squircle Pill
      return Container(
        width: 56,
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
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: const Color(0xFFFF5268),
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE50914).withValues(alpha: 0.6),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 19,
              color: Colors.white,
            ),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: BadGymTypography.fontHeading,
                  fontWeight: FontWeight.w800,
                  fontSize: 8.5,
                  color: Colors.white,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Inactive State: Translucent Capsule
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTabSelected?.call(tab);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 56,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 19,
                color: Colors.white.withValues(alpha: 0.65),
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontBody,
                    fontWeight: FontWeight.w600,
                    fontSize: 8.5,
                    color: Colors.white.withValues(alpha: 0.65),
                    letterSpacing: -0.2,
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
