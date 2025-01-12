import 'package:fire_todo/core/themes/colors.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backLight,
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.white)
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.gray,
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: AppColors.primary),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      titleMedium: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          ),
      titleSmall: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backDark,
    primaryColor: AppColors.backDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.gray,
    ),
      floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: AppColors.primary),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppColors.white,
          fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      titleMedium: TextStyle(
          color: AppColors.white,
        fontWeight: FontWeight.bold,
          fontSize: 20,),
      titleSmall: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
          fontSize: 18,),
    ),
  );
}
