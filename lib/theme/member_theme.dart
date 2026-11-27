import 'package:flutter/material.dart';

/// Shared semantic tokens for the lavender pearl-glass BAD GYM dashboard.
abstract final class MemberTheme {
  static const canvas = Color(0xFFF0E5FF);
  static const purple = Color(0xFF7716CA);
  static const deepPurple = Color(0xFF32105E);
  static const framePurple = Color(0xFF5A1696);
  static const gold = Color(0xFFFFD85D);
  static const green = Color(0xFF16B957);
  static const rose = Color(0xFFE42F55);
  static const amber = Color(0xFFE7A51C);
  static const ink = Color(0xFF210B42);
  static const muted = Color(0xFF705D88);
  static const surface = Color(0xFFFFFCFF);
  static const glass = Color(0xFFFDF8FF);
  static const glassEdge = Color(0xFFD8BDF2);
  static const sky = Color(0xFFD9F1FF);
  static const mint = Color(0xFFD9FFE5);
  static const lavender = Color(0xFFE8D5FA);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: purple,
      brightness: Brightness.light,
    ).copyWith(
      primary: purple,
      secondary: gold,
      surface: surface,
      error: rose,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: canvas,
      visualDensity: VisualDensity.standard,
      splashFactory: InkRipple.splashFactory,
      textTheme: Typography.material2021().black.apply(
        bodyColor: ink,
        displayColor: ink,
      ),
    );
  }
}

@immutable
class MemberPlanPalette {
  const MemberPlanPalette({
    required this.planName,
    required this.frameGradient,
    required this.canvasGradient,
    required this.railGradient,
    required this.checkInGradient,
    required this.progressGradient,
    required this.frameRim,
    required this.panelEdge,
    required this.accent,
    required this.accentSoft,
    required this.railSelected,
    required this.planBadgeGradient,
    required this.planBadgeText,
    required this.surface,
  });

  final String planName;
  final List<Color> frameGradient;
  final List<Color> canvasGradient;
  final List<Color> railGradient;
  final List<Color> checkInGradient;
  final List<Color> progressGradient;
  final Color frameRim;
  final Color panelEdge;
  final Color accent;
  final Color accentSoft;
  final Color railSelected;
  final List<Color> planBadgeGradient;
  final Color planBadgeText;
  final Color surface;

  static MemberPlanPalette forPlan(String plan) {
    final normalized = plan.toLowerCase();
    final badge = normalized.contains('spark')
        ? const [Color(0xFFB7F18A), Color(0xFF5AD68B)]
        : normalized.contains('silver')
            ? const [Color(0xFFEAF1F9), Color(0xFFB8C9DD)]
            : normalized.contains('diamond')
                ? const [Color(0xFFEAFBFF), Color(0xFF8FD5EC)]
                : const [Color(0xFFFFF0A8), Color(0xFFE7B43B)];
    final badgeText = normalized.contains('spark')
        ? const Color(0xFF063D2C)
        : normalized.contains('silver')
            ? const Color(0xFF203A56)
            : normalized.contains('diamond')
                ? const Color(0xFF17445B)
                : const Color(0xFF422800);

    // All plans share the reference-led lavender glass shell. Tier identity
    // remains in the plan badge; status colours keep their operational meaning.
    return MemberPlanPalette(
      planName: normalized.contains('spark')
          ? 'Spark'
          : normalized.contains('silver')
              ? 'Silver'
              : normalized.contains('diamond')
                  ? 'Diamond'
                  : 'Gold',
      frameGradient: const [
        Color(0xFF6B19B5),
        Color(0xFFCDA9F5),
        Color(0xFF7B35C6),
      ],
      canvasGradient: const [
        Color(0xFFF4E9FF),
        Color(0xFFEAD9FF),
        Color(0xFFF9F3FF),
      ],
      railGradient: const [Color(0xFF5C159D), Color(0xFF35105F)],
      checkInGradient: const [
        Color(0xFF6E13C5),
        Color(0xFFB52CEB),
        Color(0xFF5B0FA7),
      ],
      progressGradient: const [
        Color(0xFFB8F6C7),
        Color(0xFF20C65A),
        Color(0xFF079B46),
      ],
      frameRim: const Color(0xFFE4C9FF),
      panelEdge: const Color(0xFFD8BDF2),
      accent: MemberTheme.purple,
      accentSoft: const Color(0xFFF0E2FF),
      railSelected: const Color(0xFFE8D2FF),
      planBadgeGradient: badge,
      planBadgeText: badgeText,
      surface: const Color(0xFFFFFCFF),
    );
  }
}

class MemberPlanTheme extends InheritedWidget {
  const MemberPlanTheme({
    required this.palette,
    required super.child,
    super.key,
  });

  final MemberPlanPalette palette;

  static MemberPlanPalette of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<MemberPlanTheme>();
    assert(scope != null, 'MemberPlanTheme is missing above this context');
    return scope!.palette;
  }

  @override
  bool updateShouldNotify(MemberPlanTheme oldWidget) =>
      palette.planName != oldWidget.palette.planName ||
      palette.planBadgeGradient != oldWidget.palette.planBadgeGradient;
}
