import 'package:flutter/material.dart';

/// Tokens measured and reconstructed from the approved 691×1536 reference.
/// Keep visual material effects in reusable decorations; do not rasterize text,
/// charts, calendar dates, QR codes or interactive controls.
abstract final class ReferenceDesignTokens {
  // Core identity: glossy crimson, ruby red, metallic gold and pearl white.
  static const Color ruby950 = Color(0xFF250006);
  static const Color ruby900 = Color(0xFF3B0008);
  static const Color ruby800 = Color(0xFF65000B);
  static const Color ruby700 = Color(0xFF8F0010);
  static const Color crimson600 = Color(0xFFC81025);
  static const Color crimson500 = Color(0xFFE51B32);

  static const Color gold700 = Color(0xFFB87908);
  static const Color gold600 = Color(0xFFD99B12);
  static const Color gold500 = Color(0xFFFFC928);
  static const Color gold300 = Color(0xFFFFE58A);
  static const Color gold100 = Color(0xFFFFF4C9);

  static const Color pearl = Color(0xFFFFFBF6);
  static const Color pearlWarm = Color(0xFFFFF4E9);
  static const Color ink = Color(0xFF2B1114);
  static const Color inkMuted = Color(0xFF70585B);
  static const Color white = Colors.white;

  // Semantic attendance colors.
  static const Color present = Color(0xFF12A447);
  static const Color late = Color(0xFFFFB800);
  static const Color absent = Color(0xFFD91F32);
  static const Color holiday = Color(0xFF8A2BE2);
  static const Color neutral = Color(0xFFE8E9EC);

  static const LinearGradient pageBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ruby700, ruby900, ruby950, ruby800, ruby950],
    stops: [0, .28, .58, .82, 1],
  );

  static const LinearGradient headerBackground = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [ruby700, crimson600, ruby800, ruby950],
  );

  static const LinearGradient pearlCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [white, pearl, pearlWarm],
  );

  static const LinearGradient goldMetal = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFF4B8), gold500, gold600, gold300],
    stops: [0, .32, .72, 1],
  );

  static const LinearGradient presentCapsule = LinearGradient(
    colors: [Color(0xFF19C65A), Color(0xFF07852F)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Color(0x99000000), blurRadius: 12, offset: Offset(0, 4)),
    BoxShadow(color: Color(0x66FFC928), blurRadius: 5, spreadRadius: .4),
  ];

  static const BorderSide goldEdge = BorderSide(color: gold500, width: 1.5);
  static const BorderSide innerHighlight = BorderSide(color: Color(0xFFFFF4C9), width: 1);
  static const double cardRadius = 20;
  static const double controlRadius = 14;
  static const double sectionGap = 7;
  static const double pageInset = 8;

  static const TextStyle heading = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    height: 1.08,
    fontWeight: FontWeight.w800,
    color: ink,
  );
  static const TextStyle cardHeading = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 13,
    height: 1.05,
    fontWeight: FontWeight.w800,
    color: ink,
  );
  static const TextStyle metric = TextStyle(
    fontFamily: 'Inter',
    fontSize: 19,
    height: 1,
    fontWeight: FontWeight.w900,
    color: ink,
  );
  static const TextStyle body = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    height: 1.15,
    fontWeight: FontWeight.w600,
    color: ink,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: 'Inter',
    fontSize: 10,
    height: 1.1,
    fontWeight: FontWeight.w600,
    color: inkMuted,
  );
}
