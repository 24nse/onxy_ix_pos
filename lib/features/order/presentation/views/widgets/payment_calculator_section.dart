import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onyx_ix_pos/core/utils/functions/key_action.dart';
import 'package:onyx_ix_pos/core/utils/functions/snackbar/show_custom_toast.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/payment_cubit.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';

class PaymentCalculatorSection extends HookWidget {
  const PaymentCalculatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, String>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Enter Payment Amount:'),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: MediaQuery.of(context).size.height * 0.04,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      // vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      state,
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 14),
                        fontWeight: FontWeight.bold,
                      ),
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
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(child: Icon(
                      
                      Icons.backspace_outlined, color: Colors.black,size: 20,)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 4,
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
                ElevatedButton(
                  
                  onPressed: () =>
                      context.read<PaymentCubit>().onKeyPressed(ClearKey()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.backspace_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildCalcButtonWidget(
              context,
              Text('Payment', style: TextStyle(fontSize: getResponsiveFontSize(context, fontSize: 18))),
              () {
                final payment = context.read<PaymentCubit>().state;
                context.read<CartCubit>().updatePaymentInput(payment);
                context.read<CartCubit>().addPayment();
                context.read<PaymentCubit>().reset();
              },
            ),
          ],
        );
      },
    );
  }

  ElevatedButton _buildCalcButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(fontSize: getResponsiveFontSize(context, fontSize: 18), color: Colors.black),
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
    onPressed: (true) ? onPressed : null,

    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF3B5998),
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    child: child,
  );
}
