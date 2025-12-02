import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:flutter/material.dart';

import 'App_text_style.dart';

class ThemeStyles {
  static final lightTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'Cairo',
    primaryColor: AppColors.premrayColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.premrayColor,
      foregroundColor: AppColors.witheColor,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: AppColors.witheColor,
    textTheme: TextTheme(
      titleLarge: AppTextStyle.premaryLineStyle,
      titleMedium: AppTextStyle.textStyle,
    ),
    buttonTheme: ButtonThemeData(buttonColor: AppColors.premrayColor),
  );
}
