import 'package:components/res/res.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: AppColors.primary,
        fontFamily: 'DMSans',
        brightness: Brightness.light,
        canvasColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: FontAlias.fontAlias18, fontWeight: FontWeight.w600),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
        ));
  }
}
