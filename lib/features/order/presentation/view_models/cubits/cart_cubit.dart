import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/order/domain/entities/payment.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/product.dart';
import 'package:onyx_ix_pos/features/order/domain/usecases/add_to_cart.dart';
import 'package:onyx_ix_pos/features/order/domain/usecases/remove_from_cart.dart';
import 'package:onyx_ix_pos/features/order/domain/usecases/increment_quantity.dart';
import 'package:onyx_ix_pos/features/order/domain/usecases/decrement_quantity.dart';
import 'package:onyx_ix_pos/features/order/domain/usecases/get_cart_items.dart';
import 'package:onyx_ix_pos/features/order/domain/usecases/calculate_total.dart';
import 'package:onyx_ix_pos/features/order/domain/usecases/add_payment.dart';
import 'package:onyx_ix_pos/features/order/domain/usecases/checkout.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final IncrementQuantityUseCase incrementQuantityUseCase;
  final DecrementQuantityUseCase decrementQuantityUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;
  final CalculateTotalUseCase calculateTotalUseCase;
  final AddPaymentUseCase addPaymentUseCase;
  final CheckoutUseCase checkoutUseCase;

  CartCubit({
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.incrementQuantityUseCase,
    required this.decrementQuantityUseCase,
    required this.getCartItemsUseCase,
    required this.calculateTotalUseCase,
    required this.addPaymentUseCase,
    required this.checkoutUseCase,
  }) : super(CartState(
          items: [], 
          paymentInput: '0.0', 
          amountPaid: 0.0,
          error: null,
        ));



  void addToCart(Product product) {
    try {
      addToCartUseCase(product);
      final items = getCartItemsUseCase(null);
      emit(state.copyWith(
        items: items,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
  }
  }

  void removeFromCart(Product product) {
    try {
      removeFromCartUseCase(product);
      final items = getCartItemsUseCase(null);
      emit(state.copyWith(
        items: items,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
  }
  }

  void incrementQuantity(Product product) {
    try {
      incrementQuantityUseCase(product);
      final items = getCartItemsUseCase(null);
      emit(state.copyWith(
        items: items,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
  }
  }

 
  void decrementQuantity(Product product) {
    try {
      decrementQuantityUseCase(product);
      final items = getCartItemsUseCase(null);
      emit(state.copyWith(
        items: items,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

 
  void addPayment(double amount) {
    try {
      final payment = Payment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: amount,
        timestamp: DateTime.now(),
      );
      addPaymentUseCase(payment);
      
     
      final items = getCartItemsUseCase(null);
      final currentState = state.copyWith(items: items);
      final grandTotal = currentState.grandTotal;
      final currentAmountPaid = state.amountPaid;
      final newAmountPaid = currentAmountPaid + amount;
      
      final finalAmountPaid = newAmountPaid > grandTotal ? grandTotal : newAmountPaid;
      
      emit(state.copyWith(
        items: items,
        amountPaid: finalAmountPaid,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void checkout() {
    try {
      final isPaidInFull = state.isPaidInFull;
      if (!isPaidInFull) {
        emit(state.copyWith(error: 'Payment is not complete'));
        return;
      }
      
      checkoutUseCase(null);
      emit(CartState(
        items: [],
        paymentInput: '0.0',
        amountPaid: 0.0,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void updatePaymentInput(String input) {
      emit(state.copyWith(paymentInput: input));
  }

  void clearPayment() {
    emit(state.copyWith(amountPaid: 0.0, error: null));
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }

  void setPaymentMethod(PaymentMethod method) {
    emit(state.copyWith(paymentMethod: method));
  }
}
