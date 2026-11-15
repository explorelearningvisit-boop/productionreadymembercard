import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';
import 'package:bad_gym/core/theme/dashboard_theme_variant.dart';

class TopBrandBar extends StatelessWidget {
  final MemberIntelligenceData data;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onCalendarPressed;
  final VoidCallback? onThemeSwitcherPressed;
  final DashboardThemeVariant themeVariant;

  const TopBrandBar({
    super.key,
    required this.data,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.onCalendarPressed,
    this.onThemeSwitcherPressed,
    this.themeVariant = DashboardThemeVariant.festiveGold,
  });

  Color get _brandTitleColor {
    switch (themeVariant) {
      case DashboardThemeVariant.darkObsidianGold:
        return const Color(0xFFFFD700);
      case DashboardThemeVariant.emeraldNeon:
        return const Color(0xFF00E676);
      case DashboardThemeVariant.royalPurple:
        return const Color(0xFF9333EA);
      case DashboardThemeVariant.festiveGold:
      case DashboardThemeVariant.crimsonWave:
        return const Color(0xFF8B0000);
    }
  }

  Color get _laurelLeafColor {
    switch (themeVariant) {
      case DashboardThemeVariant.darkObsidianGold:
        return const Color(0xFFFFD700);
      case DashboardThemeVariant.emeraldNeon:
        return const Color(0xFF00E676);
      case DashboardThemeVariant.royalPurple:
        return const Color(0xFF9333EA);
      case DashboardThemeVariant.festiveGold:
      case DashboardThemeVariant.crimsonWave:
        return const Color(0xFFD97706);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Hamburger Menu Button (Dark Burgundy Rounded Squircle)
          InkWell(
            key: const ValueKey('header_back_button'),
            onTap: () {
              HapticFeedback.lightImpact();
              onMenuPressed?.call();
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE51C20),
                    Color(0xFF9B0B12),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFFF334B).withValues(alpha: 0.35),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.menu_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // 2. Laurel Crest: BAD GYM FITNESS MANAGEMENT
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Left Laurel Leaf
                  Icon(
                    Icons.eco_rounded,
                    color: _laurelLeafColor,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'BAD GYM',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          letterSpacing: 1.2,
                          color: _brandTitleColor,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              offset: const Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ],
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 1.5),
                      Text(
                        'FITNESS MANAGEMENT',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w700,
                          fontSize: 7.5,
                          letterSpacing: 1.4,
                          color: _brandTitleColor.withValues(alpha: 0.8),
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  // Right Laurel Leaf
                  Transform.flip(
                    flipX: true,
                    child: Icon(
                      Icons.eco_rounded,
                      color: _laurelLeafColor,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // 3. Date & Time Capsule (07:12 AM / 16 Oct 2026) - High Contrast & Crisp
          InkWell(
            onTap: onCalendarPressed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF78080D),
                    Color(0xFF4A0005),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFFFD66B).withValues(alpha: 0.6),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Color(0xFFFFDF7A),
                    size: 15,
                  ),
                  SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '07:12 AM',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '16 Oct 2026',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontBody,
                          fontWeight: FontWeight.w700,
                          fontSize: 8.5,
                          color: Color(0xFFFFDF7A),
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 6),

          // 4. Theme Palette Switcher Button
          InkWell(
            key: const ValueKey('header_theme_switcher_button'),
            onTap: () {
              HapticFeedback.lightImpact();
              onThemeSwitcherPressed?.call();
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    themeVariant.primaryColor,
                    themeVariant.primaryColor.withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: themeVariant.accentColor.withValues(alpha: 0.6),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: themeVariant.primaryColor.withValues(alpha: 0.35),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.palette_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
