import 'package:dartz/dartz.dart';
import 'package:onyx_ix_pos/core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failures, List<Product>>> getProducts();
  Future<Either<Failures, List<Product>>> searchProducts(String query);
  Future<Either<Failures, List<Product>>> getProductsByCategory(String category);
  Future<Either<Failures, List<String>>> getCategories();
  Future<Either<Failures, Product?>> getProductById(String id);
} 