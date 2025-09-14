import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AppUISizes {
  //
  static const double taxiNewOrderIdleHeight = 200;
  static const double taxiNewOrderIdleHeight2 = 210;
  static const double taxiNewOrderHistoryHeight = 230;
  static const double taxiNewOrderSummaryHeight = 300;

  static double getAspectRatio(BuildContext context, int rows, double height) {
    double width = context.screenWidth / rows;
    return height / width;
  }
}
