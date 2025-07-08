import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';

abstract class AppStyles {
  static const textStyle24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'Cairo',
  );

  static const textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Cairo',
  );

  static const textStyle16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: 'Cairo',
  );

  static const textStyle16Bold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    fontFamily: 'Cairo',
  );

  static const textStyle12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: 'Cairo',
  );
}
