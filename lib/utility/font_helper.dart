import 'package:flutter/material.dart';

class FontHelper {
  static TextStyle getTextStyle({
    required String language,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: language == "telugu" ? "Subhadra" : null,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.5,
      color: color,
    );
  }
}
