import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/features/home/presentation/view/widgets/product_catalog_section.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/order_summary_section.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

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
