import 'package:dartz/dartz.dart';
import 'package:onyx_ix_pos/core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsByCategoryUseCase {
  final ProductRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call(String category) async {
    if (category == 'all') {
      return await repository.getProducts();
    }
    return await repository.getProductsByCategory(category);
  }
} 