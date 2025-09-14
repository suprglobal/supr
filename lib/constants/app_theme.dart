import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //
  ThemeData lightTheme() {
    return ThemeData(

      fontFamily: GoogleFonts.rubik().fontFamily,

      primaryColor: AppColors.primaryColor,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.grey,
        cursorColor: AppColors.cursorColor,
      ),
      cardColor: Colors.grey[50],
      textTheme: blackTextTheme,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white
      ),

      dialogBackgroundColor: Colors.white,
      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
      highlightColor: Colors.grey[400],
      colorScheme:  ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
        onPrimary: Colors.white,
        secondary:AppColors.secondaryColor,
        onSecondary: Colors.white,
        tertiary: Color(0xFF6AFF05),
        onTertiary: Colors.white,
        error: Color(0xFFFF003A),
        onError: Colors.white,
        surface: Color(0xffFFFFFF),
        onSurface: Colors.black,
        outline: Color(0xffE0E0E0),
        outlineVariant: Color(0xff000000),
      ),
      //
      // tabBarTheme: tabBarTheme,
      pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android : CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS : CupertinoPageTransitionsBuilder(),
          }
      ),
      useMaterial3: true,
    );
  }

  //
  ThemeData darkTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.rubik().fontFamily,
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryColorDark,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.grey,
        cursorColor: AppColors.cursorColor,
      ),
      cardColor: Colors.grey[700],
      textTheme: whiteTextTheme,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.black,
      ),
      dialogBackgroundColor: Colors.grey.shade600,
      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
      highlightColor: Colors.grey[700],
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(
            primary: AppColors.primaryColor,
        secondary:AppColors.secondaryColor,
            brightness: Brightness.dark,
          )
          .copyWith(
            primary: AppColors.primaryMaterialColor,
            surface: Colors.grey[850],
          ),

      //
      // tabBarTheme: tabBarTheme,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android : CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS : CupertinoPageTransitionsBuilder(),
        }
      ),
      useMaterial3: true,
    );
  }

  //MISC
  final TextTheme blackTextTheme = TextTheme(
    displayLarge: TextStyle(color: Colors.black),
    displayMedium: TextStyle(color: Colors.black),
    displaySmall: TextStyle(color: Colors.black),
    headlineLarge: TextStyle(color: Colors.black),
    headlineMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
    titleMedium: TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black),
    labelMedium: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
  );

  final TextTheme whiteTextTheme = TextTheme(
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    displaySmall: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
  );

  //
  TabBarTheme get tabBarTheme {
    return TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Utils.textColorByTheme(),
      unselectedLabelColor: Utils.textColorByTheme(),
      // labelColor: Utils.textColorByTheme(),
      indicator: BoxDecoration(
        // color: AppColor.primaryColor,
        border: Border(
          bottom: BorderSide(
            color: Utils.textColorByTheme(),
            width: 3,
          ),
        ),
      ),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
      ),
      tabAlignment: TabAlignment.start,
    );
  }
}
