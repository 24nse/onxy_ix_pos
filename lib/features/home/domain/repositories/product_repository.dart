import 'package:dartz/dartz.dart';
import 'package:onyx_ix_pos/core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<Product>>> searchProducts(String query);
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category);
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, Product?>> getProductById(String id);
} 