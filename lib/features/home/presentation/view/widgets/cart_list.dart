import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_state.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/order_datagrid_source.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CartList extends HookWidget {
  const CartList({super.key});

  GridColumn _buildGridColumn(BuildContext context, String name, String label) {
    return GridColumn(
      columnName: name,
      label: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return SfDataGrid(
          source: OrderDataGridSource(
            cartItems: state.items,
            cubit: context.read<CartCubit>(),
            context: context,
          ),
          rowHeight: 65,
          headerRowHeight: state.items.isEmpty ? 0 : 40,
          columnWidthMode: ColumnWidthMode.fill,
          gridLinesVisibility: GridLinesVisibility.none,
          headerGridLinesVisibility: GridLinesVisibility.none,
          columns: <GridColumn>[
            _buildGridColumn(context, 'item', 'Item'),
            _buildGridColumn(context, 'product', 'Product'),
            _buildGridColumn(context, 'price', 'Price'),
            _buildGridColumn(context, 'qty', 'Qty'),
            _buildGridColumn(context, 'disc', 'Disc %'),
            _buildGridColumn(context, 'disc_amt', 'Disc Amt'),
            _buildGridColumn(context, 'tax', 'Tax %'),
            _buildGridColumn(context, 'tax_amt', 'Tax Amt'),
            _buildGridColumn(context, 'total', 'Total'),
            _buildGridColumn(context, 'delete', 'Del'),
          ],
        );
      },
    );
  }
}

// c
