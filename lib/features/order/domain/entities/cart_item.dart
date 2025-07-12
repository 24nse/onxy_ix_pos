import '../../../home/domain/entities/product.dart';

class CartItem {
  final Product product;
  final int quantity;
  final double discountPercent;
  final double taxPercent;

    CartItem({
    required this.product,
    this.quantity = 1,
    this.discountPercent = 0.0,
    this.taxPercent = 10.0,
  });

    double get baseTotal => product.price * quantity;
  double get discountAmount => baseTotal * (discountPercent / 100);
  double get totalAfterDiscount => baseTotal - discountAmount;
  double get taxAmount => totalAfterDiscount * (taxPercent / 100);
  double get total => totalAfterDiscount + taxAmount;

  CartItem copyWith({
    Product? product,
    int? quantity,
    double? discountPercent,
    double? taxPercent,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      discountPercent: discountPercent ?? this.discountPercent,
      taxPercent: taxPercent ?? this.taxPercent,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          product == other.product &&
          quantity == other.quantity;

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;

  @override
  String toString() {
    return 'CartItem{product: $product, quantity: $quantity, discountPercent: $discountPercent, taxPercent: $taxPercent}';
  }
}
