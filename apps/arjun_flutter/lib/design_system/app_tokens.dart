import 'package:flutter/material.dart';

abstract final class AppTokens {
  static const worker = Color(0xFF087F5B);
  static const workerDeep = Color(0xFF064638);
  static const workerSoft = Color(0xFFE2F7EE);
  static const provider = Color(0xFF6C35C8);
  static const providerDeep = Color(0xFF32106D);
  static const providerSoft = Color(0xFFF0E8FF);
  static const warning = Color(0xFFFFB52E);
  static const danger = Color(0xFFB42318);
  static const success = Color(0xFF16794B);
  static const ink = Color(0xFF182342);
  static const muted = Color(0xFF64748B);
  static const canvas = Color(0xFFF5F0FF);
  static const surface = Colors.white;
  static const radiusSmall = 12.0;
  static const radiusCard = 18.0;
  static const radiusLarge = 24.0;
  static const minTouchTarget = 48.0;
  static const primaryTouchTarget = 56.0;
}

ThemeData buildMarketplaceTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppTokens.provider,
    surface: AppTokens.surface,
    error: AppTokens.danger,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppTokens.canvas,
    visualDensity: VisualDensity.standard,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTokens.canvas,
      foregroundColor: AppTokens.ink,
      centerTitle: false,
      elevation: 0,
      toolbarHeight: 56,
    ),
    cardTheme: CardThemeData(
      color: AppTokens.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTokens.radiusCard),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppTokens.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      height: 68,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      indicatorColor: AppTokens.providerSoft,
    ),
  );
}
