import 'package:flutter/material.dart';

class MemberTheme {
  static const purple = Color(0xFF7A18D1);
  static const deepPurple = Color(0xFF4A087E);
  static const violet = Color(0xFFB44BFF);
  static const neon = Color(0xFFE879F9);
  static const canvas = Color(0xFFF6ECFF);
  static const ink = Color(0xFF1B1028);
  static const muted = Color(0xFF7C6C88);
  static const line = Color(0xFFE4D0F2);
  static const green = Color(0xFF22C55E);
  static const greenInk = Color(0xFF147A32);
  static const red = Color(0xFFEF3B4D);
  static const gold = Color(0xFFFFC928);
  static const goldDeep = Color(0xFFE39B00);
  static const blue = Color(0xFF38BDF8);
  static const pink = Color(0xFFEC49C2);
  static const peach = Color(0xFFFFE4C8);
  static const shell = Color(0xFF26004F);
  static const shellMid = Color(0xFF4A087E);
  static const electricBlue = Color(0xFF2639B8);
  static const alertRed = Color(0xFFE5092F);
  static const alertDeep = Color(0xFFB9092A);
  static const progressGreen = Color(0xFF18D66B);
  static const spacingXs = 4.0;
  static const spacingSm = 6.0;
  static const spacingMd = 8.0;
  static const spacingLg = 12.0;
  static const cardRadius = 18.0;

  static const display = 'Montserrat';
  static const script = 'GreatVibes';
  static const sale = 'Lobster';

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(seedColor: purple, primary: purple),
        fontFamily: display,
        splashFactory: InkSparkle.splashFactory,
      );

  static BoxDecoration glass({double radius = 22, Color tint = Colors.white}) =>
      BoxDecoration(
        color: tint.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white, width: 1.6),
        boxShadow: const [
          BoxShadow(
            color: Color(0x337A18D1),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      );

  static const TextStyle title = TextStyle(
    fontFamily: display,
    fontWeight: FontWeight.w900,
    color: ink,
    height: 1.05,
  );
}
