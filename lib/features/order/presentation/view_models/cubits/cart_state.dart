import 'package:onyx_ix_pos/features/order/domain/entities/cart_item.dart';
import 'package:onyx_ix_pos/features/order/domain/entities/payment.dart';

class CartState {
  final List<CartItem> items;
  final String paymentInput;
  final double amountPaid;
  final String? error;
  final PaymentMethod? paymentMethod;

  CartState({
    required this.paymentInput,
    required this.amountPaid,
    required this.items,
    this.error,
    this.paymentMethod,
  });

  double get subtotal =>
      items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  double get discountAmount =>
      items.fold(0, (sum, item) => sum + item.discountAmount);

  double get subtotalAfterDiscount => subtotal - discountAmount;

  double get taxAmount => items.fold(0, (sum, item) => sum + item.taxAmount);

  double get grandTotal => subtotalAfterDiscount + taxAmount;

  double get remainingAmount => grandTotal - amountPaid;
  double get change =>
      (amountPaid > grandTotal) ? amountPaid - grandTotal : 0.0;
  bool get isPaidInFull => remainingAmount <= 0 && items.isNotEmpty;

  CartState copyWith({
    List<CartItem>? items,
    String? paymentInput,
    double? amountPaid,
    String? error,
    PaymentMethod? paymentMethod,
  }) {
    return CartState(
      items: items ?? this.items,
      paymentInput: paymentInput ?? this.paymentInput,
      amountPaid: amountPaid ?? this.amountPaid,
      error: error ?? this.error,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
