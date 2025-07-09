import 'package:flutter/material.dart';

import 'package:onyx_ix_pos/features/home/domain/entities/cart_item.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderDataGridSource extends DataGridSource {
  OrderDataGridSource({
    required List<CartItem> cartItems,
    required this.cubit,
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
  final CartCubit cubit;

  @override
  List<DataGridRow> get rows => _cartItems;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as CartItem;
    return DataGridRowAdapter(
      color: Colors.grey[100],
      cells: [
        _buildImageCell(item),
        _buildTextCell(item.product.name, alignment: Alignment.centerLeft),
        _buildTextCell('\$${item.product.price.toStringAsFixed(2)}'),
        _buildQtyCell(item),
        _buildTextCell('${item.discountPercent.toStringAsFixed(0)}%'),
        _buildTextCell('\$${item.discountAmount.toStringAsFixed(2)}'),
        _buildTextCell('${item.taxPercent.toStringAsFixed(0)}%'),
        _buildTextCell('\$${item.taxAmount.toStringAsFixed(2)}'),
        _buildTextCell('\$${item.total.toStringAsFixed(2)}'),
        _buildDeleteButton(item),
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
          IconButton(icon: const Icon(Icons.remove), onPressed: () => cubit.decrementQuantity(item)),
          Text('${item.quantity}'),
          IconButton(icon: const Icon(Icons.add), onPressed: () => cubit.incrementQuantity(item)),
        ],
      );

  

  Widget _buildDeleteButton(CartItem item) => IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => cubit.removeFromCart(item),
      );

  Widget _buildTextCell(String text, {Alignment alignment = Alignment.center}) => Container(
        alignment: alignment,
        padding: const EdgeInsets.all(8.0),
        child: Text(text, overflow: TextOverflow.ellipsis),
      );
}
