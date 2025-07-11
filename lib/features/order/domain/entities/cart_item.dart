import 'package:onyx_ix_pos/features/home/domain/entities/product.dart';

class CartItem {
  final Product product;
  int quantity;
  double discountPercent;
  double taxPercent;
  

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
}
