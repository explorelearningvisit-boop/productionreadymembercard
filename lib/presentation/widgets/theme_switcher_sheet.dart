import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/theme/dashboard_theme_variant.dart';

class ThemeSwitcherSheet extends StatelessWidget {
  final DashboardThemeVariant currentTheme;
  final ValueChanged<DashboardThemeVariant> onThemeSelected;

  const ThemeSwitcherSheet({
    super.key,
    required this.currentTheme,
    required this.onThemeSelected,
  });

  static Future<void> show(
    BuildContext context, {
    required DashboardThemeVariant currentTheme,
    required ValueChanged<DashboardThemeVariant> onThemeSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ThemeSwitcherSheet(
        currentTheme: currentTheme,
        onThemeSelected: onThemeSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: const BoxDecoration(
        color: Color(0xFF161822),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.palette_rounded, color: Color(0xFFFFD700), size: 24),
              const SizedBox(width: 10),
              const Text(
                'BAD GYM Dashboard Variations',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white70),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Switch instantly between all 5 production theme designs:',
            style: TextStyle(color: Colors.white60, fontSize: 13),
          ),
          const SizedBox(height: 18),
          ...DashboardThemeVariant.values.map((variant) {
            final bool isSelected = variant == currentTheme;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  onThemeSelected(variant);
                  Navigator.of(context).pop();
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? variant.primaryColor.withValues(alpha: 0.18)
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? variant.primaryColor : Colors.white12,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          gradient: variant.canvasGradient,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Center(
                          child: Icon(
                            _getIconForVariant(variant),
                            color: variant.isDarkMode ? Colors.white : Colors.black87,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              variant.displayName,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.9),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              variant.subtitle,
                              style: TextStyle(
                                color: isSelected ? variant.primaryColor : Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: variant.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 16),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getIconForVariant(DashboardThemeVariant variant) {
    switch (variant) {
      case DashboardThemeVariant.festiveGold:
        return Icons.auto_awesome;
      case DashboardThemeVariant.crimsonWave:
        return Icons.waves;
      case DashboardThemeVariant.darkObsidianGold:
        return Icons.dark_mode;
      case DashboardThemeVariant.emeraldNeon:
        return Icons.eco;
      case DashboardThemeVariant.royalPurple:
        return Icons.bolt;
    }
  }
}
