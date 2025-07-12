import 'package:onyx_ix_pos/core/domain/usecase.dart';
import '../repositories/cart_repository.dart';

class CheckoutUseCase extends UseCase<void, void> {
  final CartRepository repository;

  CheckoutUseCase(this.repository);

  @override
  void call(void params) {
    repository.clearCart();
    repository.clearPayments();
  }
} 