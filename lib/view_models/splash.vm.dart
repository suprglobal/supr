import 'dart:convert';
import 'dart:developer';

import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_routes.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/constants/app_theme.dart';
import 'package:superapp/requests/settings.request.dart';
import 'package:superapp/services/alert.service.dart';
import 'package:superapp/services/auth.service.dart';
import 'package:superapp/services/firebase.service.dart';
import 'package:superapp/services/websocket.service.dart';
import 'package:superapp/utils/utils.dart';
import 'package:superapp/widgets/cards/language_selector.view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'base.view_model.dart';

class SplashViewModel extends MyBaseViewModel {
  SplashViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  SettingsRequest settingsRequest = SettingsRequest();

  //
  initialise() async {
    super.initialise();
    await loadAppSettings();
    if (AuthServices.authenticated()) {
      await AuthServices.getCurrentUser(force: true);
    }
  }

  //

  //
  loadAppSettings() async {
    setBusy(true);
    try {
      final appSettingsObject = await settingsRequest.appSettings();
      //START: WEBSOCKET SETTINGS
      if (appSettingsObject.body["websocket"] != null) {
        await WebsocketService().saveWebsocketDetails(
          appSettingsObject.body["websocket"],
        );
      }
      //END: WEBSOCKET SETTINGS

      Map<String, dynamic> appGenSettings = appSettingsObject.body["strings"];
      //set the app name ffrom package to the app settings
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appName = packageInfo.appName;
      appGenSettings["app_name"] = appName;
      //app settings
      await updateAppVariables(appGenSettings);
      //colors
      await updateAppTheme(appSettingsObject.body["colors"]);
      loadNextPage();
    } catch (error) {
      setError(error);
      print("Error loading app settings ==> $error");
      //show a dialog
      AlertService.error(
        title: "An error occurred".tr(),
        text: "$error",
        confirmBtnText: "Retry".tr(),
        onConfirm: () {
          initialise();
        },
      );
    }
    setBusy(false);
  }

  //
  updateAppVariables(dynamic json) async {
    //
    await AppStrings.saveAppSettingsToLocalStorage(jsonEncode(json));
  }

  //theme change
  updateAppTheme(dynamic colorJson) async {
    //
    await AppColors.saveColorsToLocalStorage(jsonEncode(colorJson));
    //change theme
    // await AdaptiveTheme.of(viewContext).reset();
    AdaptiveTheme.of(viewContext).setTheme(
      light: AppTheme().lightTheme(),
      dark: AppTheme().darkTheme(),
      notify: true,
    );
    await AdaptiveTheme.of(viewContext).persist();
  }

  //
  loadNextPage() async {
    //
    await Utils.setJiffyLocale();
    //
    // if (AuthServices.firstTimeOnApp()) {
    //   //choose language
    //   await Navigator.of(
    //     viewContext,
    //   ).push(MaterialPageRoute(builder: (ctx) => AppLanguageSelector()));
    //   // await showModalBottomSheet(
    //   //   context: viewContext,
    //   //   isScrollControlled: true,
    //   //   builder: (context) {
    //   //     return AppLanguageSelector();
    //   //   },
    //   // );
    // }
    //
    // if (AuthServices.firstTimeOnApp()) {
    //   Navigator.of(viewContext).pushNamedAndRemoveUntil(
    //     AppRoutes.welcomeRoute,
    //     (Route<dynamic> route) => false,
    //   );
    // } else {
    //   Navigator.of(viewContext).pushNamedAndRemoveUntil(
    //     AppRoutes.homeRoute,
    //     (Route<dynamic> route) => false,
    //   );
    // }
    Navigator.of(viewContext).pushNamedAndRemoveUntil(
      AppRoutes.homeRoute,
          (Route<dynamic> route) => false,
    );
    //
    RemoteMessage? initialMessage =
        await FirebaseService().firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      //
      FirebaseService().saveNewNotification(initialMessage);
      FirebaseService().notificationPayloadData = initialMessage.data;
      FirebaseService().selectNotification("");
    }
  }
}
