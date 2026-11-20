import 'package:flutter/material.dart';

class MemberTheme {
  static const purple = Color(0xFF7B12C8);
  static const deepPurple = Color(0xFF4A087E);
  static const violet = Color(0xFFB33BFF);
  static const canvas = Color(0xFFF5EFFF);
  static const ink = Color(0xFF24102F);
  static const muted = Color(0xFF786A83);
  static const line = Color(0xFFDCC8EE);
  static const green = Color(0xFF12C83C);
  static const red = Color(0xFFE51D3B);
  static const gold = Color(0xFFFFC928);
  static const blue = Color(0xFF22B9E9);
  static const pink = Color(0xFFEC3EAE);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: canvas,
    colorScheme: ColorScheme.fromSeed(seedColor: purple, primary: purple),
    fontFamily: 'Roboto',
  );

  static BoxDecoration glass({double radius = 22, Color tint = Colors.white}) =>
    BoxDecoration(
      color: tint.withValues(alpha: .92),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: Colors.white, width: 1.7),
      boxShadow: const [
        BoxShadow(color: Color(0x337B12C8), blurRadius: 18, offset: Offset(0, 7)),
        BoxShadow(color: Color(0xBFFFFFFF), blurRadius: 4, offset: Offset(-2, -2)),
      ],
    );
}
