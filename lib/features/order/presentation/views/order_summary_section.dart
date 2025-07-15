import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/widgets/show_custom_toast.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/invoice_screen.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_state.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/cart_items_is_empty.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/cart_list.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/custom_header_section.dart';
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
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 140,
                                          child: const CartList(),
                                        ),
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
                                    context.read<CartCubit>().checkout();
                                         Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>const InvoiceScreen()),
            );
                                 
                                    final state = context.read<CartCubit>().state;
                                    
                                    _checkPaymentCompleteOrInComplete(state, context);
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

  void _checkPaymentCompleteOrInComplete(CartState state, BuildContext context) {
     if (state.error != null) {
      showCustomToast(
        context,
        title: AppLocalizations.of(context)?.translate('payment_incomplete') ?? 'Payment Incomplete',
        message: AppLocalizations.of(context)?.translate('payment_not_complete_message') ?? 'Please complete the payment before checkout.',
        isError: true,
      );
                                     
    } else {
      showCustomToast(
        context,
        title: AppLocalizations.of(context)?.translate('complete_purchase') ?? 'Checkout Complete',
        message: AppLocalizations.of(context)?.translate('action_completed_successfully') ?? 'The order has been successfully processed.',
      );
    }
  }
}
