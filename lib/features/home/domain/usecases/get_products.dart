import 'package:dartz/dartz.dart';
import 'package:onyx_ix_pos/core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call(void params) async {
    return await repository.getProducts();
  }
} 