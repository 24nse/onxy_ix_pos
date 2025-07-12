import 'package:onyx_ix_pos/core/domain/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsByCategoryUseCase extends UseCase<List<Product>, String> {
  final ProductRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  @override
  List<Product> call(String category) {
    if (category == 'all') {
      return repository.getProducts();
    }
    return repository.getProductsByCategory(category);
  }
} 