import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/models/vendor.dart';
import 'package:superapp/services/app.service.dart';
import 'package:superapp/services/http.service.dart';
import 'package:superapp/services/location.service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jiffy/jiffy.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class Utils {
  // static bool get isArabic => AppService().navigatorKey.currentContext!.languageCode == "ar";
  static bool get isArabic => translator.activeLocale.languageCode == "ar";

  static TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;

  static bool get currencyLeftSided {
    final uiConfig = AppStrings.uiConfig;
    if (uiConfig != null && uiConfig["currency"] != null) {
      final currencylOCATION = uiConfig["currency"]["location"] ?? 'left';
      return currencylOCATION.toLowerCase() == "left";
    } else {
      return true;
    }
  }

  static bool isDark(Color color) {
    return ColorUtils.calculateRelativeLuminance(
          color.red,
          color.green,
          color.blue,
        ) <
        0.5;
  }

  static bool isPrimaryColorDark([Color? mColor]) {
    final color = mColor ?? AppColors.primaryColor;
    return ColorUtils.calculateRelativeLuminance(
          color.red,
          color.green,
          color.blue,
        ) <
        0.5;
  }

  static Color textColorByTheme([bool reversed = false]) {
    if (reversed) {
      return !isPrimaryColorDark() ? Colors.white : Colors.black;
    }
    return isPrimaryColorDark() ? Colors.white : Colors.black;
  }

  static Color textColorByBrightness([
    BuildContext? context,
    bool reversed = false,
  ])
  {
    context ??= AppService().navigatorKey.currentContext;
    if (reversed) {
      return !context!.isDarkMode ? Colors.white : Colors.black;
    }
    return context!.isDarkMode ? Colors.white : Colors.black;
  }

  static Color textColorByColor(Color color) {
    return isPrimaryColorDark(color) ? Colors.white : Colors.black;
  }

  static Color textColorByPrimaryColor() {
    return isPrimaryColorDark() ? Colors.white : Colors.black;
  }

  static Color greayColorByBrightness([BuildContext? context]) {
    context ??= AppService().navigatorKey.currentContext;
    return context!.isDarkMode ? Colors.grey[300]! : Colors.grey[400]!;
  }

  static Color systemGreyColor([bool reversed = false]) {
    BuildContext context = AppService().navigatorKey.currentContext!;
    bool isDark = context.isDarkMode;
    if (reversed) {
      isDark = !isDark;
    }
    return isDark ? Colors.grey.shade800 : Colors.grey.shade100;
  }

  static Color get primaryOrTheme {
    BuildContext context = AppService().navigatorKey.currentContext!;
    bool isDark = context.isDarkMode;
    return isDark ? context.textTheme.bodyLarge!.color! : AppColors.primaryColor;
  }

  static setJiffyLocale() async {
    // String cLocale = AppService().navigatorKey.currentContext!.languageCode;
    String cLocale =  translator.activeLocale.languageCode;
    List<String> supportedLocales = Jiffy.getSupportedLocales();
    if (supportedLocales.contains(cLocale)) {
      await Jiffy.setLocale( translator.activeLocale.languageCode);
    } else {
      await Jiffy.setLocale("en");
    }
  }

  static Future<File?> compressFile({
    required File file,
    String? targetPath,
    int quality = 40,
    CompressMode format = CompressMode.AUTO,
  }) async {
    if (targetPath == null) {
      targetPath =
          "${file.parent.path}/compressed_${file.path.split('/').last}";
    }

    if (kDebugMode) {
      print("file path ==> $targetPath");
    }

    CompressObject compressObject = CompressObject(
      imageFile: file, //image
      targetPath: targetPath, //compress to path
      quality: quality, //first compress quality, default 80
      //compress quality step, The bigger the fast, Smaller is more accurate, default 6
      step: 5,
      mode: CompressMode.LARGE2SMALL, //default AUTO
    );
    final compressFilePath = await Luban.compressImage(compressObject);

    if (kDebugMode) {
      print("unCompress file size ==> ${file.lengthSync()}");
      if (compressFilePath != null) {
        print("Compress successful");
      } else {
        print("compress failed");
      }
    }

    if (compressFilePath != null) {
      try {
        return File.fromUri(Uri(path: compressFilePath));
      } catch (error) {
        return File(compressFilePath);
      }
    }

    return null;
  }

  static bool isDefaultImg(String? url) {
    return url == null ||
        url.isEmpty ||
        url == "default.png" ||
        url == "default.jpg" ||
        url == "default.jpeg" ||
        url.contains("default.png");
  }

  //get vendor distance to current location
  static double vendorDistance(Vendor vendor) {
    if (vendor.latitude.isEmptyOrNull || vendor.longitude.isEmptyOrNull) {
      return 0;
    }

    //if location service current location is not available
    if (LocationService.currenctAddress == null) {
      return 0;
    }

    //get distance
    double distance = Geolocator.distanceBetween(
      LocationService.currenctAddress?.coordinates?.latitude ?? 0,
      LocationService.currenctAddress?.coordinates?.longitude ?? 0,
      double.parse(vendor.latitude),
      double.parse(vendor.longitude),
    );

    //convert distance to km
    distance = distance / 1000;
    return distance;
  }

  //
  //get country code
  static Future<String> getCurrentCountryCode() async {
    String countryCode = "US";
    try {
      //make request to get country code
      final response = await HttpService().dio!.get(
        "http://ip-api.com/json/?fields=countryCode",
        //timeout like 2seconds
        options: Options(receiveTimeout: 5.seconds, sendTimeout: 2.seconds),
      );
      //get the country code
      countryCode = response.data["countryCode"];
    } catch (e) {
      try {
        countryCode =
            AppStrings.countryCode
                .toUpperCase()
                .replaceAll("AUTO", "")
                .replaceAll("INTERNATIONAL", "")
                .split(",")[0];
      } catch (e) {
        countryCode = "us";
      }
    }

    return countryCode.toUpperCase();
  }
}
