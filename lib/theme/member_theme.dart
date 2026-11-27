import 'package:flutter/material.dart';

/// Shared semantic tokens for the BAD GYM member workspace.
abstract final class MemberTheme {
  static const canvas = Color(0xFFF7F4EE);
  static const purple = Color(0xFF0B6743);
  static const deepPurple = Color(0xFF063A29);
  static const framePurple = Color(0xFF06432D);
  static const gold = Color(0xFFFDE870);
  static const green = Color(0xFF12A66A);
  static const rose = Color(0xFFC94A54);
  static const ink = Color(0xFF241D17);
  static const muted = Color(0xFF71685F);
  static const surface = Color(0xFFFFFCF7);
  static const glass = Color(0xFFFCF9F3);
  static const glassEdge = Color(0xFFE6D8C5);
  static const sky = Color(0xFFDDEEFF);
  static const mint = Color(0xFFE2F4E7);

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

/// A member plan drives the shared shell; content status colours remain semantic.
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
        frameGradient: [
          Color(0xFF06452F),
          Color(0xFF0A9560),
          Color(0xFF063D2C),
        ],
        canvasGradient: [
          Color(0xFFFFFEFC),
          Color(0xFFF4FBF5),
          Color(0xFFEAF5EC),
        ],
        railGradient: [Color(0xFF07563A), Color(0xFF033523)],
        checkInGradient: [
          Color(0xFF07563A),
          Color(0xFF0A8A58),
          Color(0xFF03432D),
        ],
        progressGradient: [
          Color(0xFFB9E77C),
          Color(0xFF72C75B),
          Color(0xFFD8F1A7),
        ],
        frameRim: Color(0xFFC9EA91),
        panelEdge: Color(0xFFCFE3D3),
        accent: Color(0xFF08784C),
        accentSoft: Color(0xFFE6F4E9),
        railSelected: Color(0xFFDDF39B),
        planBadgeGradient: [Color(0xFFB7F18A), Color(0xFF5AD68B)],
        planBadgeText: Color(0xFF063D2C),
        surface: Color(0xFFFFFCF7),
      );
    }

    if (normalized.contains('silver')) {
      return const MemberPlanPalette(
        planName: 'Silver',
        frameGradient: [
          Color(0xFF23334C),
          Color(0xFF58789B),
          Color(0xFF273B54),
        ],
        canvasGradient: [
          Color(0xFFFFFEFC),
          Color(0xFFF5F7FA),
          Color(0xFFEAF0F6),
        ],
        railGradient: [Color(0xFF243B56), Color(0xFF14263B)],
        checkInGradient: [
          Color(0xFF315C89),
          Color(0xFF527EAE),
          Color(0xFF294566),
        ],
        progressGradient: [
          Color(0xFFB9D5ED),
          Color(0xFF6C9CC7),
          Color(0xFFD6E7F4),
        ],
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

    // Gold follows reference 1: forest check-in shell, champagne edge,
    // pearl information surface and the wine rail / gold selected state
    // sampled from reference 2.
    return const MemberPlanPalette(
      planName: 'Gold',
      frameGradient: [
        Color(0xFF063D2B),
        Color(0xFF0A6846),
        Color(0xFF042F21),
      ],
      canvasGradient: [
        Color(0xFFFFFEFC),
        Color(0xFFF9F7F2),
        Color(0xFFF4F0E8),
      ],
      railGradient: [Color(0xFF6D0201), Color(0xFF3A080D)],
      checkInGradient: [
        Color(0xFF003D26),
        Color(0xFF087D48),
        Color(0xFF03452E),
      ],
      progressGradient: [
        Color(0xFFF8D86A),
        Color(0xFFD4A02C),
        Color(0xFFF8E7A6),
      ],
      frameRim: Color(0xFFF6D16E),
      panelEdge: Color(0xFFE6D8C5),
      accent: Color(0xFF0B6743),
      accentSoft: Color(0xFFEAF3EC),
      railSelected: Color(0xFFFDE870),
      planBadgeGradient: [Color(0xFFFDE870), Color(0xFFDDAE29)],
      planBadgeText: Color(0xFF35240A),
      surface: Color(0xFFFFFCF7),
    );
  }
}

/// Injected above a member card so frame, rail and progress use one plan.
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
