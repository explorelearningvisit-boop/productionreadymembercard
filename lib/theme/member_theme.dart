import 'package:flutter/material.dart';

/// Semantic tokens for BAD GYM's Emerald + Pearl member dashboard.
abstract final class MemberTheme {
  static const canvas = Color(0xFFEAF3EF);
  static const emerald = Color(0xFF0F8457);
  static const emeraldDeep = Color(0xFF07533E);
  static const forest = Color(0xFF01493C);
  static const forestInk = Color(0xFF012022);

  static const gold = Color(0xFFD6AA3C);
  static const goldSoft = Color(0xFFFFF1C8);

  static const green = emerald;
  static const rose = Color(0xFFD94B5D);
  static const amber = Color(0xFFD69A2D);
  static const holiday = Color(0xFF766899);
  static const off = Color(0xFF7A8983);

  static const ink = Color(0xFF142C25);
  static const muted = Color(0xFF536A61);
  static const mutedSoft = Color(0xFF788C83);

  static const surface = Color(0xFFFCFDFD);
  static const glass = Color(0xFFF6FAFA);
  static const raised = Color(0xFFF0F6F7);
  static const glassEdge = Color(0xFFD6E5DC);

  static const sky = Color(0xFFE3F2FA);
  static const skyInk = Color(0xFF236C98);
  static const mint = Color(0xFFE0F6E7);
  static const lavender = Color(0xFFEEEAF6);
  static const ice = Color(0xFFE5F4FC);
  static const iceInk = Color(0xFF267CA3);

  // Compatibility aliases: violet is now a muted semantic accent only.
  static const purple = holiday;
  static const deepPurple = forestInk;
  static const framePurple = forest;

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: emerald,
      brightness: Brightness.light,
    ).copyWith(
      primary: emerald,
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
    final isSpark = normalized.contains('spark');
    final isSilver = normalized.contains('silver');
    final isDiamond = normalized.contains('diamond');

    final badge = isSpark
        ? const [Color(0xFFDDF5C7), Color(0xFF8ACD79)]
        : isSilver
            ? const [Color(0xFFF0F4F6), Color(0xFFB9C9D0)]
            : isDiamond
                ? const [Color(0xFFE5F5FC), Color(0xFF9CCFE0)]
                : const [Color(0xFFFFF1C8), Color(0xFFD6AA3C)];
    final badgeText = isSpark
        ? const Color(0xFF174D35)
        : isSilver
            ? const Color(0xFF334C59)
            : isDiamond
                ? const Color(0xFF174B62)
                : const Color(0xFF543B0A);
    final tierAccent = isSilver
        ? const Color(0xFF557684)
        : isDiamond
            ? const Color(0xFF277D98)
            : emerald;
    final tierAccentSoft = isSilver
        ? const Color(0xFFEAF0F2)
        : isDiamond
            ? const Color(0xFFE2F3F8)
            : const Color(0xFFDDF3E6);

    // All plans share the Emerald/Pearl shell; tier identity stays in the badge.
    return MemberPlanPalette(
      planName: isSpark ? 'Spark' : isSilver ? 'Silver' : isDiamond ? 'Diamond' : 'Gold',
      frameGradient: const [
        Color(0xFF012022),
        Color(0xFF01493C),
        Color(0xFF073B31),
      ],
      canvasGradient: const [
        Color(0xFFF6FAFA),
        Color(0xFFECF3EE),
        Color(0xFFFCFDFD),
      ],
      railGradient: const [Color(0xFF07533E), Color(0xFF063D31)],
      checkInGradient: const [
        Color(0xFF0B6B49),
        Color(0xFF16885A),
        Color(0xFF07533E),
      ],
      progressGradient: const [
        Color(0xFF37B978),
        Color(0xFF0F8457),
        Color(0xFF08734B),
      ],
      frameRim: const Color(0xFFB9E1CF),
      panelEdge: const Color(0xFFD6E5DC),
      accent: tierAccent,
      accentSoft: tierAccentSoft,
      railSelected: const Color(0xFFE0F6E7),
      planBadgeGradient: badge,
      planBadgeText: badgeText,
      surface: MemberTheme.surface,
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
