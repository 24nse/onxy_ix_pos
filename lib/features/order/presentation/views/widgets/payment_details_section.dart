import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_state.dart';

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
          color: colorScheme.secondaryContainer.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('Payment Details:',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(height: 4),
              _buildDetailRow(
                context,
                'Amount Paid:',
                '\$${state.amountPaid.toStringAsFixed(2)}',
              ),
              _buildDetailRow(
                context,
                'Remaining:',
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
                        'Clear All Payments',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                    ),
                    () {
                      context.read<CartCubit>().clearPayment();
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
            title,
            style: textTheme.bodyLarge?.copyWith(
              color: isRemaining ? valueColor : colorScheme.onSurface,
              fontWeight: isRemaining ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: textTheme.bodyLarge?.copyWith(
              color: valueColor,
              fontWeight: FontWeight.bold,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    child: child,
  );
}
