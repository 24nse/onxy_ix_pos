import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_state.dart';
import 'package:onyx_ix_pos/core/widgets/show_custom_toast.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';

class PaymentDetailsSection extends StatelessWidget {
  const PaymentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.searchAndTabBarDark
              : const Color(0xFFe3f0e5),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppLocalizations.of(context)?.translate('payment_details') ??
                      'Payment Details:',
                  style: textTheme.labelLarge?.copyWith(
                    fontSize: getResponsiveFontSize(context, fontSize: 14),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              _buildDetailRow(
                context,
                AppLocalizations.of(context)?.translate('amount_paid') ?? 'Amount Paid:',
                '\$${state.amountPaid.toStringAsFixed(2)}',
              ),
              _buildDetailRow(
                context,
                AppLocalizations.of(context)?.translate('remaining') ?? 'Remaining:',
                '\$${state.remainingAmount.toStringAsFixed(2)}',
                isRemaining: true,
              ),
              if (state.amountPaid > 0)
                SizedBox(
                  width: double.infinity,
                  child: _buildClearPaymentButtonWidget(
                    context,
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        AppLocalizations.of(context)?.translate('clear_all_payments') ??
                            'Clear All Payments',
                        style: textTheme.labelLarge?.copyWith(
                          color: 
                             Colors.black,
                            
                          fontSize: getResponsiveFontSize(context, fontSize: 12)
                        ),
                        
                      ),
                    ),
                    () {
                      context.read<CartCubit>().clearPayment();
                      showCustomToast(
                        context,
                        title: AppLocalizations.of(context)?.translate('payments_cleared') ?? 'Payments Cleared',
                        message: AppLocalizations.of(context)?.translate('all_payments_cleared') ?? 'All payments have been cleared.',
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String title,
    String value, {
    bool isRemaining = false,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final valueColor = isRemaining ? colorScheme.error : colorScheme.onSurface;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: true,
            title,
            style: textTheme.bodyLarge?.copyWith(
              color: isRemaining ? valueColor : colorScheme.onSurface,
              fontWeight: isRemaining ? FontWeight.bold : FontWeight.normal,
            fontSize: getResponsiveFontSize(context,fontSize: 8.0)
            ),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            value,
            style: textTheme.bodyLarge?.copyWith(
              color: valueColor,
              fontWeight: FontWeight.bold,
              fontSize: getResponsiveFontSize(context,fontSize: 8.0)
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildClearPaymentButtonWidget(
  BuildContext context,
  Widget child,
  VoidCallback onPressed,
) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      minimumSize: const Size(double.infinity, 30),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFFdfe0e6)
          : const Color(0xFFdfe0e6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    child: child,
  );
}
