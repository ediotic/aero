import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography. Sora for headings and numbers, DM Sans for body text.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle display(
    double size, {
    FontWeight weight = FontWeight.w700,
    Color color = AppColors.ink,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.sora(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  static TextStyle body(
    double size, {
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.ink,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.dmSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  // Named styles used across screens
  static TextStyle get screenTitle => body(17, weight: FontWeight.w700, color: Colors.white);
  static TextStyle get sectionTitle => display(19);
  static TextStyle get overline =>
      body(13, weight: FontWeight.w700, color: AppColors.muted, letterSpacing: 1);
  static TextStyle get caption => body(12, color: AppColors.muted);
  static TextStyle get cardTitle => body(15, weight: FontWeight.w700);
  static TextStyle get price => display(22, color: AppColors.primary);
  static TextStyle get link => body(14, weight: FontWeight.w700, color: AppColors.primary);
}
