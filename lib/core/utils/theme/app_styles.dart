import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';

abstract class AppStyles {
  static TextStyle textStyle24(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: 24),
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      );

  static TextStyle textStyle20(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: 20),
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      );

  static TextStyle textStyle16(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: 16),
        fontWeight: FontWeight.normal,
        fontFamily: 'Cairo',
      );

  static TextStyle textStyle16Bold(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: 16),
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        fontFamily: 'Cairo',
      );

  static TextStyle textStyle12(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: 12),
        fontWeight: FontWeight.normal,
        fontFamily: 'Cairo',
      );
}
