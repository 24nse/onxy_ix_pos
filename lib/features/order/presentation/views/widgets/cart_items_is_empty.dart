
import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart' show AppLocalizations;

class CartItemsIsEmpty extends StatelessWidget {
  const CartItemsIsEmpty({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          AppLocalizations.of(
                context,
              )?.translate('your_cart_is_empty') ??
              'Your cart is empty',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(
              alpha: 0.6,
            ),
          ),
        ),
      );
  }
}
