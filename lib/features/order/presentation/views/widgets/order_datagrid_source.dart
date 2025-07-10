import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/cart_item.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderDataGridSource extends DataGridSource {
  final CartCubit cubit;
  final BuildContext context;

  OrderDataGridSource({
    required List<CartItem> cartItems,
    required this.cubit,
    required this.context,
  }) {
    _cartItems = cartItems
        .map<DataGridRow>(
          (item) => DataGridRow(
            cells: [
              DataGridCell<CartItem>(columnName: 'item', value: item),
              DataGridCell<CartItem>(columnName: 'product', value: item),
              DataGridCell<CartItem>(columnName: 'price', value: item),
              DataGridCell<CartItem>(columnName: 'qty', value: item),
              DataGridCell<CartItem>(columnName: 'disc', value: item),
              DataGridCell<CartItem>(columnName: 'disc_amt', value: item),
              DataGridCell<CartItem>(columnName: 'tax', value: item),
              DataGridCell<CartItem>(columnName: 'tax_amt', value: item),
              DataGridCell<CartItem>(columnName: 'total', value: item),
              DataGridCell<CartItem>(columnName: 'delete', value: item),
            ],
          ),
        )
        .toList();
  }

  late List<DataGridRow> _cartItems;

  @override
  List<DataGridRow> get rows => _cartItems;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as CartItem;
    final rowIndex = _cartItems.indexOf(row);
    final isFirstRow = rowIndex == 0;
    final rowBorder = BoxDecoration(
      border: Border(
        top: isFirstRow ? const BorderSide(color: Colors.grey, width: 0.5) : BorderSide.none,
        bottom: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      // color: Colors.grey[100], 
    );
    return DataGridRowAdapter(
      // color: Colors.grey[100],
      cells: [
        _buildBorder(_buildImageCell(item), rowBorder),
        _buildBorder(_buildTextCell(item.product.name, alignment: Alignment.centerLeft), rowBorder),
        _buildBorder(_buildTextCell('\$${item.product.price.toStringAsFixed(2)}'), rowBorder),
        _buildBorder(_buildQtyCell(item), rowBorder),
        _buildBorder(_buildTextCell('${item.discountPercent.toStringAsFixed(0)}%'), rowBorder),
        _buildBorder(_buildTextCell('\$${item.discountAmount.toStringAsFixed(2)}'), rowBorder),
        _buildBorder(_buildTextCell('${item.taxPercent.toStringAsFixed(0)}%'), rowBorder),
        _buildBorder(_buildTextCell('\$${item.taxAmount.toStringAsFixed(2)}'), rowBorder),
        _buildBorder(_buildTextCell('\$${item.total.toStringAsFixed(2)}'), rowBorder),
        _buildBorder(_buildDeleteButton(item), rowBorder),
      ],
    );
  }

  Widget _buildImageCell(CartItem item) => Container(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Image.network(
            item.product.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget _buildQtyCell(CartItem item) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: IconButton(
              icon: const Icon(Icons.remove, size: 15),
              onPressed: () => cubit.decrementQuantity(item),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('${item.quantity}'),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 10),
            onPressed: () => cubit.incrementQuantity(item),
          ),
        ],
      );

  Widget _buildDeleteButton(CartItem item) => IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => cubit.removeFromCart(item),
      );

  Widget _buildTextCell(String text, {Alignment alignment = Alignment.center}) =>
      Container(
        alignment: alignment,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: getResponsiveFontSize(context, fontSize: 10),
          ),
        ),
      );
}

Widget _buildBorder(Widget child, BoxDecoration decoration) {
  return Container(
    decoration: decoration,
      child: child,
    
  );
}
