import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_state.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/cart_items_is_empty.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/cart_list.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/custom_header_section.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/order_calculation_section.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/payment_details_section.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/proceed_to_checkout_button.dart';
import 'package:go_router/go_router.dart';

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
            left: 16,
            right: 16,
            bottom: 56,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: Theme.of(context).brightness == Brightness.dark
                ? BorderSide(color: Colors.grey.shade800, width: 1)
                : BorderSide.none,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderSection(theme: theme),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return state.items.isEmpty
                          ? CartItemsIsEmpty(theme: theme)
                          : Column(
                              children: [
                                const Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 140,
                                          child: CartList(),
                                        ),
                                        SizedBox(height: 8),
                                        OrderCalculationSection(),
                                        SizedBox(height: 4),
                                        PaymentDetailsSection(),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ProceedToCheckoutButton(
                                  onPressed: () async {
                                    context.read<CartCubit>().checkout();
                                    final state = context
                                        .read<CartCubit>()
                                        .state;
                                    _checkPaymentCompleteOrInComplete(
                                      state,
                                      context,
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

  void _checkPaymentCompleteOrInComplete(
    CartState state,
    BuildContext context,
  ) {
    if (state.amountPaid.toStringAsFixed(2) ==
        state.grandTotal.toStringAsFixed(2)) {
      context.go('/invoice');
    } else {
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text(
            AppLocalizations.of(context)?.translate('payment_incomplete_title') ?? 'Payment Incomplete',
            style: const TextStyle(fontFamily: 'Cairo'),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${AppLocalizations.of(context)?.translate('payment_incomplete_message') ?? 'Please complete the payment before checkout.'}\n${AppLocalizations.of(context)?.translate('remaining_amount') ?? 'The Remaining amount is :'}${state.remainingAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontFamily: 'Cairo'),
              ),
            ),
          ],
        ),
      );
    }
  }
}
