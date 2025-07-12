import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_state.dart';

class SubtotalSection extends StatelessWidget {
  const SubtotalSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryRow(
              context,
              AppLocalizations.of(
                    context,
                  )?.translate('subtotal_post_discount') ??
                  'Subtotal (Post-Discount)',
              '\$${state.subtotalAfterDiscount.toStringAsFixed(2)}',
            ),
            _buildSummaryRow(
              context,
              AppLocalizations.of(context)?.translate('tax_10_percent') ??
                  'Tax (10%)',
              '\$${state.taxAmount.toStringAsFixed(2)}',
            ),
            const Divider(height: 5, thickness: 0.1),
            _buildSummaryRow(
              
              context,
              AppLocalizations.of(context)?.translate('grand_total') ??
                  'Grand Total',
              '\$${state.grandTotal.toStringAsFixed(2)}',
              isTotal: true,
              color: theme.colorScheme.primary,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String title,
    String amount, {
    bool isTotal = false,
    Color? color,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final defaultColor = theme.colorScheme.onSurface.withValues(alpha: 0.8);
    final effectiveColor = color ?? defaultColor;

    final style = isTotal
        ? textTheme.labelLarge?.copyWith(
          fontSize: getResponsiveFontSize(context,fontSize: 12),
          color: Color(0xFF4364b8))
        : textTheme.bodyLarge?.copyWith(color: effectiveColor,fontSize: getResponsiveFontSize(context, fontSize: 12));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(maxLines: 1,overflow: TextOverflow.ellipsis, title, style: style),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(maxLines: 1,overflow: TextOverflow.ellipsis, amount, style: style, ),
          ),
        ],
      ),
    );
  }
}
