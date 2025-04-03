
import 'package:flutter/material.dart';

class FontWeights {
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight bold = FontWeight.w700;
}

class AppTextStyles {

  static const String koHoFont = "KoHo";

  static const TextStyle headline = TextStyle(fontFamily: koHoFont, fontSize: 32, fontWeight: FontWeights.bold, color: AppColors.textColor);
  static const TextStyle subtitle = TextStyle(fontFamily: koHoFont, fontSize: 20, fontWeight: FontWeights.regular, color: AppColors.textColor);
  static const TextStyle bodyText = TextStyle(fontFamily: koHoFont, fontSize: 16, fontWeight: FontWeights.light, color: AppColors.textColor);
  static const TextStyle bodyTextWhite = TextStyle(fontFamily: koHoFont, fontSize: 16, fontWeight: FontWeights.light, color: AppColors.whiteColor);
  static const TextStyle bodyTextExtraLight = TextStyle(fontFamily: koHoFont, fontSize: 16, fontWeight: FontWeights.extraLight, color: AppColors.textColor);
  static const TextStyle bodyTextWhiteExtraLight = TextStyle(fontFamily: koHoFont, fontSize: 16, fontWeight: FontWeights.extraLight, color: AppColors.whiteColor);
}

class AppColors {
  static const Color primaryColor = Color(0xFFFF695F);
  static const Color textColor = Color(0xFF2D0B0B);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFB00020);
}
