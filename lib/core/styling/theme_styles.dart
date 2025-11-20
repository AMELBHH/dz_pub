import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_font.dart';
import 'package:flutter/material.dart';

class ThemeStyles {
  static final lightTheme = ThemeData(
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
