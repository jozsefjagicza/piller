
import 'package:flutter/material.dart';
import 'package:piller/common/styles.dart';

import 'constants.dart';

class InputDecorations {
  static InputDecoration customInputDecoration({
    required String labelText,
    bool isSuffix = false,
    IconButton? suffixIconButton,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: AppTextStyles.bodyText,
      hintText: labelText,
      hintStyle: AppTextStyles.bodyText,
      filled: true,
      fillColor: Colors.white.withAlpha(140),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UIConstants.radius),
        borderSide: const BorderSide(
          color: Colors.black26,
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UIConstants.radius),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
          width: 0.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UIConstants.radius),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 0.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UIConstants.radius),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 0.5,
        ),
      ),
      suffixIcon: isSuffix ? suffixIconButton : null,
    );
  }
}

class BoxDecorations {
  static BoxDecoration customBoxDecoration() {
    return BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(UIConstants.radius),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    );
  }
}
