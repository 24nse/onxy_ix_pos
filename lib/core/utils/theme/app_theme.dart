import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardColor: AppColors.cardLight,
      textTheme: TextTheme(
        displayLarge: AppStyles.textStyle24.copyWith(color: AppColors.textPrimaryLight),
        displayMedium: AppStyles.textStyle20.copyWith(color: AppColors.textPrimaryLight),
        bodyLarge: AppStyles.textStyle16.copyWith(color: AppColors.textPrimaryLight),
        labelLarge: AppStyles.textStyle16Bold,
        bodySmall: AppStyles.textStyle12.copyWith(color: AppColors.textSecondaryLight),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        surface: AppColors.cardLight,
        background: AppColors.backgroundLight,
        error: AppColors.error,
      ),
      appBarTheme: AppBarTheme(
        color: AppColors.primaryLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
        titleTextStyle: AppStyles.textStyle20.copyWith(color: AppColors.white),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryLight,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.cardDark,
      textTheme: TextTheme(
        displayLarge: AppStyles.textStyle24.copyWith(color: AppColors.textPrimaryDark),
        displayMedium: AppStyles.textStyle20.copyWith(color: AppColors.textPrimaryDark),
        bodyLarge: AppStyles.textStyle16.copyWith(color: AppColors.textPrimaryDark),
        labelLarge: AppStyles.textStyle16Bold,
        bodySmall: AppStyles.textStyle12.copyWith(color: AppColors.textSecondaryDark),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark,
        surface: AppColors.cardDark,
        background: AppColors.backgroundDark,
        error: AppColors.error,
      ),
      appBarTheme: AppBarTheme(
        color: AppColors.primaryDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
        titleTextStyle: AppStyles.textStyle24.copyWith(color: AppColors.white),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryDark,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
