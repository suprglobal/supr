import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/services/app.service.dart';
import 'package:superapp/services/local_storage.service.dart';
import 'package:velocity_x/velocity_x.dart';

class AppColors {
  // static Color get accentColor => Vx.hexToColor(colorEnv('accentColor'));
  static Color get primaryColor => Color(0xff00493E);
  static Color get secondaryColor => Color(0xFF00E784);
  static Color get primaryColorDark =>
      Vx.hexToColor(colorEnv('primaryColorDark'));
  static Color get cursorColor => accentColor;

  //material color
  static MaterialColor get accentMaterialColor => MaterialColor(
        Vx.getColorFromHex(colorEnv('accentColor')),
        <int, Color>{
          50: Vx.hexToColor(colorEnv('accentColor')),
          100: Vx.hexToColor(colorEnv('accentColor')),
          200: Vx.hexToColor(colorEnv('accentColor')),
          300: Vx.hexToColor(colorEnv('accentColor')),
          400: Vx.hexToColor(colorEnv('accentColor')),
          500: Vx.hexToColor(colorEnv('accentColor')),
          600: Vx.hexToColor(colorEnv('accentColor')),
          700: Vx.hexToColor(colorEnv('accentColor')),
          800: Vx.hexToColor(colorEnv('accentColor')),
          900: Vx.hexToColor(colorEnv('accentColor')),
        },
      );
  static MaterialColor get primaryMaterialColor => MaterialColor(
        Vx.getColorFromHex(colorEnv('primaryColor')),
        <int, Color>{
          50: Vx.hexToColor(colorEnv('primaryColor')),
          100: Vx.hexToColor(colorEnv('primaryColor')),
          200: Vx.hexToColor(colorEnv('primaryColor')),
          300: Vx.hexToColor(colorEnv('primaryColor')),
          400: Vx.hexToColor(colorEnv('primaryColor')),
          500: Vx.hexToColor(colorEnv('primaryColor')),
          600: Vx.hexToColor(colorEnv('primaryColor')),
          700: Vx.hexToColor(colorEnv('primaryColor')),
          800: Vx.hexToColor(colorEnv('primaryColor')),
          900: Vx.hexToColor(colorEnv('primaryColor')),
        },
      );
  static Color get primaryMaterialColorDark =>
      Vx.hexToColor(colorEnv('primaryColorDark'));
  static Color get cursorMaterialColor => accentColor;

  //onboarding colors
  static Color get onboarding1Color =>
      Vx.hexToColor(colorEnv('onboarding1Color'));
  static Color get onboarding2Color =>
      Vx.hexToColor(colorEnv('onboarding2Color'));
  static Color get onboarding3Color =>
      Vx.hexToColor(colorEnv('onboarding3Color'));

  static Color get onboardingIndicatorDotColor =>
      Vx.hexToColor(colorEnv('onboardingIndicatorDotColor'));
  static Color get onboardingIndicatorActiveDotColor =>
      Vx.hexToColor(colorEnv('onboardingIndicatorActiveDotColor'));

  //Shimmer Colors
  static Color shimmerBaseColor = Colors.grey.shade300;
  static Color shimmerHighlightColor = Colors.grey.shade200;

  //inputs
  static Color get inputFillColor => Colors.grey[200]!;
  static Color get iconHintColor => Colors.grey[500]!;

  static Color get openColor => Vx.hexToColor(colorEnv('openColor'));
  static Color get closeColor => Vx.hexToColor(colorEnv('closeColor'));
  static Color get deliveryColor => Vx.hexToColor(colorEnv('deliveryColor'));
  static Color get pickupColor => Vx.hexToColor(colorEnv('pickupColor'));
  static Color get ratingColor => Vx.hexToColor(colorEnv('ratingColor'));

  //
  static Color get faintBgColor {
    try {
      final isLightMode =
          AppService().navigatorKey.currentContext?.brightness ==
              Brightness.light;
      return isLightMode ? Vx.hexToColor("#FDFAF6") : Vx.hexToColor("#212121");
    } catch (error) {
      return Colors.white;
    }
  }

  static Color getStausColor(String status) {
    //'pending','preparing','enroute','failed','cancelled','delivered'
    final statusColorName = "${status}Color";
    try {
      return Vx.hexToColor(colorEnv(statusColorName));
    } catch (error) {
      return Vx.hexToColor(colorEnv('pendingColor'));
    }
  }

  //saving
  static Future<bool> saveColorsToLocalStorage(String colorsMap) async {
    return await LocalStorageService.prefs!
        .setString(AppStrings.appColors, colorsMap);
  }

  static dynamic appColorsObject;
  static Future<void> getColorsFromLocalStorage() async {
    appColorsObject =
        LocalStorageService.prefs!.getString(AppStrings.appColors);
    if (appColorsObject != null) {
      appColorsObject = jsonDecode(appColorsObject);
    }
  }

  static String colorEnv(String colorRef) {
    //
    getColorsFromLocalStorage();
    //
    String? selectedColor =
        appColorsObject != null ? appColorsObject[colorRef] : "#000000";
    if (selectedColor == null) {
      selectedColor = "#000000";
    }
    return selectedColor;
  }



  static const appGreen = Color(0xff009743);
  static const lightGreen = Color(0xff00E27F);
  static const darkGreen = Color(0xff00493E);
  static const hardGreen = Color(0xff00342C);
  static const appGrey = Color(0xffE0E1DC);
  static const stickerGrey = Color(0xffF7F7F7);
  static const lightYellow = Color(0xffFFF2CC);
  static const lightGrey = Color(0xffA1A1A1);
  static const containerGrey = Color(0xffE8E8E8);
  static const containerYellow = Color(0xffFFFBE7);
  static const appOrange = Color(0xffFF9A00);
  static const appLightOrange = Color(0xffFFF7EB);
  static const backgroundGrey = Color(0xffEAEAEA);
  static const textGrey = Color(0xff565656);
  static const darkGrey = Color(0xff808080);
  static const darkTextGrey = Color(0xff5A5A5A);
  static const colorGreen = Color(0xff6AFF05);
  static const greenishTextColor = Color(0xff249738);
  static const yelloeTextColor = Color(0xffFFC700);
  static const gradientYellowColorlight = Color(0xffFDDEA7);
  static const gradientYellowColordark = Color(0xffFAB53C);
  static const redColor = Color(0xffBB2E2E);
  static const accentColor = Color(0xffF1C623);
  static const darkGreens = Color(0xff00342C);

  static const azure = Color(0xFF0192FF); // Azure used for highlights
  static const aqua = Color(0xFF00FFF9);
  static const brightGreen = Color(0xFF6AFF05);
  static const yellowRose = Color(0xFFFFF000);
  static const chromeYellow = Color(0xFFFFAA02);
  static const carmineRed = Color(0xFFFF003A);

  static const blackGrey = Color(0xff242424);
  static const bluish = Color(0xffA6E7CF);

  static const serviceCardColor = Color(0xffF4F7F9);
}
