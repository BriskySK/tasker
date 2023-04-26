import 'package:flutter/material.dart';
import 'package:tasker/core/app_colors.dart';
import 'package:tasker/modules/_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:ThemeData(
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
      ),
      home: const HomeScreen(),
    );
  }
}
