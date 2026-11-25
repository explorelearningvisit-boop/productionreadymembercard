import 'package:flutter/material.dart';

class MemberTheme {
  static const canvas = Color(0xFFF4F0FA);
  static const purple = Color(0xFF6D28D9);
  static const deepPurple = Color(0xFF32105D);
  static const violet = Color(0xFF9B5DE5);
  static const gold = Color(0xFFFFD166);
  static const green = Color(0xFF168A4A);
  static const red = Color(0xFFB42318);
  static const ink = Color(0xFF241B2F);
  static const muted = Color(0xFF746B80);
  static const line = Color(0xFFE8E1EF);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(seedColor: purple).copyWith(
          primary: purple,
          surface: Colors.white,
        ),
      );
}
