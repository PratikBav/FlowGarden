import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get _baseFont => GoogleFonts.inter();

  static TextStyle get display => _baseFont.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w200,
        color: AppColors.charcoalBlack,
        letterSpacing: -1.0,
      );

  static TextStyle get heading => _baseFont.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w300,
        color: AppColors.charcoalBlack,
        letterSpacing: -0.5,
      );

  static TextStyle get title => _baseFont.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: AppColors.charcoalBlack,
      );

  static TextStyle get body => _baseFont.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.charcoalBlack,
        height: 1.5,
      );

  static TextStyle get caption => _baseFont.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: AppColors.charcoalBlack.withOpacity(0.6),
      );

  static TextStyle get buttonText => _baseFont.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.0,
      );
}
