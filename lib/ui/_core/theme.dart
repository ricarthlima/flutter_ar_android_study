import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/ui/_core/fonts.dart';

import 'colors.dart';

abstract class ThemeApp {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: AppFonts.montserrat,
        ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.buttonPrimary),
    appBarTheme: AppBarTheme(
      elevation: 3,
      toolbarHeight: 64,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Colors.black,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.bottomNavigationBarBackground,
      surfaceTintColor: AppColors.bottomNavigationBarBackground,
      indicatorColor: AppColors.bottomNavigationBarBackground,
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: AppColors.bottomNavigationBarSelected);
          }
          return IconThemeData(color: AppColors.bottomNavigationBarUnselected);
        },
      ),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      height: 80,
    ),
  );
}
