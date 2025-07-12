import '../../domain/entities/cart_item.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/product.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItem> _cartItems = [];
  final List<Payment> _payments = [];

  @override
  List<CartItem> getCartItems() {
    return List.from(_cartItems);
  }

  @override
  void addToCart(Product product) {
    final index = _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      _cartItems.add(CartItem(product: product, quantity: 1));
    } else {
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + 1,
      );
    }
  }

  @override
  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
  }

  @override
  void incrementQuantity(Product product) {
    final index = _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + 1,
      );
    }
  }

  @override
  void decrementQuantity(Product product) {
    final index = _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index] = _cartItems[index].copyWith(
          quantity: _cartItems[index].quantity - 1,
        );
      } else {
        _cartItems.removeAt(index);
      }
    }
  }

  @override
  void updateQuantity(Product product, int quantity) {
    final index = _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (quantity > 0) {
        _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
      } else {
        _cartItems.removeAt(index);
      }
    }
  }

  @override
  void clearCart() {
    _cartItems.clear();
  }

  @override
  double calculateSubtotal() {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.baseTotal;
    }
    return total;
  }

  @override
  double calculateTotal() {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.total;
    }
    return total;
  }

  @override
  List<Payment> getPayments() {
    return List.from(_payments);
  }

  @override
  void addPayment(Payment payment) {
    _payments.add(payment);
  }

  @override
  void clearPayments() {
    _payments.clear();
  }

  @override
  double getAmountPaid() {
    double total = 0.0;
    for (var payment in _payments) {
      total += payment.amount;
    }
    return total;
  }

  @override
  double getRemainingAmount() {
    final total = calculateTotal();
    final amountPaid = getAmountPaid();
    return total - amountPaid;
  }

  @override
  bool isPaidInFull() {
    final remainingAmount = getRemainingAmount();
    return remainingAmount <= 0 && _cartItems.isNotEmpty;
  }
} 