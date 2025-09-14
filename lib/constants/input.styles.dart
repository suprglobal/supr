import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class InputStyles {
  //get the border for the textform field
  static InputBorder inputEnabledBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.primaryColor
      ),
      borderRadius: BorderRadius.circular(15),
    );
  }

  //get the border for the textform field
  static InputBorder inputFocusBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.primaryColorDark,
      ),
      borderRadius: BorderRadius.circular(15),
    );
  }


  //
  //get the border for the textform field
  static InputBorder inputUnderlineEnabledBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(15),
    );
  }

  //get the border for the textform field
  static InputBorder inputUnderlineFocusBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.primaryColorDark,
      ),
      borderRadius: BorderRadius.circular(15),
    );
  }
}
