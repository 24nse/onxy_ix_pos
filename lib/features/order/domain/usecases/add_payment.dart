import 'package:onyx_ix_pos/core/domain/usecase.dart';
import '../entities/payment.dart';
import '../repositories/cart_repository.dart';

class AddPaymentUseCase extends UseCase<void, Payment> {
  final CartRepository repository;

  AddPaymentUseCase(this.repository);

  @override
  void call(Payment payment) {
    repository.addPayment(payment);
  }
} 