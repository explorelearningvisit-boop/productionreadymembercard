import 'package:flutter/material.dart';

abstract final class MemberTheme {
  static const canvas = Color(0xFF26004F);
  static const purple = Color(0xFF6416B8);
  static const deepPurple = Color(0xFF2C075B);
  static const gold = Color(0xFFFFD34E);
  static const green = Color(0xFF12D56A);
  static const ink = Color(0xFF250B46);
  static const muted = Color(0xFF746B80);
  static const surface = Color(0xFFFFFCFF);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: purple,
      brightness: Brightness.light,
    ).copyWith(
      primary: purple,
      secondary: gold,
      surface: Colors.white,
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
