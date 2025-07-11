

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/widgets/show_custom_toast.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/cubits/full_screen_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_state.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/cart_list.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/order_calculation_section.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/payment_details_section.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/proceed_to_checkout_button.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constrain) {
        return Card(
          margin: const EdgeInsets.only(
            top: 16,
            left: 8,
            right: 16,
            bottom: 56,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: Theme.of(context).brightness == Brightness.dark
                ? BorderSide(
                    color: Colors.grey.shade800,
                    width: 1,
                  )
                : BorderSide.none,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            AppLocalizations.of(
                                  context,
                                )?.translate('order_summary') ??
                                'Order Summary',
                            style: theme.textTheme.displayMedium,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.fullscreen),
                        onPressed: () {
                          context.read<FullScreenCubit>().toggleFullScreen();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return state.items.isEmpty
                          ? Center(
                              child: Text(
                                AppLocalizations.of(
                                      context,
                                    )?.translate('your_cart_is_empty') ??
                                    'Your cart is empty',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.6),
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 140,
                                          child: const CartList()),
                                        const SizedBox(height: 8),
                                        OrderCalculationSection(),
                                        const SizedBox(height: 4),
                                        PaymentDetailsSection(),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ProceedToCheckoutButton(
                                  onPressed: () {
                                    context.read<CartCubit>().clearCart();
                                    showCustomToast(
                                      context,
                                      title: AppLocalizations.of(context)?.translate('complete_purchase') ?? 'Checkout Complete',
                                      message: AppLocalizations.of(context)?.translate('action_completed_successfully') ?? 'The order has been successfully processed.',
                                    );
                                  },
                                ),
                              ],
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
