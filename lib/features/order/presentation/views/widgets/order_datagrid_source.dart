import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/widgets/show_custom_toast.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:onyx_ix_pos/features/order/domain/entities/cart_item.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';
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
        top: isFirstRow
            ? const BorderSide(color: Colors.grey, width: 0.5)
            : BorderSide.none,
        bottom: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      // color: Colors.grey[100],
    );
    return DataGridRowAdapter(
      // color: Colors.grey[100],
      cells: [
        _buildBorder(_buildImageCell(item), rowBorder),
        _buildBorder(
          _buildTextCell(item.product.name, alignment: Alignment.centerLeft),
          rowBorder,
        ),
        _buildBorder(
          _buildTextCell('\$${item.product.price.toStringAsFixed(2)}'),
          rowBorder,
        ),
        _buildBorder(_buildQtyCell(item), rowBorder),
        _buildBorder(
          _buildTextCell('${item.discountPercent.toStringAsFixed(0)}%'),
          rowBorder,
        ),
        _buildBorder(
          _buildTextCell('\$${item.discountAmount.toStringAsFixed(2)}'),
          rowBorder,
        ),
        _buildBorder(
          _buildTextCell('${item.taxPercent.toStringAsFixed(0)}%'),
          rowBorder,
        ),
        _buildBorder(
          _buildTextCell('\$${item.taxAmount.toStringAsFixed(2)}'),
          rowBorder,
        ),
        _buildBorder(
          _buildTextCell('\$${item.total.toStringAsFixed(2)}'),
          rowBorder,
        ),
        _buildBorder(_buildDeleteButton(item), rowBorder),
      ],
    );
  }

  Widget _buildImageCell(CartItem item) => Container(
    padding: const EdgeInsets.all(4.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: item.product.image.startsWith('http')
            ? Image.network(
                item.product.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(FontAwesomeIcons.image, size: 24, color: Colors.grey),
                  );
                },
              )
            : Image.asset(
                item.product.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(FontAwesomeIcons.image, size: 24, color: Colors.grey),
                  );
                },
              ),
      ),
    ),
  );

  Widget _buildQtyCell(CartItem item) {
    final double containerSize = getResponsiveFontSize(context, fontSize: 30);
    final double iconSize = getResponsiveFontSize(context, fontSize: 15);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: containerSize,
            width: containerSize,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(FontAwesomeIcons.minus, size: iconSize),
              onPressed: () => cubit.decrementQuantity(item.product),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getResponsiveFontSize(context, fontSize: 8),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '${item.quantity}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getResponsiveFontSize(context, fontSize: 14),
                ),
              ),
            ),
          ),
          Container(
            height: containerSize,
            width: containerSize,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(FontAwesomeIcons.plus, size: iconSize),
              onPressed: () => cubit.incrementQuantity(item.product),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(CartItem item) => IconButton(
    icon: const Icon(FontAwesomeIcons.trashCan, color: Colors.red,size: 14,),
    onPressed: () {
      cubit.removeFromCart(item.product);
      showCustomToast(
        context,
        title: AppLocalizations.of(context)?.translate('product_deleted') ?? 'Product Deleted',
        message: AppLocalizations.of(context)?.translate('product_deleted_successfully') ?? 'The product has been successfully removed from the cart.',
      );
    },
  );

  Widget _buildTextCell(
    String text, {
    Alignment alignment = Alignment.center,
  }) => Container(
    alignment: alignment,
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: getResponsiveFontSize(context, fontSize: 10,),  fontWeight: FontWeight.bold,),
    ),
  );

  Widget _buildBorder(Widget child, BoxDecoration decoration) {
    return Container(decoration: decoration, child: child);
  }
}
