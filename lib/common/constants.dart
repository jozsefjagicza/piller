

import 'package:flutter/material.dart';
import 'package:piller/common/styles.dart';

class FontWeights {
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight bold = FontWeight.w700;
}

class AppColors {
  static const Color primaryColor = Color(0xFFFF695F);
  static const Color textColor = Color(0xFF2D0B0B);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFB00020);
}

class UIConstants {
  static const double defaultPadding = 16.0;
  static const double largePadding = 32.0;
  static const double radius = 12.0;

}

class InputDecorations {
  static InputDecoration customInputDecoration({required String labelText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: AppTextStyles.bodyText,
      hintText: labelText,
      hintStyle: AppTextStyles.bodyText,
      filled: true,
      fillColor: Colors.white.withAlpha(140),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(
          color: Colors.black26,
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
          width: 0.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 0.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 0.5,
        ),
      ),
    );
  }
}

