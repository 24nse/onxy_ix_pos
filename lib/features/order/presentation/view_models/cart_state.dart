import 'package:onyx_ix_pos/features/home/domain/entities/cart_item.dart';


class CartState {
  final List<CartItem> items;



  CartState({
    required this.items,
   
   
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);
  double get taxAmount => subtotal * 0.10;
  double get grandTotal => subtotal + taxAmount;
  
 

  CartState copyWith({
    List<CartItem>? items,
    String? paymentInput,
    double? amountPaid,
  }) {
    return CartState(
      items: items ?? this.items,

    );
  }
}
