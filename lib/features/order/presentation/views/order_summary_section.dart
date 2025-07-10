import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/functions/snackbar/show_custom_toast.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_styles.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/full_screen_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_state.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/cart_list.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/order_calculation_section.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/payment_details_section.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/proceed_to_checkout_button.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                      style: AppStyles.textStyle20,
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
                          ),
                        )
                      : const CartList();
                },
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state.items.isEmpty) {
                  return const SizedBox.shrink();
                }
                return  Column(
                  children: [
                    OrderCalculationSection(),
                    SizedBox(height: 16),
                    PaymentDetailsSection(),
                    SizedBox(height: 16),
                    ProceedToCheckoutButton(
                      onPressed: () {
                        context.read<CartCubit>().clearCart();
                        showCustomToast(context,
                          message: AppLocalizations.of(
                                context,
                              )?.translate('order_completed') ??
                              'Order completed',
                        );

                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
