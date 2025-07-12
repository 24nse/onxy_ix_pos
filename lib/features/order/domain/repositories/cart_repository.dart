import '../entities/cart_item.dart';
import '../entities/payment.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/product.dart';

abstract class CartRepository {
  List<CartItem> getCartItems();
  void addToCart(Product product);
  void removeFromCart(Product product);
  void incrementQuantity(Product product);
  void decrementQuantity(Product product);
  void updateQuantity(Product product, int quantity);
  void clearCart();
  double calculateSubtotal();
  double calculateTotal();
  List<Payment> getPayments();
  void addPayment(Payment payment);
  void clearPayments();
  double getAmountPaid();
  double getRemainingAmount();
  bool isPaidInFull();
} 