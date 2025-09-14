import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle commonText({
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.black,
  TextDecoration decoration = TextDecoration.none,
  FontStyle fontStyle = FontStyle.normal,
  double? height
}) {
  return GoogleFonts.nunito(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    height: height,
    decoration: decoration,
    fontStyle: fontStyle,
  );
}
