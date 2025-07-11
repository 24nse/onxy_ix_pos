import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_state.dart';

class PaymentDetailsSection extends StatelessWidget {
  const PaymentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Container(
        //  height: MediaQuery.sizeOf(context).height/10,
          width: double.infinity,
          color: Colors.green[50],
          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Payment Details:',
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontWeight: FontWeight.bold,
                    fontSize: getResponsiveFontSize(context, fontSize: 12,),
                  ),
                ),
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
                _buildClearPaymentButtonWidget(
                  context,
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Clear All Payments',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getResponsiveFontSize(context, fontSize: 12),
                        color: Colors.black,
                      ),
                    ),
                  ),
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

  Widget _buildDetailRow(
    BuildContext context,
    String title,
    String value, {
    bool isRemaining = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize: 12),
              color: isRemaining ? Colors.red : Colors.black,
              fontWeight: isRemaining ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize: 12),
              color: isRemaining ? Colors.red : Colors.black,
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
  return ElevatedButton(
    onPressed: onPressed,
        
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 8),
          minimumSize:  Size(
        double.infinity,30),
    
      backgroundColor: Color.fromARGB(255, 245, 244, 244),
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    child: child,
  );
}
