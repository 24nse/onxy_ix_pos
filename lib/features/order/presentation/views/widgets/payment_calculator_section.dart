import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/functions/key_action.dart';
import 'package:onyx_ix_pos/core/utils/functions/snackbar/show_custom_toast.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/full_screen_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/payment_cubit.dart';

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
            Text(
              AppLocalizations.of(context)?.translate('enter_payment_amount') ??
                  'Enter Payment Amount:',
              style: textTheme.labelLarge!.copyWith(color: Colors.black),
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
                      color:Color(0xFFdfe0e6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      state,
                      style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    context.read<PaymentCubit>().onKeyPressed(BackspaceKey());
                  },
                  child: Container(
                    alignment: Alignment.center,

                    height: MediaQuery.of(context).size.height * 0.04,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color:Color(0xFFdfe0e6),
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
            SizedBox(height: 8),
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
                  context.read<PaymentCubit>().onKeyPressed(ClearKey());
                  showCustomToast(
                    context,
                    title: AppLocalizations.of(context)?.translate('payment_cleared') ?? 'Payment Cleared',
                    message: AppLocalizations.of(context)?.translate('payment_amount_has_been_cleared') ?? 'Payment amount has been cleared.',
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
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                () {
                  final payment = context.read<PaymentCubit>().state;
                  if (payment.isNotEmpty && double.tryParse(payment) != null && double.parse(payment) > 0) {
                    context.read<CartCubit>().updatePaymentInput(payment);
                    context.read<CartCubit>().addPayment();
                    context.read<PaymentCubit>().reset();
                    showCustomToast(
                      context,
                      title: AppLocalizations.of(context)?.translate('payment_added') ?? 'Payment Added',
                      message: AppLocalizations.of(context)?.translate('payment_has_been_successfully_added') ?? 'Payment has been successfully added.',
                    );
                  } else {
                    showCustomToast(
                      context,
                      title: AppLocalizations.of(context)?.translate('invalid_payment') ?? 'Invalid Payment',
                      message: AppLocalizations.of(context)?.translate('please_enter_a_valid_payment_amount') ?? 'Please enter a valid payment amount.',
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
        backgroundColor: Color(0xFFe5e9ec),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 12,
                color: Colors.black,
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
      backgroundColor: Color(0xFF95aada),
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    child: child,
  );
}
