import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';
import 'package:onyx_ix_pos/features/order/domain/entities/key_action.dart';
import 'package:onyx_ix_pos/core/widgets/show_custom_toast.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/cubits/full_screen_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/payment_cubit.dart';
import 'package:easy_debounce/easy_debounce.dart';

class PaymentCalculatorSection extends HookWidget {
  const PaymentCalculatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocBuilder<PaymentCubit, String>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppLocalizations.of(context)?.translate('enter_payment_amount') ??
                      'Enter Payment Amount:',
                  style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: getResponsiveFontSize(context, fontSize: 12)
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: MediaQuery.of(context).size.height * 0.04,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.searchAndTabBarDark
                          : const Color(0xFFdfe0e6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      state,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    EasyDebounce.debounce(
                      'payment-backspace-debounce',
                      const Duration(milliseconds: 250),
                      () => context.read<PaymentCubit>().onKeyPressed(BackspaceKey()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,

                    height: MediaQuery.of(context).size.height * 0.04,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.searchAndTabBarDark
                          : const Color(0xFFdfe0e6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.backspace_outlined,
                      size: 20,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: context.read<FullScreenCubit>().state? 7:6.5/2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCalcButton(
                  context,
                  '7',
                  () =>
                      context.read<PaymentCubit>().onKeyPressed(DigitKey('7')),
                ),
                _buildCalcButton(
                  context,
                  '8',
                  () =>
                      context.read<PaymentCubit>().onKeyPressed(DigitKey('8')),
                ),
                _buildCalcButton(
                  context,
                  '9',
                  () =>
                      context.read<PaymentCubit>().onKeyPressed(DigitKey('9')),
                ),
                _buildCalcButton(
                  context,
                  '4',
                  () =>
                      context.read<PaymentCubit>().onKeyPressed(DigitKey('4')),
                ),
                _buildCalcButton(
                  context,
                  '5',
                  () =>
                      context.read<PaymentCubit>().onKeyPressed(DigitKey('5')),
                ),
                _buildCalcButton(
                  context,
                  '6',
                  () =>
                      context.read<PaymentCubit>().onKeyPressed(DigitKey('6')),
                ),
                _buildCalcButton(
                  context,
                  '1',
                  () =>
                      context.read<PaymentCubit>().onKeyPressed(DigitKey('1')),
                ),
                _buildCalcButton(
                  context,
                  '2',
                  () =>
                      context.read<PaymentCubit>().onKeyPressed(DigitKey('2')),
                ),
                _buildCalcButton(
                  context,
                  '3',
                  () =>
                      context.read<PaymentCubit>().onKeyPressed(DigitKey('3')),
                ),
                _buildCalcButton(
                  context,
                  '0',
                  () =>
                      context.read<PaymentCubit>().onKeyPressed(DigitKey('0')),
                ),
                _buildCalcButton(
                  context,
                  '.',
                  () => context.read<PaymentCubit>().onKeyPressed(DecimalKey()),
                ),
                _buildCalcButton(
                  context,
                  'C',
                  () {
                    EasyDebounce.debounce(
                      'payment-clear-debounce',
                      const Duration(milliseconds: 250),
                      () => context.read<PaymentCubit>().onKeyPressed(ClearKey()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 30,
              child: _buildCalcButtonWidget(
                context,
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    AppLocalizations.of(context)?.translate('add_payment') ?? 'add Payment',
                    style: textTheme.labelLarge?.copyWith(
                      fontSize: getResponsiveFontSize(context, fontSize: 12),
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                () async {
                  final payment = context.read<PaymentCubit>().state;
                  if (payment.isNotEmpty && double.tryParse(payment) != null && double.parse(payment) > 0) {
                    final paymentAmount = double.parse(payment);
                    final cartState = context.read<CartCubit>().state;
                    final remainingAmount = cartState.remainingAmount;
                    
                    if (paymentAmount > remainingAmount) {
                      showCustomToast(
                        context,
                        title: AppLocalizations.of(context)?.translate('payment_exceeds_total') ?? 'Payment Exceeds Total',
                        message: AppLocalizations.of(context)?.translate('payment_amount_too_high') ?? 'Payment amount is higher than remaining amount.',
                        isError: true,
                      );
                      return;
                    }
                    
                    context.read<CartCubit>().updatePaymentInput(payment);
                    context.read<CartCubit>().addPayment(paymentAmount);
                    context.read<PaymentCubit>().reset();
                    showCustomToast(
                      context,
                      title: AppLocalizations.of(context)?.translate('payment_added') ?? 'Payment Added',
                      message: AppLocalizations.of(context)?.translate('action_completed_successfully') ?? 'Payment has been successfully added.',
                    );
                  } else {
                    showCustomToast(
                      context,
                      title: AppLocalizations.of(context)?.translate('invalid_payment') ?? 'Invalid Payment',
                      message: AppLocalizations.of(context)?.translate('please_enter_a_valid_payment_amount') ?? 'Please enter a valid payment amount.',
                      isError: true,
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCalcButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.searchAndTabBarDark
            : const Color(0xFFe5e9ec),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: getResponsiveFontSize(context, fontSize: 12),
                color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
              ),
        ),
      ),
    );
  }
}

Widget _buildCalcButtonWidget(
  BuildContext context,
  Widget child,
  VoidCallback onPressed,
) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF95aada),
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    child: child,
  );
}
