import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';

String getFontFamily(Locale locale) {
  if (locale.languageCode == 'ar') {
    return 'Cairo';
  }
  return 'Roboto';
}


class AppTheme {
  static ThemeData lightTheme(BuildContext context,Locale locale) {
    return ThemeData(
      fontFamily: getFontFamily(locale),
  
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardColor: AppColors.cardLight,
      
      textTheme: Theme.of(context).textTheme.copyWith(
        displayLarge: AppStyles.textStyle24(context).copyWith(color: AppColors.textPrimaryLight),
        displayMedium: AppStyles.textStyle20(context).copyWith(color: AppColors.textPrimaryLight),
        bodyLarge: AppStyles.textStyle16(context).copyWith(color: AppColors.textPrimaryLight),
        labelLarge: AppStyles.textStyle16Bold(context),
        bodySmall: AppStyles.textStyle12(context).copyWith(color: AppColors.textSecondaryLight),
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
        titleTextStyle: AppStyles.textStyle20(context).copyWith(color: AppColors.white),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryLight,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context,Locale locale) {
    return ThemeData(
      fontFamily:getFontFamily(locale),
      // fontFamilyFallback: ['NotoSans', 'Arial', 'sans-serif']
    
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.cardDark,
      textTheme: Theme.of(context).textTheme.copyWith(
        displayLarge: AppStyles.textStyle24(context).copyWith(color: AppColors.textPrimaryDark),
        displayMedium: AppStyles.textStyle20(context).copyWith(color: AppColors.textPrimaryDark),
        bodyLarge: AppStyles.textStyle16(context).copyWith(color: AppColors.textPrimaryDark),
        labelLarge: AppStyles.textStyle16Bold(context),
        bodySmall: AppStyles.textStyle12(context).copyWith(color: AppColors.textSecondaryDark),
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
        titleTextStyle: AppStyles.textStyle24(context).copyWith(color: AppColors.white),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryDark,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
