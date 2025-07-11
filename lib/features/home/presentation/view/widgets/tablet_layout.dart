import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/home/presentation/view/widgets/product_catalog_section.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/full_screen_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/order_summary_section.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return  TabBarView(
      children: [
   
        ProductCatalogSection(), OrderSummarySection()],
    );
  }
}
