import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/ui/_core/fonts.dart';

import 'colors.dart';

abstract class ThemeApp {
  static ThemeData lightTheme = ThemeData.light().copyWith(
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
  );
}
