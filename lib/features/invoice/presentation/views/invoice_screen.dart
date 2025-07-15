import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/utils/service_locator.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/view_models/cubits/invoice_cubit.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/header_section.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/info_section.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/plutogrid_table_section.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/summary_section.dart';


class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return        BlocProvider(
      create: (_) => sl<InvoiceCubit>() // Assuming InvoiceCubit is registered in service locator
    , child: Builder(
      builder: (context) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderSection(),
                    const SizedBox(height: 16),
                    InfoSection(),
                    const SizedBox(height: 16),
                    PlutogridTableSection(),
                    const SizedBox(height: 16),
                    SummarySection(),
                  ],
                ),
              ),
            ),
          
        );
      }
    ));
  }
}
