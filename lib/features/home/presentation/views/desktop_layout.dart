import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/home/presentation/views/widgets/product_catalog_section.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/cubits/full_screen_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/order_summary_section.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FullScreenCubit, bool>(
      builder: (context, state) {
        return state?const OrderSummarySection(): Row(
          children: [
            Expanded(flex: 4, child:const ProductCatalogSection()),
            Expanded(flex: 4, child:const OrderSummarySection()),
          ],
        );
      },
    );
  }
}
