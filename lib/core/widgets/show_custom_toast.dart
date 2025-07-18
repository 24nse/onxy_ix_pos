import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';

void showCustomToast(BuildContext context, {String? title, String? message, bool isError = false}) {
  final double width = MediaQuery.of(context).size.width;
  final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

  double horizontalMargin;
  if (width >= 1100) {
    horizontalMargin = width / 1.3;
  } else if (width >= 800) {
    horizontalMargin = width /1.5;
  } else {
    horizontalMargin = width /2.2;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                title ?? AppLocalizations.of(context)?.translate('success') ?? 'Success',
                style: TextStyle(
                  fontSize: getResponsiveFontSize(context, fontSize: 10),
                  fontWeight: FontWeight.bold,
                  color: isError ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message ??
                  AppLocalizations.of(context)?.translate('action_completed_successfully') ??
                  'Action completed successfully',
              style: TextStyle(color: isError ? Colors.white70 : Colors.black87),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: isError ? Colors.red.shade600 : Colors.grey.shade200,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      margin: EdgeInsets.only(
        bottom: 20,
        left: isArabic ? 20 : horizontalMargin,
        right: isArabic ? horizontalMargin : 20,
      ),
      elevation: 6,
    ),
  );
}
