import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_state.dart';

class PaymentDetailsSection extends StatelessWidget {
  const PaymentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Container(
          color: Colors.green[50],
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment Details:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildDetailRow('Amount Paid:', '\$${state.amountPaid.toStringAsFixed(2)}'),
              _buildDetailRow('Remaining:', '\$${state.remainingAmount.toStringAsFixed(2)}',
                  isRemaining: true),

           if(state.amountPaid>0)
             _buildClearPaymentButtonWidget(
              context,
              const Text('Clear All Payments'),
              () {
              context.read<CartCubit>().clearPayment();
              },
            ),
           
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value, {bool isRemaining = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: isRemaining ? Colors.red : Colors.black,
            fontWeight: isRemaining ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isRemaining ? Colors.red : Colors.black,
            fontWeight: FontWeight.bold,
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
  return Row(
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: onPressed,
        
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 204, 201, 201),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: child,
        ),
      ),
    ],
  );
}
