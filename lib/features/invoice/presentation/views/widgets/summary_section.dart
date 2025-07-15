import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_models/cubits/invoice_cubit.dart';
import 'header_section.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, state) {
        if (state is InvoiceLoaded) {
          final invoice = state.invoice;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              summaryRow(label: 'الإجمالي', value: '${invoice.subtotal.toStringAsFixed(2)} SAR', border: true),
              summaryRow(label: 'الخصم', value: invoice.discount.toStringAsFixed(2), border: true),
              summaryRow(label: 'إجمالي الضريبة', value: invoice.totalVat.toStringAsFixed(2), border: true),
              summaryRow(label: 'إجمالي الإعفاء', value: invoice.totalExempt.toStringAsFixed(2), border: true),
              summaryRow(label: 'الإجمالي بالضريبة', value: '${invoice.totalWithVat.toStringAsFixed(2)} SAR', bold: true),
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
                  child: CustomText(text: invoice.amountInWords),
                ),
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
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
