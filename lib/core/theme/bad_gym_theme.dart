import 'package:flutter/material.dart';

abstract final class BadGymColors {
  // --- PRIMARY RED STRAWBERRY THEME ---
  static const Color primary =
      Color(0xFFE50914); // #E50914 Primary Strawberry Red
  static const Color primaryDark = Color(0xFF99000C);
  static const Color primaryDeep = Color(0xFF6B000B);
  static const Color secondary =
      Color(0xFFFF4D6D); // #FF4D6D Strawberry Pink / Coral
  static const Color secondaryLight = Color(0xFFFF758F);

  // Status & Accents
  static const Color accentSuccess =
      Color(0xFF00C853); // Emerald Green (Active, Present, Check-in)
  static const Color successGlow = Color(0x6600C853);
  static const Color warning =
      Color(0xFFFFB300); // Amber Gold (Late, Gold Plan)
  static const Color danger =
      Color(0xFFE50914); // Bright Coral Red (Absent, Due)
  static const Color infoHoliday =
      Color(0xFFAA00FF); // Electric Purple (Holiday)
  static const Color cyanBody = Color(0xFF00B4D8); // Cyan (Body stat)
  static const Color purpleWorkout = Color(0xFF8E24AA); // Purple (Workout stat)

  // Background Gradient & Card Glass
  static const Color bgGradientStart = Color(0xFFFFE8ED); // Soft Rosy Red Cream
  static const Color bgGradientEnd = Color(0xFFFFFFFF); // Pure White
  static const Color cardGlass = Color(0xB3FFFFFF); // rgba(255, 255, 255, 0.70)
  static const Color cardGlassSolid = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0x33FF4D6D);
  static const Color cardShadow = Color(0x22E50914);

  // Header Card
  static const Color headerCardStart = Color(0xFFBA0018);
  static const Color headerCardMid = Color(0xFF8E0010);
  static const Color headerCardEnd = Color(0xFF5A0008);
  static const Color headerInnerCard = Color(0xFFFFFFFF);

  // Vertical Navigation Rail
  static const Color railDarkStart = Color(0xFF5E000D);
  static const Color railDarkEnd = Color(0xFF380007);
  static const Color railBorder = Color(0x44FF4D6D);
  static const Color railActiveItem = Color(0xFFE50914);
  static const Color railActiveBorder = Color(0xFFFF859B);

  // Quick Stat Cards Glass Gradients
  static const Color statAttendanceStart = Color(0xFFFFF0F3);
  static const Color statAttendanceEnd = Color(0xFFFFE5E9);
  static const Color statWorkoutStart = Color(0xFFF7F3FE);
  static const Color statWorkoutEnd = Color(0xFFECE3FC);
  static const Color statPaymentStart = Color(0xFFFFFDF5);
  static const Color statPaymentEnd = Color(0xFFFFF6D8);
  static const Color statBodyStart = Color(0xFFF0F9FF);
  static const Color statBodyEnd = Color(0xFFDCF2FD);

  // Typography & Inks
  static const Color inkDark = Color(0xFF1E080C);
  static const Color inkNavy = Color(0xFF1E080C);
  static const Color inkPrimary = Color(0xFF261014);
  static const Color inkSecondary = Color(0xFF5A484C);
  static const Color inkMuted = Color(0xFF8C7B7F);
  static const Color inkLight = Color(0xFFFFAEC0);
  static const Color inkWhite = Colors.white;

  // Calendar Day Chips
  static const Color chipGrey = Color(0xFFE6E8EC);
  static const Color chipGreyText = Color(0xFF6B7280);
  static const Color chipGreen = Color(0xFF00C853);
  static const Color chipYellow = Color(0xFFFFB300);
  static const Color chipRed = Color(0xFFE50914);
  static const Color chipPurple = Color(0xFFAA00FF);

  // Backward-compatible aliases for other screens & legacy widgets
  static const Color background = Color(0xFFFFE8EE);
  static const Color surfaceWhite = Colors.white;
  static const Color surfaceSoft = Color(0xFFFFF0F3);
  static const Color borderSubtle = Color(0xFFFFCCD5);
  static const Color darkRail = Color(0xFF5A0510);
  static const Color darkRailDivider = Color(0xFF7A0716);
  static const Color darkCardStart = Color(0xFFE50914);
  static const Color darkCardMid = Color(0xFFD00813);
  static const Color darkCardEnd = Color(0xFF8E040D);
  static const Color purpleDark = Color(0xFF350208);
  static const Color purpleRail = Color(0xFF5A0510);
  static const Color purpleRailDivider = Color(0xFF7A0716);
  static const Color purpleCardStart = Color(0xFFE50914);
  static const Color purpleCardMid = Color(0xFFD00813);
  static const Color purpleCardEnd = Color(0xFF8E040D);
  static const Color purpleInnerGlass = Color(0xFF5A0510);
  static const Color neonViolet = Color(0xFFE50914);
  static const Color neonVioletGlow = Color(0x66E50914);
  static const Color neonVioletBorder = Color(0xFFFF758F);
  static const Color neonLime = Color(0xFF16C964);
  static const Color neonLimeGlow = Color(0xFF6BFFAC);
  static const Color emerald = Color(0xFF16C964);
  static const Color emeraldActive = Color(0xFF16C964);
  static const Color limeProgressStart = Color(0xFFFF4D6D);
  static const Color limeProgressEnd = Color(0xFFE50914);
  static const Color gold = Color(0xFFFFC107);
  static const Color goldDark = Color(0xFFD97706);
  static const Color yellowLate = Color(0xFFFFC107);
  static const Color redAbsent = Color(0xFFFF3830);
  static const Color purpleHoliday = Color(0xFF8A2BE2);
  static const Color coralPrimary = Color(0xFFE50914);
  static const Color inkLavender = Color(0xFFFFCCD5);
}

abstract final class BadGymTypography {
  static const String fontHeading = 'Poppins';
  static const String fontBody = 'Inter';

  static TextStyle titleLarge = const TextStyle(
    fontFamily: fontHeading,
    fontWeight: FontWeight.w900,
    fontSize: 18,
    color: BadGymColors.inkNavy,
    letterSpacing: 0.3,
  );

  static TextStyle titleMedium = const TextStyle(
    fontFamily: fontHeading,
    fontWeight: FontWeight.w800,
    fontSize: 14.5,
    color: BadGymColors.inkPrimary,
  );

  static TextStyle cardTitle = const TextStyle(
    fontFamily: fontHeading,
    fontWeight: FontWeight.w700,
    fontSize: 14.5,
    color: Colors.white,
  );

  static TextStyle bodySmall = const TextStyle(
    fontFamily: fontBody,
    fontWeight: FontWeight.w500,
    fontSize: 10,
    color: BadGymColors.inkMuted,
  );

  static TextStyle caption = const TextStyle(
    fontFamily: fontBody,
    fontWeight: FontWeight.w600,
    fontSize: 9,
    color: BadGymColors.inkLight,
  );
}
