import 'package:flutter/material.dart';

/// Shared tokens for the Pearl Glass / Purple Neon member dashboard.
///
/// Purple is reserved for the outer frame, navigation rail and selected
/// actions. Main content surfaces stay pearl-white / pale lavender.
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
