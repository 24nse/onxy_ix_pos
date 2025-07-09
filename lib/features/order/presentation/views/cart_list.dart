import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_state.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/widgets/order_datagrid_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CartList extends HookWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit,CartState>(

      builder: (context, state) {
        return SfDataGrid(
            source: OrderDataGridSource(cartItems: state.items, cubit: CartCubit()),
              rowHeight: 70,
          columnWidthMode: ColumnWidthMode.fill,
          gridLinesVisibility: GridLinesVisibility.none,
          headerGridLinesVisibility: GridLinesVisibility.none,
          columns: <GridColumn>[
  GridColumn(
    columnName: 'item',
    label: Center(child: Text('Item')),
  ),
  GridColumn(
    columnName: 'price',
    label: Center(child: Text('Price')),
  ),
  GridColumn(
    columnName: 'qty',
    label: Center(child: Text('Qty')),
  ),
  GridColumn(
    columnName: 'total',
    label: Center(child: Text('Total')),
  ),
  GridColumn(
    columnName: 'delete',
    label: Center(child: Text('')),
  ),
],

          );
      }
    );

  }
}

// c