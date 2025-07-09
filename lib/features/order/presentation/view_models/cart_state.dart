import 'package:onyx_ix_pos/features/home/domain/entities/cart_item.dart';

class CartState {
  final List<CartItem> items;

  CartState({required this.items});

  double get subtotal =>
      items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  double get discountAmount =>
      items.fold(0, (sum, item) => sum + item.discountAmount);

  double get subtotalAfterDiscount => subtotal - discountAmount;

  double get taxAmount => items.fold(0, (sum, item) => sum + item.taxAmount);

  double get grandTotal => subtotalAfterDiscount + taxAmount;

  CartState copyWith({
    List<CartItem>? items,
    String? paymentInput,
    double? amountPaid,
  }) {
    return CartState(items: items ?? this.items);
  }
}
