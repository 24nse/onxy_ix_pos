import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';

import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_state.dart';
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
            AppLocalizations.of(context)?.translate(label.toLowerCase()) ?? label,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize: 12),
                fontWeight: FontWeight.bold,
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
          shrinkWrapRows: true,
          columns: <GridColumn>[
            _buildGridColumn(context, 'item', 'item'),
            _buildGridColumn(context, 'product', 'product'),
            _buildGridColumn(context, 'price', 'price'),
            _buildGridColumn(context, 'qty', 'qty'),
            _buildGridColumn(context, 'disc_percent', 'disc_percent'),
            _buildGridColumn(context, 'disc_amt', 'disc_amt'),
            _buildGridColumn(context, 'tax_percent', 'tax_percent'),
            _buildGridColumn(context, 'tax_amt', 'tax_amt'),
            _buildGridColumn(context, 'total', 'total'),
            _buildGridColumn(context, 'del', 'del'),
          ],
        );
      },
    );
  }
}

// c
