import 'package:flutter/material.dart';

class AppColors {
  // ──────────────── PRIMARY PALETTE ────────────────
  static const Color color1 = Color(0xFF1F1B3B);
  static const Color color2 = Color(0xFF3E2960);
  static const Color color3 = Color(0xFF704B91);
  static const Color color4 = Color(0xFFA65E9E);
  static const Color color5 = Color(0xFFE6C6D4);
  static const Color color6 = Color(0xFFDA6FD1);

  // ──────────────── DARK GREY PALETTE ────────────────
  static const Color darkGrey1 = Color(0xFF000000);
  static const Color darkGrey2 = Color(0xFF1C1C1C);
  static const Color darkGrey3 = Color(0xFF4D4D4D);
  static const Color darkGrey4 = Color(0xFF737373);
  static const Color darkGrey5 = Color(0xFFA6A6A6);
  static const Color darkGrey6 = Color(0xFFFFFFFF);

  // ──────────────── OPTIONAL GRADIENTS ────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [color2, color4],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [color1, color3],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient darkGreyGradient = LinearGradient(
    colors: [darkGrey2, darkGrey4],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // theme_colors.dart

  static const kPrimaryColor = Colors.deepPurple;
  static const kSecondaryColor = Colors.tealAccent;

// Backgrounds
  static const kLightBackground = Color(0xFFF5F5F5);
  static const kDarkBackground = Colors.black;

// Surfaces (Cards, Sheets)
  static const kLightSurface = Colors.white;
  static final kDarkSurface = Colors.grey[900];

// Text colors
  static const kLightText = Colors.black87;
  static const kDarkText = Colors.white;

}
