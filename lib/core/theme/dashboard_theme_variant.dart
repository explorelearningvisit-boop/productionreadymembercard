import 'package:flutter/material.dart';

enum DashboardThemeVariant {
  festiveGold,
  crimsonWave,
  darkObsidianGold,
  emeraldNeon,
  royalPurple;

  String get displayName {
    switch (this) {
      case DashboardThemeVariant.festiveGold:
        return 'Festive Gold';
      case DashboardThemeVariant.crimsonWave:
        return 'Crimson Wave';
      case DashboardThemeVariant.darkObsidianGold:
        return 'Dark Obsidian';
      case DashboardThemeVariant.emeraldNeon:
        return 'Emerald Neon';
      case DashboardThemeVariant.royalPurple:
        return 'Royal Purple';
    }
  }

  String get subtitle {
    switch (this) {
      case DashboardThemeVariant.festiveGold:
        return 'Royal Crimson & Golden Marquee';
      case DashboardThemeVariant.crimsonWave:
        return 'Athletic Red & Leaf Accent';
      case DashboardThemeVariant.darkObsidianGold:
        return 'Luxury Black Gold & Payment Intelligence';
      case DashboardThemeVariant.emeraldNeon:
        return 'Bio-Green & Cyber Glow';
      case DashboardThemeVariant.royalPurple:
        return 'Neon Violet & AI Trend Spline';
    }
  }

  Color get primaryColor {
    switch (this) {
      case DashboardThemeVariant.festiveGold:
        return const Color(0xFFE50914);
      case DashboardThemeVariant.crimsonWave:
        return const Color(0xFFD32F2F);
      case DashboardThemeVariant.darkObsidianGold:
        return const Color(0xFFFFD700);
      case DashboardThemeVariant.emeraldNeon:
        return const Color(0xFF00E676);
      case DashboardThemeVariant.royalPurple:
        return const Color(0xFF8B5CF6);
    }
  }

  Color get accentColor {
    switch (this) {
      case DashboardThemeVariant.festiveGold:
        return const Color(0xFFFFD700);
      case DashboardThemeVariant.crimsonWave:
        return const Color(0xFF00C853);
      case DashboardThemeVariant.darkObsidianGold:
        return const Color(0xFFFFB300);
      case DashboardThemeVariant.emeraldNeon:
        return const Color(0xFF00FF66);
      case DashboardThemeVariant.royalPurple:
        return const Color(0xFFA855F7);
    }
  }

  bool get isDarkMode => this == DashboardThemeVariant.darkObsidianGold;

  LinearGradient get canvasGradient {
    switch (this) {
      case DashboardThemeVariant.festiveGold:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFD34E),
            Color(0xFFFFE8A0),
            Color(0xFFFFF6D9),
            Color(0xFFFFF9EC),
          ],
          stops: [0.0, 0.12, 0.28, 1.0],
        );
      case DashboardThemeVariant.crimsonWave:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFFF0F2),
            Color(0xFFFFFFFF),
          ],
        );
      case DashboardThemeVariant.darkObsidianGold:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0D0E12),
            Color(0xFF13151D),
            Color(0xFF161822),
          ],
        );
      case DashboardThemeVariant.emeraldNeon:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF00E676),
            Color(0xFF056428),
            Color(0xFF0A3818),
            Color(0xFF051C0C),
          ],
          stops: [0.0, 0.15, 0.5, 1.0],
        );
      case DashboardThemeVariant.royalPurple:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF3E8FF),
            Color(0xFFEDE9FE),
            Color(0xFFFFFFFF),
          ],
        );
    }
  }
}
