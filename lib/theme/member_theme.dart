import 'package:flutter/material.dart';

/// Neutral and semantic tokens shared by every member plan.
abstract final class MemberTheme {
  static const canvas = Color(0xFFE9D8FF);
  static const purple = Color(0xFF6B12C9);
  static const deepPurple = Color(0xFF2D0454);
  static const framePurple = Color(0xFF270044);
  static const gold = Color(0xFFFFD34E);
  static const green = Color(0xFF12D56A);
  static const rose = Color(0xFFE52B52);
  static const ink = Color(0xFF220B3B);
  static const muted = Color(0xFF746583);
  static const surface = Color(0xFFFFFCFF);
  static const glass = Color(0xFFF8F2FF);
  static const glassEdge = Color(0xFFDCC5F3);
  static const sky = Color(0xFFD9F1FF);
  static const mint = Color(0xFFD8FFE2);

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

/// A plan controls the outer frame, canvas, rail, progress and plan accents.
/// Product/finance status colors remain semantic and consistent across plans.
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
        canvasGradient: [Color(0xFFFFFFFF), Color(0xFFE9FFF1), Color(0xFFDDF8E8)],
        railGradient: [Color(0xFF08734B), Color(0xFF03432F)],
        checkInGradient: [Color(0xFF137A50), Color(0xFF20B978), Color(0xFF07583B)],
        progressGradient: [Color(0xFF35D987), Color(0xFF0DAD67), Color(0xFF078552)],
        frameRim: Color(0xFFB7F18A),
        panelEdge: Color(0xFFB8E8CC),
        accent: Color(0xFF078552),
        accentSoft: Color(0xFFE2F8EA),
        railSelected: Color(0xFFD7FF9C),
        planBadgeGradient: [Color(0xFFB7F18A), Color(0xFF5AD68B)],
        planBadgeText: Color(0xFF063D2C),
        surface: Color(0xFFF8FFFA),
      );
    }

    if (normalized.contains('silver')) {
      return const MemberPlanPalette(
        planName: 'Silver',
        frameGradient: [Color(0xFF23334C), Color(0xFF58789B), Color(0xFF273B54)],
        canvasGradient: [Color(0xFFFFFFFF), Color(0xFFF0F6FF), Color(0xFFE1EDFA)],
        railGradient: [Color(0xFF3B5878), Color(0xFF1F3149)],
        checkInGradient: [Color(0xFF315C89), Color(0xFF527EAE), Color(0xFF294566)],
        progressGradient: [Color(0xFF73B6FF), Color(0xFF367FC5), Color(0xFF245C9C)],
        frameRim: Color(0xFFD4E3F5),
        panelEdge: Color(0xFFC6D7E9),
        accent: Color(0xFF2B659D),
        accentSoft: Color(0xFFE5F1FF),
        railSelected: Color(0xFFDCEBFF),
        planBadgeGradient: [Color(0xFFEAF1F9), Color(0xFFB8C9DD)],
        planBadgeText: Color(0xFF203A56),
        surface: Color(0xFFFBFDFF),
      );
    }

    // Gold is the approved reference treatment and the safe fallback.
    return const MemberPlanPalette(
      planName: 'Gold',
      frameGradient: [Color(0xFF25004D), Color(0xFF6415B4), Color(0xFF26004F)],
      canvasGradient: [Color(0xFFFFFDFF), Color(0xFFFFF8EA), Color(0xFFF4E9FF)],
      railGradient: [Color(0xFF4B087F), Color(0xFF280052)],
      checkInGradient: [Color(0xFF4B176F), Color(0xFF7931A8), Color(0xFF35104F)],
      progressGradient: [Color(0xFFFFD76A), Color(0xFFE9A927), Color(0xFFFFE58A)],
      frameRim: Color(0xFFFFD34E),
      panelEdge: Color(0xFFE7CDA4),
      accent: Color(0xFF6B12C9),
      accentSoft: Color(0xFFF1E4FF),
      railSelected: Color(0xFFFFE77A),
      planBadgeGradient: [Color(0xFFFFE36A), Color(0xFFFFB91E)],
      planBadgeText: Color(0xFF3B2600),
      surface: Color(0xFFFFFCF7),
    );
  }
}

/// Injected above the member dashboard so each member renders with their
/// own plan-specific visual identity instead of a single global purple theme.
class MemberPlanTheme extends InheritedWidget {
  const MemberPlanTheme({
    required this.palette,
    required super.child,
    super.key,
  });

  final MemberPlanPalette palette;

  static MemberPlanPalette of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<MemberPlanTheme>();
    assert(scope != null, 'MemberPlanTheme is missing above this context');
    return scope!.palette;
  }

  @override
  bool updateShouldNotify(MemberPlanTheme oldWidget) =>
      palette.planName != oldWidget.palette.planName;
}
