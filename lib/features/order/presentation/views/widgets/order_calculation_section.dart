import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/subtotal_section.dart';

import 'payment_calculator_section.dart';

class OrderCalculationSection extends StatelessWidget {
  const OrderCalculationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          Expanded(flex: 6, child: SubtotalSection()),
           SizedBox(width: 20),
          Expanded(flex: 5, child: PaymentCalculatorSection()),
        ],
      ),
    );
  }
}
