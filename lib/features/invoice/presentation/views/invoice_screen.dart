import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/utils/service_locator.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/view_models/cubits/invoice_cubit.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/header_section.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/info_section.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/plutogrid_table_section.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/summary_section.dart';
import '../../domain/entities/invoice.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:onyx_ix_pos/features/invoice/domain/entities/mock_data.dart';


class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  Future<void> printInvoicePdf(BuildContext context, Invoice invoice) async {
    final customer = getCustomerById(invoice.customerId);
    final seller = getSellerById(invoice.sellerId);
    final pdf = pw.Document();
    final dueDateStr = DateFormat('yyyy/MM/dd').format(invoice.dueDate);
    final invoiceDateStr = DateFormat('yyyy/MM/dd - HH:mm:ss').format(invoice.date);

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<InvoiceCubit>(),
      child: Builder(
      builder: (context) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('الفاتورة'),
              actions: [
                BlocBuilder<InvoiceCubit, InvoiceState>(
                  builder: (context, state) {
                    if (state is InvoiceLoaded) {
                      return IconButton(
                        icon: const Icon(Icons.picture_as_pdf),
                        tooltip: 'تحميل PDF',
                        onPressed: () => printInvoicePdf(context, state.invoice),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderSection(),
                    const SizedBox(height: 16),
                    BlocBuilder<InvoiceCubit, InvoiceState>(
                      builder: (context, state) {
                        if (state is InvoiceLoaded) {
                          return InfoSection(invoice: state.invoice);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 16),
                    PlutogridTableSection(),
                    const SizedBox(height: 16),
                    SummarySection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
        );
      }
}
