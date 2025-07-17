import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/utils/service_locator.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/view_models/cubits/invoice_cubit.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/header_section.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/info_section.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/plutogrid_table_section.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/summary_section.dart';
import '../../domain/entities/invoice.dart';




class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  Future<void> printInvoicePdf(BuildContext context, Invoice invoice) async {


  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocProvider(
        create: (_) => sl<InvoiceCubit>(),
        child: Builder(
        builder: (context) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderSection(),
                      const SizedBox(height: 16),
                      BlocBuilder<InvoiceCubit, InvoiceState>(
                        builder: (context, state) {
                          if (state is InvoiceLoaded) {
                            return const InfoSection();
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(height: 16),
                      const PlutogridTableSection(),
                      const SizedBox(height: 16),
                      const SummarySection(),
                     const SizedBox(height: 16),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
          ),
    );
      }
}
