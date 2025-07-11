import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';

class ProceedToCheckoutButton extends StatelessWidget {
  const ProceedToCheckoutButton({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          minimumSize: Size(double.infinity, height * 0.06),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppLocalizations.of(context)?.translate('proceed_to_checkout') ??
                'Proceed to Checkout',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
