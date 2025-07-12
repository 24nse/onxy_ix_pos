import 'package:onyx_ix_pos/core/domain/usecase.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/product.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase extends UseCase<void, Product> {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  @override
  void call(Product product) {
    repository.removeFromCart(product);
  }
} 