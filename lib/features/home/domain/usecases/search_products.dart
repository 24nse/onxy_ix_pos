import 'package:onyx_ix_pos/core/domain/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class SearchProductsUseCase extends UseCase<Future<List<Product>>, String> {
  final ProductRepository repository;

  SearchProductsUseCase(this.repository);

  @override
  Future<List<Product>> call(String query) async {
    return await repository.searchProducts(query);
  }
}
