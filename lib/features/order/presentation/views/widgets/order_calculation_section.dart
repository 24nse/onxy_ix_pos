
import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/subtotal_section.dart';

class OrderCalculationSection extends StatelessWidget {
  const OrderCalculationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SubtotalSection(),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: SizedBox(),
        ),
      ],
    );
  }
}
