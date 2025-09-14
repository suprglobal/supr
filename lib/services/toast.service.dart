import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import 'package:superapp/services/alert.service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
// class ToastService {
//   //
//   //show toast
//   static toastSuccessful(String msg, {String? title}) {
//     try {
//       AlertController.show(
//         title ?? "Successful".tr(),
//         msg,
//         TypeAlert.success,
//       );
//     } catch (error) {
//       AlertService.success(
//         title: title ?? "Successful".tr(),
//         text: msg,
//       );
//     }
//   }
//
//   static toastError(String msg, {String? title}) {
//     try {
//       AlertController.show(
//         title ?? "Error".tr(),
//         msg,
//         TypeAlert.error,
//       );
//     } catch (error) {
//       AlertService.error(
//         title: title ?? "Error".tr(),
//         text: msg,
//       );
//     }
//   }
// }




import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:get/get.dart';

class ToastService {
  static bool _isSnackbarVisible = false;

  static void _show(String msg, AnimatedSnackBarType type) {
    if (_isSnackbarVisible) return;

    _isSnackbarVisible = true;

    AnimatedSnackBar.material(
      msg,
      type: type,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: const Duration(seconds: 3),
    ).show(Get.context!);
    Future.delayed(const Duration(seconds: 3), () {
      _isSnackbarVisible = false;
    });
  }

  static void toastSuccessful(String msg) => _show(msg, AnimatedSnackBarType.success);

  static void toastError(String msg) => _show(msg, AnimatedSnackBarType.error);

  static void toastInfo(String msg) => _show(msg, AnimatedSnackBarType.info);

  static void toastWarning(String msg) => _show(msg, AnimatedSnackBarType.warning);
}
