import 'package:flutter/material.dart';

void showCustomToast(BuildContext context, {String message = 'Action completed successfully', String title = 'Success'}) {
  double width = MediaQuery.of(context).size.width;
bool isArbic = Localizations.localeOf(context).languageCode == 'ar';

 ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title, 
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          message,
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.grey.shade200,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    margin:  EdgeInsets.only(
      bottom: 20,
      right: isArbic? width/1.3 : 20,
      left:isArbic?20: width/1.3, 

    ),
    elevation: 6,
  ),
);
}