import 'package:onyx_ix_pos/core/domain/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsByCategoryUseCase extends UseCase<Future<List<Product>>, String> {
  final ProductRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  @override
  Future<List<Product>> call(String category) async {
    if (category == 'all') {
      return await repository.getProducts();
    }
    return await repository.getProductsByCategory(category);
  }
} 