import 'package:flutter/material.dart';

/// Semantic tokens for BAD GYM pearl-glass / purple-neon dashboard.
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
    if (normalized.contains('spark')) {
      return const MemberPlanPalette(
        planName: 'Spark',
        frameGradient: [Color(0xFF06452F), Color(0xFF0A9560), Color(0xFF063D2C)],
        canvasGradient: [Color(0xFFFFFEFF), Color(0xFFF4FBF5), Color(0xFFEAF5EC)],
        railGradient: [Color(0xFF07563A), Color(0xFF033523)],
        checkInGradient: [Color(0xFF07563A), Color(0xFF0A8A58), Color(0xFF03432D)],
        progressGradient: [Color(0xFFB9E77C), Color(0xFF72C75B), Color(0xFFD8F1A7)],
        frameRim: Color(0xFFC9EA91),
        panelEdge: Color(0xFFCFE3D3),
        accent: Color(0xFF08784C),
        accentSoft: Color(0xFFE6F4E9),
        railSelected: Color(0xFFDDF39B),
        planBadgeGradient: [Color(0xFFB7F18A), Color(0xFF5AD68B)],
        planBadgeText: Color(0xFF063D2C),
        surface: Color(0xFFFFFCFF),
      );
    }
    if (normalized.contains('silver')) {
      return const MemberPlanPalette(
        planName: 'Silver',
        frameGradient: [Color(0xFF23334C), Color(0xFF58789B), Color(0xFF273B54)],
        canvasGradient: [Color(0xFFFFFEFF), Color(0xFFF5F7FA), Color(0xFFEAF0F6)],
        railGradient: [Color(0xFF243B56), Color(0xFF14263B)],
        checkInGradient: [Color(0xFF315C89), Color(0xFF527EAE), Color(0xFF294566)],
        progressGradient: [Color(0xFFB9D5ED), Color(0xFF6C9CC7), Color(0xFFD6E7F4)],
        frameRim: Color(0xFFD4E3F5),
        panelEdge: Color(0xFFC6D7E9),
        accent: Color(0xFF2B659D),
        accentSoft: Color(0xFFE8F1F8),
        railSelected: Color(0xFFDCEBFF),
        planBadgeGradient: [Color(0xFFEAF1F9), Color(0xFFB8C9DD)],
        planBadgeText: Color(0xFF203A56),
        surface: Color(0xFFFBFDFF),
      );
    }
    return const MemberPlanPalette(
      planName: 'Gold',
      frameGradient: [Color(0xFF210047), Color(0xFF6810B8), Color(0xFF31005F), Color(0xFF17002F)],
      canvasGradient: [Color(0xFFFFFCFF), Color(0xFFF7F0FF), Color(0xFFF0E6FF)],
      railGradient: [Color(0xFF7410C9), Color(0xFF3B006D), Color(0xFF250045)],
      checkInGradient: [Color(0xFF3E006F), Color(0xFF8D16E5), Color(0xFF3A006C)],
      progressGradient: [Color(0xFFFFE56D), Color(0xFF8F22E9), Color(0xFF4E00A4)],
      frameRim: Color(0xFFFFDE54),
      panelEdge: Color(0xFFDDBCF6),
      accent: Color(0xFF7410D2),
      accentSoft: Color(0xFFF0E3FF),
      railSelected: Color(0xFFFFE45E),
      planBadgeGradient: [Color(0xFFFFE45E), Color(0xFFFFB928)],
      planBadgeText: Color(0xFF3D1764),
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
