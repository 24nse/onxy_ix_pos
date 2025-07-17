import 'package:dartz/dartz.dart';
import 'package:onyx_ix_pos/core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class SearchProductsUseCase {
  final ProductRepository repository;

  SearchProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call(String query) async {
    return await repository.searchProducts(query);
  }
}
