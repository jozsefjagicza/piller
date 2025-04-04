
import 'package:flutter/material.dart';
import 'constants.dart';

class AppTextStyles {

  static const String koHoFont = "KoHo";

  static const TextStyle headline = TextStyle(fontFamily: koHoFont, fontSize: 32, fontWeight: FontWeights.bold, color: AppColors.textColor);
  static const TextStyle subtitle = TextStyle(fontFamily: koHoFont, fontSize: 20, fontWeight: FontWeights.regular, color: AppColors.textColor);
  static const TextStyle bodyText = TextStyle(fontFamily: koHoFont, fontSize: 14, fontWeight: FontWeights.light, color: AppColors.textColor);
  static const TextStyle bodyTextWhite = TextStyle(fontFamily: koHoFont, fontSize: 16, fontWeight: FontWeights.light, color: AppColors.whiteColor);
  static const TextStyle buttonTitle = TextStyle(fontFamily: koHoFont, fontSize: 20, fontWeight: FontWeights.bold, color: Colors.white);
  static const TextStyle itemTitle = TextStyle(fontFamily: koHoFont, fontSize: 16, fontWeight: FontWeights.bold, color: AppColors.textColor);
  static const TextStyle bodyTextExtraLight = TextStyle(fontFamily: koHoFont, fontSize: 16, fontWeight: FontWeights.extraLight, color: AppColors.textColor);
  static const TextStyle bodyTextWhiteExtraLight = TextStyle(fontFamily: koHoFont, fontSize: 16, fontWeight: FontWeights.extraLight, color: AppColors.whiteColor);
}

class AppButtonStyles {
  static final ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: Colors.white,
    textStyle: AppTextStyles.buttonTitle,
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: UIConstants.defaultPadding),
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(UIConstants.radius)),
  );

  static final ButtonStyle secondary = OutlinedButton.styleFrom(
    foregroundColor: Colors.blue,
    side: const BorderSide(color: Colors.blue, width: 2),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  static final ButtonStyle danger = ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}
