
import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';

class NotAvailableBody extends StatelessWidget {
  const NotAvailableBody({
    super.key,
    required this.localizations,
    required this.isNotEmpty, required this.text,
  });

  final AppLocalizations? localizations;
  final bool isNotEmpty;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        isNotEmpty
            ? '${localizations?.translate('no_products_found') ?? 'No products found'} for "${text}"'
            : localizations?.translate('no_products_available') ??
                  'No products available',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}