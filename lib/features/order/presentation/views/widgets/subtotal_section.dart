
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_state.dart';

class SubtotalSection extends StatelessWidget {
  const SubtotalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryRow('Subtotal (Post-Discount)',
                '\$${state.subtotalAfterDiscount.toStringAsFixed(2)}'),
            _buildSummaryRow(
                'Tax (10%)', '\$${state.taxAmount.toStringAsFixed(2)}'),
            const Divider(height: 5, thickness: 0.1),
            _buildSummaryRow(
              color: Color(0xFF3B5998),
                'Grand Total', '\$${state.grandTotal.toStringAsFixed(2)}',
                isTotal: true),
          ],
        );
      },
    );
  }

  Widget _buildSummaryRow(String title, String amount, {bool isTotal = false, Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
