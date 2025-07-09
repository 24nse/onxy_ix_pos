import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/cart_item.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/product.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cart_cubit.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderDataGridSource extends DataGridSource {
  OrderDataGridSource({
    required List<CartItem> cartItems,
    required this.cubit,
  }) {
    _cartItems = cartItems.map<DataGridRow>((item) {
      return DataGridRow(cells: [
        DataGridCell<CartItem>(columnName: 'item', value: item),
        DataGridCell<String>(
          columnName: 'price',
          value: '\$${item.product.price.toStringAsFixed(2)}',
        ),
        DataGridCell<CartItem>(columnName: 'qty', value: item),
        DataGridCell<String>(
          columnName: 'total',
          value: '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
        ),
        DataGridCell<CartItem>(columnName: 'delete', value: item),
      ]);
    }).toList();
  }

  late List<DataGridRow> _cartItems;
  final CartCubit cubit;

  @override
  List<DataGridRow> get rows => _cartItems;
@override
DataGridRowAdapter buildRow(DataGridRow row) {
  final int index = rows.indexOf(row);
  final Map<String, dynamic> cellValues = {
    for (var cell in row.getCells()) cell.columnName: cell.value
  };

  final item = cellValues['item'] as CartItem;
  final product = item.product;

  return DataGridRowAdapter(
    color:Colors.grey[100],
    cells: [
      _buildBorderedCell(_buildItemCell(product), isFirst: index == 0),
      _buildBorderedCell(_buildTextCell(cellValues['price']), isFirst: index == 0),
      _buildBorderedCell(_buildQtyCell(item), isFirst: index == 0),
      _buildBorderedCell(_buildTextCell(cellValues['total']), isFirst: index == 0),
      _buildBorderedCell(_buildDeleteButton(item), isFirst: index == 0),
    ],
  );
}


Widget _buildBorderedCell(Widget child, {required bool isFirst}) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    decoration: BoxDecoration(
      border: Border(
        top: isFirst ? const BorderSide(width: 1, color: Colors.grey) : BorderSide.none,
        bottom: const BorderSide(width: 1, color: Colors.grey),
      ),
    ),
    child: child,
  );
}


  Widget _buildItemCell(Product product) => Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );

  Widget _buildQtyCell(CartItem item) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => cubit.decrementQuantity(item),
          ),
          Text('${item.quantity}'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => cubit.incrementQuantity(item),
          ),
        ],
      );

  Widget _buildDeleteButton(CartItem item) => IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => cubit.removeFromCart(item),
      );

  Widget _buildTextCell(String text) => Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      );
}
