import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/pdf.dart';
import 'package:printing/printing.dart';
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
              summaryRow(
                label: 'الإجمالي',
                value: '${invoice.subtotal.toStringAsFixed(2)} SAR',
                border: true,
              ),
              summaryRow(
                label: 'الخصم',
                value: invoice.discount.toStringAsFixed(2),
                border: true,
              ),
              summaryRow(
                label: 'إجمالي الضريبة',
                value: invoice.totalVat.toStringAsFixed(2),
                border: true,
              ),
              summaryRow(
                label: 'إجمالي الإعفاء',
                value: invoice.totalExempt.toStringAsFixed(2),
                border: true,
              ),
              summaryRow(
                label: 'الإجمالي بالضريبة',
                value: '${invoice.totalWithVat.toStringAsFixed(2)} SAR',
                bold: true,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFD8232A), width: 2),
                      bottom: BorderSide(color: Color(0xFFD8232A), width: 2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: IconButton(
                          icon: const Icon(Icons.picture_as_pdf),
                          tooltip: 'تحميل PDF',
                          onPressed: () async {
                            PdfPreview(
                              build: (format) => generatePdf(
                                customerId: invoice.customerId,
                                sellerId: invoice.sellerId,
                                items: invoice.items,
                                subtotal: invoice.subtotal,
                                discount: invoice.discount,
                                totalVat: invoice.totalVat,
                                totalExempt: invoice.totalExempt,
                                totalWithVat: invoice.totalWithVat,
                                amountInWords: invoice.amountInWords,
                                paymentMethod: invoice.paymentMethod,
                                dueDate: invoice.dueDate.toString(),
                                invoiceDateStr: invoice.date.toString(),
                              ),
                            );
                            await Printing.layoutPdf(
                              onLayout: (format) => generatePdf(
                                customerId: invoice.customerId,
                                sellerId: invoice.sellerId,
                                items: invoice.items,
                                subtotal: invoice.subtotal,
                                discount: invoice.discount,
                                totalVat: invoice.totalVat,
                                totalExempt: invoice.totalExempt,
                                totalWithVat: invoice.totalWithVat,
                                amountInWords: invoice.amountInWords,
                                paymentMethod: invoice.paymentMethod,
                                dueDate: invoice.dueDate.toString(),
                                invoiceDateStr: invoice.date.toString(),
                              ),
                            );
                          },
                        ),
                      ),

                      Expanded(
                        flex: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: invoice.amountInWords,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    color: Colors.grey.withValues(alpha: 0.5),
                    width: 1,
                  ),
                )
              : null,
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: label,
              style: const TextStyle(fontFamily: 'Cairo'),
            ),
            const SizedBox(width: 8),
            CustomText(
              text: value,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
  ///
  ///
}


///