import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/utils/utils.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class PickupTag extends StatelessWidget {
  const PickupTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return "Pickup"
        .tr()
        .text
        .xs
        .color(Utils.isDark(AppColors.pickupColor) ? Colors.white : Colors.black)
        .make()
        .py2()
        .px8()
        .box
        .roundedLg
        .color(AppColors.pickupColor)
        .make();
  }
}
