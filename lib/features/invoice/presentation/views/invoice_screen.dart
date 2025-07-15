import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/header_section.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/info_section.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/plutogrid_table_section.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/summary_section.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

  
}
