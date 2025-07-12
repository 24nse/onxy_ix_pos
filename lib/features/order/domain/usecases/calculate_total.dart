import 'package:onyx_ix_pos/core/domain/usecase.dart';
import '../repositories/cart_repository.dart';

class CalculateTotalUseCase extends UseCase<double, void> {
  final CartRepository repository;

  CalculateTotalUseCase(this.repository);

  @override
  double call(void params) {
    return repository.calculateTotal();
  }
} 