import 'package:onyx_ix_pos/core/domain/usecase.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class GetCartItemsUseCase extends UseCase<List<CartItem>, void> {
  final CartRepository repository;

  GetCartItemsUseCase(this.repository);

  @override
  List<CartItem> call(void params) {
    return repository.getCartItems();
  }
} 