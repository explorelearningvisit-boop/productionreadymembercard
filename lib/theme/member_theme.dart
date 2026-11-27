import 'package:flutter/material.dart';

/// Semantic tokens for plan-aware pearl-glass BAD GYM dashboard.
abstract final class MemberTheme {
  static const canvas = Color(0xFFEDE0FF);
  static const purple = Color(0xFF7410D2);
  static const deepPurple = Color(0xFF31005F);
  static const framePurple = Color(0xFF4B087D);
  static const gold = Color(0xFFFFE45E);
  static const green = Color(0xFF12B95F);
  static const rose = Color(0xFFE52D55);
  static const ink = Color(0xFF170B2B);
  static const muted = Color(0xFF655778);
  static const surface = Color(0xFFFFFCFF);
  static const glass = Color(0xFFFDF8FF);
  static const glassEdge = Color(0xFFDCC4F2);
  static const sky = Color(0xFFD9F1FF);
  static const mint = Color(0xFFD9FFE5);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: purple,
      brightness: Brightness.light,
    ).copyWith(primary: purple, secondary: gold, surface: surface, error: rose);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: canvas,
      visualDensity: VisualDensity.standard,
      splashFactory: InkRipple.splashFactory,
      textTheme: Typography.material2021().black.apply(bodyColor: ink, displayColor: ink),
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
    // The reference-led dashboard uses one consistent lilac glass workspace
    // for every membership tier. Tier identity remains visible in its badge;
    // operational states (present/late/absent/payment due) keep their semantics.
    if (normalized.contains('spark')) {
      return const MemberPlanPalette(
        planName: 'Spark',
        frameGradient: [Color(0xFF6B19B5), Color(0xFFCDA9F5), Color(0xFF7B35C6)],
        canvasGradient: [Color(0xFFF4E9FF), Color(0xFFEAD9FF), Color(0xFFF9F3FF)],
        railGradient: [Color(0xFF5C159D), Color(0xFF35105F)],
        checkInGradient: [Color(0xFF6E13C5), Color(0xFFB52CEB), Color(0xFF5B0FA7)],
        progressGradient: [Color(0xFFB8F6C7), Color(0xFF20C65A), Color(0xFF079B46)],
        frameRim: Color(0xFFE4C9FF),
        panelEdge: Color(0xFFD8BDF2),
        accent: Color(0xFF7818C8),
        accentSoft: Color(0xFFF0E2FF),
        railSelected: Color(0xFFE8D2FF),
        planBadgeGradient: [Color(0xFFB7F18A), Color(0xFF5AD68B)],
        planBadgeText: Color(0xFF063D2C),
        surface: Color(0xFFFFFCFF),
      );
    }
    if (normalized.contains('silver')) {
      return const MemberPlanPalette(
        planName: 'Silver',
        frameGradient: [Color(0xFF6B19B5), Color(0xFFCDA9F5), Color(0xFF7B35C6)],
        canvasGradient: [Color(0xFFF4E9FF), Color(0xFFEAD9FF), Color(0xFFF9F3FF)],
        railGradient: [Color(0xFF5C159D), Color(0xFF35105F)],
        checkInGradient: [Color(0xFF6E13C5), Color(0xFFB52CEB), Color(0xFF5B0FA7)],
        progressGradient: [Color(0xFFB8F6C7), Color(0xFF20C65A), Color(0xFF079B46)],
        frameRim: Color(0xFFE4C9FF),
        panelEdge: Color(0xFFD8BDF2),
        accent: Color(0xFF7818C8),
        accentSoft: Color(0xFFF0E2FF),
        railSelected: Color(0xFFE8D2FF),
        planBadgeGradient: [Color(0xFFEAF1F9), Color(0xFFB8C9DD)],
        planBadgeText: Color(0xFF203A56),
        surface: Color(0xFFFFFCFF),
      );
    }
    if (normalized.contains('diamond')) {
      return const MemberPlanPalette(
      planName: 'Gold',
      frameGradient: [Color(0xFF6B19B5), Color(0xFFCDA9F5), Color(0xFF7B35C6)],
      canvasGradient: [Color(0xFFF4E9FF), Color(0xFFEAD9FF), Color(0xFFF9F3FF)],
      railGradient: [Color(0xFF5C159D), Color(0xFF35105F)],
      checkInGradient: [Color(0xFF6E13C5), Color(0xFFB52CEB), Color(0xFF5B0FA7)],
      progressGradient: [Color(0xFFB8F6C7), Color(0xFF20C65A), Color(0xFF079B46)],
      frameRim: Color(0xFFE4C9FF),
      panelEdge: Color(0xFFD8BDF2),
      accent: Color(0xFF7818C8),
      accentSoft: Color(0xFFF0E2FF),
      railSelected: Color(0xFFE8D2FF),
      planBadgeGradient: [Color(0xFFFFF0A8), Color(0xFFE7B43B)],
      planBadgeText: Color(0xFF422800),
      surface: Color(0xFFFFFCFF),
    );
  }
}

class MemberPlanTheme extends InheritedWidget {
  const MemberPlanTheme({required this.palette, required super.child, super.key});
  final MemberPlanPalette palette;

  static MemberPlanPalette of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<MemberPlanTheme>();
    assert(scope != null, 'MemberPlanTheme is missing above this context');
    return scope!.palette;
  }

  @override
  bool updateShouldNotify(MemberPlanTheme oldWidget) => palette.planName != oldWidget.palette.planName;
}
