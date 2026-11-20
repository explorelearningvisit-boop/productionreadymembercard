import 'package:flutter/material.dart';

/// Visual tokens extracted from the supplied BAD GYM green-glass dashboard reference.
class MemberTheme {
  static const forest = Color(0xFF075B45);
  static const emerald = Color(0xFF10C94A);
  static const leaf = Color(0xFF8BFF16);
  static const mint = Color(0xFFDDFBF2);
  static const canvas = Color(0xFFEAF8F7);
  static const surface = Color(0xFFF8FFFF);
  static const ink = Color(0xFF101D1B);
  static const muted = Color(0xFF5D7773);
  static const line = Color(0xFFB9E9E2);
  static const gold = Color(0xFFFFC51B);
  static const red = Color(0xFFE5264F);
  static const blue = Color(0xFF18BDE0);
  static const purple = Color(0xFF9C35E8);
  static const teal = Color(0xFF087F70);
  static const glass = Color(0xCCF5FFFF);
  static const deepGlass = Color(0xE6085947);

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
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xF7FFFFFF), Color(0xDDF0FFFF), Color(0xE6E5FAF7)],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withValues(alpha: .96), width: 1.4),
        boxShadow: elevated
            ? const [
                BoxShadow(
                  color: Color(0x26005C48),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
                BoxShadow(
                  color: Color(0xBFFFFFFF),
                  blurRadius: 7,
                  offset: Offset(-3, -3),
                ),
              ]
            : const [],
      );

  static BoxDecoration softSurface({double radius = 16, Color? tint}) =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            tint ?? const Color(0xFFF9FFFF),
            const Color(0xFFEAF9F7),
          ],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withValues(alpha: .95), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18005D4C),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      );
}
