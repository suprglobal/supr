// // Define your app-wide constants like colors, typography, sizes, etc.
// const String appName = "Task Buddy";
// const double padding = 16.0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String twillioNumber = '+14155238886';


class Dimensions {

  static const double homePagePadding = 14.0;
}


class AppConstants {
  static BoxShadow boxShadow = BoxShadow(
    color: Colors.grey.withValues(alpha: 0.2),
    spreadRadius: 2,
    blurRadius: 5,
    offset: const Offset(0, 3),
  );
}