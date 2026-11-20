import 'package:flutter/material.dart';

class MemberTheme {
  static const ink = Color(0xFF24103D);
  static const purple = Color(0xFF7900C8);
  static const violet = Color(0xFFB52BFF);
  static const neon = Color(0xFFD500FF);
  static const green = Color(0xFF16C900);
  static const red = Color(0xFFE51B45);
  static const gold = Color(0xFFFFC900);
  static const canvas = Color(0xFFF4EDFF);
  static const muted = Color(0xFF766887);
  static const line = Color(0xFFE4D5F7);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: canvas,
    colorScheme: ColorScheme.fromSeed(
      seedColor: purple,
      primary: purple,
      secondary: neon,
      surface: const Color(0xFFFFFCFF),
    ),
    fontFamily: 'Roboto',
    splashFactory: InkSparkle.splashFactory,
    visualDensity: VisualDensity.standard,
  );

  static BoxDecoration glass({double radius = 22, Color tint = Colors.white}) => BoxDecoration(
    color: tint.withValues(alpha: .91),
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: Colors.white, width: 1.6),
    boxShadow: const [
      BoxShadow(color: Color(0x337B32B8), blurRadius: 18, offset: Offset(0, 7)),
      BoxShadow(color: Color(0xBFFFFFFF), blurRadius: 5, offset: Offset(-2, -2)),
    ],
  );

  static BoxDecoration neonPanel({double radius = 20}) => BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF7600C9), Color(0xFF28004F), Color(0xFF9200D8)],
    ),
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: const Color(0xFFE9B6FF), width: 1.4),
    boxShadow: const [
      BoxShadow(color: Color(0x667C00C9), blurRadius: 18, offset: Offset(0, 5)),
    ],
  );
}
