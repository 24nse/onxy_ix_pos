import 'package:onyx_ix_pos/core/domain/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase extends UseCase<List<Product>, void> {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  @override
  List<Product> call(void params) {
    return repository.getProducts();
  }
} 