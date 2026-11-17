import 'package:flutter/material.dart';

abstract final class BadGymColors {
  // --- ICE BLUE GLASS THEME ---
  static const Color primary =
      Color(0xFF2187D5); // #E50914 Primary Strawberry Red
  static const Color primaryDark = Color(0xFF1767AC);
  static const Color primaryDeep = Color(0xFF124F83);
  static const Color secondary =
      Color(0xFF63B8EA); // #FF4D6D Strawberry Pink / Coral
  static const Color secondaryLight = Color(0xFF8CCBF2);

  // Status & Accents
  static const Color accentSuccess =
      Color(0xFF00C853); // Emerald Green (Active, Present, Check-in)
  static const Color successGlow = Color(0x6600C853);
  static const Color warning =
      Color(0xFFFFB300); // Amber Gold (Late, Gold Plan)
  static const Color danger =
      Color(0xFFD9485B); // Semantic red (Absent, Due)
  static const Color infoHoliday =
      Color(0xFF8AAFC7); // Electric Purple (Holiday)
  static const Color cyanBody = Color(0xFF00B4D8); // Cyan (Body stat)
  static const Color purpleWorkout = Color(0xFF8E24AA); // Purple (Workout stat)

  // Background Gradient & Card Glass
  static const Color bgGradientStart = Color(0xFFEAF5FF); // Soft Rosy Red Cream
  static const Color bgGradientEnd = Color(0xFFFFFFFF); // Pure White
  static const Color cardGlass = Color(0xB3FFFFFF); // rgba(255, 255, 255, 0.70)
  static const Color cardGlassSolid = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0x66A8D2F2);
  static const Color cardShadow = Color(0x222187D5);

  // Header Card
  static const Color headerCardStart = Color(0xFFD9EEFF);
  static const Color headerCardMid = Color(0xFFC8E5FC);
  static const Color headerCardEnd = Color(0xFFB8DDF8);
  static const Color headerInnerCard = Color(0xFFFFFFFF);

  // Vertical Navigation Rail
  static const Color railDarkStart = Color(0xFFD8ECFC);
  static const Color railDarkEnd = Color(0xFFC3E2FA);
  static const Color railBorder = Color(0x88A8D2F2);
  static const Color railActiveItem = Color(0xFF2187D5);
  static const Color railActiveBorder = Color(0xFF2187D5);

  // Quick Stat Cards Glass Gradients
  static const Color statAttendanceStart = Color(0xFFF1F8FF);
  static const Color statAttendanceEnd = Color(0xFFE3F1FF);
  static const Color statWorkoutStart = Color(0xFFEDF6FF);
  static const Color statWorkoutEnd = Color(0xFFDCEEFF);
  static const Color statPaymentStart = Color(0xFFF5FAFF);
  static const Color statPaymentEnd = Color(0xFFEAF5FF);
  static const Color statBodyStart = Color(0xFFEAF7FF);
  static const Color statBodyEnd = Color(0xFFD5ECFF);

  // Typography & Inks
  static const Color inkDark = Color(0xFF183354);
  static const Color inkNavy = Color(0xFF183354);
  static const Color inkPrimary = Color(0xFF23496F);
  static const Color inkSecondary = Color(0xFF58738D);
  static const Color inkMuted = Color(0xFF7892A9);
  static const Color inkLight = Color(0xFF7892A9);
  static const Color inkWhite = Colors.white;

  // Calendar Day Chips
  static const Color chipGrey = Color(0xFFE6E8EC);
  static const Color chipGreyText = Color(0xFF6B7280);
  static const Color chipGreen = Color(0xFF00C853);
  static const Color chipYellow = Color(0xFFFFB300);
  static const Color chipRed = Color(0xFFD9485B);
  static const Color chipPurple = Color(0xFF8AAFC7);

  // Backward-compatible aliases for other screens & legacy widgets
  static const Color background = Color(0xFFEAF5FF);
  static const Color surfaceWhite = Colors.white;
  static const Color surfaceSoft = Color(0xFFF1F8FF);
  static const Color borderSubtle = Color(0xFFA8D2F2);
  static const Color darkRail = Color(0xFFD5EBFC);
  static const Color darkRailDivider = Color(0xFFB8DDF8);
  static const Color darkCardStart = Color(0xFF2187D5);
  static const Color darkCardMid = Color(0xFF3C9AE0);
  static const Color darkCardEnd = Color(0xFF1767AC);
  static const Color purpleDark = Color(0xFFB8DDF8);
  static const Color purpleRail = Color(0xFFD5EBFC);
  static const Color purpleRailDivider = Color(0xFFB8DDF8);
  static const Color purpleCardStart = Color(0xFF2187D5);
  static const Color purpleCardMid = Color(0xFF3C9AE0);
  static const Color purpleCardEnd = Color(0xFF1767AC);
  static const Color purpleInnerGlass = Color(0xFFD5EBFC);
  static const Color neonViolet = Color(0xFF2187D5);
  static const Color neonVioletGlow = Color(0x66E50914);
  static const Color neonVioletBorder = Color(0xFF8CCBF2);
  static const Color neonLime = Color(0xFF159B62);
  static const Color neonLimeGlow = Color(0xFF6BFFAC);
  static const Color emerald = Color(0xFF159B62);
  static const Color emeraldActive = Color(0xFF159B62);
  static const Color limeProgressStart = Color(0xFF63B8EA);
  static const Color limeProgressEnd = Color(0xFF2187D5);
  static const Color gold = Color(0xFFEFB52C);
  static const Color goldDark = Color(0xFFB98217);
  static const Color yellowLate = Color(0xFFEFB52C);
  static const Color redAbsent = Color(0xFFD9485B);
  static const Color purpleHoliday = Color(0xFF8AAFC7);
  static const Color coralPrimary = Color(0xFF2187D5);
  static const Color inkLavender = Color(0xFFA8D2F2);
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
