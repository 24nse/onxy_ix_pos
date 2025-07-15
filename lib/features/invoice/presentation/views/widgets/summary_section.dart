import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/header_section.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        summaryRow(label: 'الإجمالي', value: '91.30 SAR', border: true),
        summaryRow(label: 'الخصم', value: '0.00', border: true),
        summaryRow(label: 'إجمالي الضريبة', value: '13.70', border: true),
        summaryRow(label: 'إجمالي الإعفاء', value: '0.00', border: true),
        summaryRow(label: 'الإجمالي بالضريبة', value: '105 SAR', bold: true),
        const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:16),
              child: Container(
                height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: const Color(0xFFD8232A),
                  width: 2,
                ),
                 bottom: BorderSide(
                  color:  const Color(0xFFD8232A),
                  width: 2,
                ),
              ),
                      
                        ),
                        child: CustomText(text: "مئة وخمسة ريال سعودي فقط لاغير"),
                      ),
            )

      ],
    );
    
  }

  Widget summaryRow({
    required String label,
    required String value,
    bool bold = false,
    bool border = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),

      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        width: 200,
        decoration: BoxDecoration(
          border: border
              ? Border(
                  bottom: BorderSide(
                    color: Colors.grey.withValues(alpha:  0.5),
                    width: 1,
                  ),
                )
              : null,
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: label),
            const SizedBox(width: 8),
            CustomText(text: value,style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}
