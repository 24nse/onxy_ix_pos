import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/cart_item.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/product.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(items: [], paymentInput: '0.0', amountPaid: 0.0));

void addPayment(){
  final paymentValue = double.tryParse(state.paymentInput) ?? 0.0;
  if (paymentValue > 0) {
    final newAmountPaid = state.amountPaid + paymentValue;
    emit(state.copyWith(amountPaid: newAmountPaid, paymentInput: '0.0',));
  } else {
    emit(state.copyWith(paymentInput: '0.0')); 
  }
}
  void addToCart(Product product) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      items.add(CartItem(product: product, quantity: 1));
    } else {
      items[index].quantity++;
    }
    emit(state.copyWith(items: items));
  }

  void removeFromCart(CartItem cartItem) {
    final items = List<CartItem>.from(state.items)..remove(cartItem);
    emit(state.copyWith(items: items));
  }

  void incrementQuantity(CartItem cartItem) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexOf(cartItem);
    if (index != -1) {
      items[index].quantity++;
      emit(state.copyWith(items: items));
    }
  }

  void decrementQuantity(CartItem cartItem) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexOf(cartItem);
    if (index != -1) {
      if (items[index].quantity > 1) {
        items[index].quantity--;
      } else {
        items.removeAt(index);
      }
      emit(state.copyWith(items: items));
    }
  }

  void updatePaymentInput(String input) {
 
      emit(state.copyWith(paymentInput: input));
  
  }

  void startNewOrder() {
    emit(CartState(items: [], paymentInput: '0.0', amountPaid: 0.0));
  }

  void clearPayment() {
    emit(state.copyWith(amountPaid: 0.0));
  }

  void clearCart() {
    emit(state.copyWith(items: []));
  }
}
