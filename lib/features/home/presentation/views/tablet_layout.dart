import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/features/home/presentation/views/widgets/product_catalog_section.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/order_summary_section.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        ProductCatalogSection(),
        OrderSummarySection(),
      ],
    );
  }
}
