import 'package:flutter/material.dart';

import '../../presentation/widgets/common_widgets.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/strings.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme:  AppBarTheme(
        elevation: 0,
        color: Color(0xFF01017d),
        titleTextStyle: styleIbmPlexSansRegular(size: 20, color: Colors.white),
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      splashColor: Colors.transparent,
      fontFamily: openSansNormal,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
    );
  }
}
