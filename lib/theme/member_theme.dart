import 'package:flutter/material.dart';

class MemberTheme {
  static const wine = Color(0xFF8B0646);
  static const berry = Color(0xFFC20A62);
  static const pink = Color(0xFFF52B91);
  static const blush = Color(0xFFFFE7F2);
  static const pale = Color(0xFFFFF5FA);
  static const ink = Color(0xFF4B1235);
  static const green = Color(0xFF13B84A);
  static const red = Color(0xFFE52545);
  static const purple = Color(0xFF9B19D5);
  static const gold = Color(0xFFFFC928);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pale,
        colorScheme: ColorScheme.fromSeed(
          seedColor: berry,
          primary: berry,
          secondary: pink,
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
      );

  static BoxDecoration glassCard({double radius = 22, bool bright = false}) =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: bright
              ? [Colors.white, const Color(0xFFFFEAF4)]
              : [const Color(0xFFFFF9FC), const Color(0xFFFFE7F2)],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white, width: 1.8),
        boxShadow: const [
          BoxShadow(color: Color(0x557A0A43), blurRadius: 18, offset: Offset(0, 7)),
          BoxShadow(color: Color(0xAAFFFFFF), blurRadius: 4, offset: Offset(-2, -2)),
        ],
      );
}
