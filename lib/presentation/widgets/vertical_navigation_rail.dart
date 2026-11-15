import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

enum RailTab {
  home,
  members,
  workout,
  payment,
  progress,
  reports,
  more,
  // backwards compatible aliases
  intelligence,
  calendar,
  history,
  trend,
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1E0105),
            Color(0xFF55000A),
            Color(0xFF2B0005),
            Color(0xFF140003),
          ],
          stops: [0.0, 0.35, 0.75, 1.0],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.45),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. Top Brand Logo & Swoosh
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.black38,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.fitness_center_rounded,
                    color: Color(0xFFDC2626),
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'BAD\nGYM',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: BadGymTypography.fontHeading,
                  fontWeight: FontWeight.w900,
                  fontSize: 10.5,
                  letterSpacing: 0.8,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 3),
              // Golden curved swoosh
              Container(
                width: 34,
                height: 2,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Color(0xFFFFD66B),
                      Color(0xFFD4AF37),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 2. Navigation Items (Scrollable or expanded evenly)
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Home (Active)
                  _buildRailItem(
                    tab: RailTab.home,
                    aliases: [RailTab.home, RailTab.intelligence, RailTab.overview],
                    icon: Icons.home_rounded,
                    label: 'Home',
                  ),
                  const SizedBox(height: 6),

                  // Members
                  _buildRailItem(
                    tab: RailTab.members,
                    aliases: [RailTab.members],
                    icon: Icons.people_outline_rounded,
                    label: 'Members',
                  ),
                  const SizedBox(height: 6),

                  // Workout
                  _buildRailItem(
                    tab: RailTab.workout,
                    aliases: [RailTab.workout],
                    icon: Icons.fitness_center_rounded,
                    label: 'Workout',
                  ),
                  const SizedBox(height: 6),

                  // Payment
                  _buildRailItem(
                    tab: RailTab.payment,
                    aliases: [RailTab.payment],
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Payment',
                  ),
                  const SizedBox(height: 6),

                  // Progress
                  _buildRailItem(
                    tab: RailTab.progress,
                    aliases: [RailTab.progress, RailTab.trend],
                    icon: Icons.trending_up_rounded,
                    label: 'Progress',
                  ),
                  const SizedBox(height: 6),

                  // Reports
                  _buildRailItem(
                    tab: RailTab.reports,
                    aliases: [RailTab.reports],
                    icon: Icons.bar_chart_rounded,
                    label: 'Reports',
                  ),
                  const SizedBox(height: 6),

                  // More
                  _buildRailItem(
                    tab: RailTab.more,
                    aliases: [RailTab.more],
                    icon: Icons.more_horiz_rounded,
                    label: 'More',
                  ),
                ],
              ),
            ),
          ),

          // 3. Bottom Golden Wave Accent
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 54,
              height: 28,
              child: Image.asset(
                'assets/images/rail_gold_wave_crop.png',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  height: 2,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFD4AF37), Color(0xFFFFDF7A)],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRailItem({
    required RailTab tab,
    required List<RailTab> aliases,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = aliases.contains(selectedTab);

    if (isSelected) {
      // Active State: Glowing Deep Crimson Squircle with Gold Border
      return InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTabSelected?.call(tab);
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 58,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF8B0000),
                Color(0xFF6B000B),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFD4AF37),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8B0000).withValues(alpha: 0.4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: BadGymTypography.fontHeading,
                  fontWeight: FontWeight.w800,
                  fontSize: 9.5,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Inactive State
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTabSelected?.call(tab);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 58,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: const Color(0xFFD1D5DB),
              size: 19,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontFamily: BadGymTypography.fontBody,
                fontWeight: FontWeight.w600,
                fontSize: 9.0,
                color: Color(0xFF9CA3AF),
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
