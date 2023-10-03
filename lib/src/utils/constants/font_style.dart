import 'package:flutter/material.dart';
import 'package:assam_police_vdp/src/utils/constants/strings.dart';

import 'colors.dart';

Function openSansNormalWhite20 = () => _sofiaPro(white, 23, FontWeight.w400);

TextStyle openSansNormalWhite23() => _sofiaPro(black, 20, FontWeight.w500);

// TextStyle sofiaProBold = (
//         {required Color color, required double size}) =>
//     _sofiaPro(color, size, FontWeight.w700);

// TextStyle latoRegular = (
//         {required Color color, required double size}) =>
//     _lato(color, size, FontWeight.w400);

TextStyle _sofiaPro(Color color, double size, FontWeight fontWeight) {
  return _textStyle(openSansNormal, color, size, fontWeight);
}

TextStyle _textStyle(
    String fontFamily, Color color, double size, FontWeight fontWeight) {
  return TextStyle(
      fontFamily: fontFamily,
      color: color,
      fontSize: size,
      fontWeight: fontWeight);
}
