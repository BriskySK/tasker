import 'package:flutter/material.dart';
import 'package:tasker/core/ui/app_colors.dart';

abstract class CustomTheme {
  static theme() => ThemeData.light(useMaterial3: true).copyWith(
        colorScheme: const ColorScheme(
            background: AppColors.primaryColor,
            onBackground: AppColors.primaryColor,
            brightness: Brightness.light,
            primary: AppColors.primaryColor,
            onPrimary: AppColors.primaryColor,
            secondary: AppColors.secondaryColor,
            onSecondary: AppColors.secondaryColor,
            error: AppColors.errorColor,
            onError: AppColors.errorColor,
            surface: AppColors.surfaceColor,
            onSurface: AppColors.surfaceColor),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(fontSize: 16),
        ),
        outlinedButtonTheme: const OutlinedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStatePropertyAll(10),
            side: MaterialStatePropertyAll(
              BorderSide(color: AppColors.tertiaryColor),
            ),
          ),
        ),
        textTheme: const TextTheme(
          labelSmall: TextStyle(fontSize: 8, fontWeight: FontWeight.normal),
          labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
          labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          displaySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
          titleSmall: TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
          titleMedium: TextStyle(fontSize: 40, fontWeight: FontWeight.normal),
          titleLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.normal),
        ),

      );
}
