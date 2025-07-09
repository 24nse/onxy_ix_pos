import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_state.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/order_datagrid_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CartList extends HookWidget {
  const CartList({super.key});

  GridColumn _buildGridColumn(String name, String label) {
    return GridColumn(
      columnName: name,
      label: Center(
        child: FittedBox(fit: BoxFit.scaleDown, child: Text(label)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Flexible(
          child: SfDataGrid(
            source: OrderDataGridSource(
              cartItems: state.items,
              cubit: context.read<CartCubit>(),
            ),
            rowHeight: 70,
            headerRowHeight: state.items.isEmpty ? 0 : 40,
            columnWidthMode: ColumnWidthMode.fill,
            gridLinesVisibility: GridLinesVisibility.none,
            headerGridLinesVisibility: GridLinesVisibility.none,
            columns: <GridColumn>[
              _buildGridColumn('item', 'Item'),
              _buildGridColumn('product', 'Product'),
              _buildGridColumn('price', 'Price'),
              _buildGridColumn('qty', 'Qty'),
              _buildGridColumn('disc', 'Disc %'),
              _buildGridColumn('disc_amt', 'Disc Amt'),
              _buildGridColumn('tax', 'Tax %'),
              _buildGridColumn('tax_amt', 'Tax Amt'),
              _buildGridColumn('total', 'Total'),
              _buildGridColumn('delete', 'Del'),
            ],
          ),
        );
      },
    );
  }
}

// c
