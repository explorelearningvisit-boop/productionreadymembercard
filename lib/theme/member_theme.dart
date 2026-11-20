import 'package:flutter/material.dart';

class MemberTheme {
  static const forest = Color(0xFF176B45);
  static const emerald = Color(0xFF0B8F61);
  static const leaf = Color(0xFFBDEB79);
  static const mint = Color(0xFFE4F4E9);
  static const canvas = Color(0xFFF4F7F2);
  static const surface = Color(0xFFFFFFFF);
  static const ink = Color(0xFF18382B);
  static const muted = Color(0xFF718278);
  static const line = Color(0xFFDCE8DF);
  static const gold = Color(0xFFF4C85B);
  static const red = Color(0xFFD94B58);
  static const blue = Color(0xFF4779D8);
  static const purple = Color(0xFF8B61C8);
  static const teal = Color(0xFF149A91);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(
          seedColor: forest,
          primary: forest,
          secondary: emerald,
          surface: surface,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: ink, fontWeight: FontWeight.w800),
          bodyMedium: TextStyle(color: ink),
        ),
      );

  static BoxDecoration card({double radius = 22, bool elevated = true}) =>
      BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: line, width: 1),
        boxShadow: elevated
            ? const [
                BoxShadow(
                  color: Color(0x120E4B2F),
                  blurRadius: 18,
                  offset: Offset(0, 7),
                ),
                BoxShadow(
                  color: Color(0xBFFFFFFF),
                  blurRadius: 4,
                  offset: Offset(-2, -2),
                ),
              ]
            : const [],
      );

  static BoxDecoration softSurface({double radius = 16, Color? tint}) =>
      BoxDecoration(
        color: tint ?? const Color(0xFFF7FAF7),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: line.withValues(alpha: .8)),
      );
}
