import 'package:onyx_ix_pos/core/domain/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase extends UseCase<Future<List<Product>>, void> {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<List<Product>> call(void params) async {
    return await repository.getProducts();
  }
} 