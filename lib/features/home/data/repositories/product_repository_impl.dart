import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../remote/product_remote_data_source.dart';
import '../local/product_local_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  List<Product>? _cache;
  String _lastSource = '';
  String get lastSource => _lastSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<List<Product>> _fetchProducts() async {
    print("object");
    if (_cache != null) return _cache!;
    try {
      final remoteProducts = await remoteDataSource.fetchProducts();
      if (remoteProducts.isNotEmpty) {
        print('Loaded products from API');
        _lastSource = 'API';
        _cache = remoteProducts;
        return remoteProducts;
      } else {
        // API returned empty list, fallback to local
        print('API returned empty, loading mock data');
        _lastSource = 'Mock';
        final localProducts = await localDataSource.fetchProducts();
        _cache = localProducts;
        return localProducts;
      }
    } catch (e) {
      // API call failed, fallback to local
      print('API fetch failed: $e');
      _lastSource = 'Mock';
      final localProducts = await localDataSource.fetchProducts();
      _cache = localProducts;
      return localProducts;
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await _fetchProducts();
      return Right(products);
    } catch (e) {
      return Left(Failure('Failed to get products: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    try {
      final products = await _fetchProducts();
      final filtered = products
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      return Right(filtered);
    } catch (e) {
      return Left(Failure('Failed to search products: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final products = await _fetchProducts();
      final filtered = products
          .where(
            (product) =>
                product.category.toLowerCase() == category.toLowerCase(),
          )
          .toList();
      return Right(filtered);
    } catch (e) {
      return Left(Failure('Failed to get products by category: $e'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final products = await _fetchProducts();
      final categories = products
          .map((product) => product.category)
          .toSet()
          .toList();
      return Right(categories);
    } catch (e) {
      return Left(Failure('Failed to get categories: $e'));
    }
  }

  @override
  Future<Either<Failure, Product?>> getProductById(String id) async {
    try {
      final products = await _fetchProducts();
      final product = products.where((product) => product.id == id).isNotEmpty
          ? products.firstWhere((product) => product.id == id)
          : null;
      if (product == null) {
        return Left(Failure('Product not found'));
      }
      return Right(product);
    } catch (e) {
      return Left(Failure('Failed to get product by id: $e'));
    }
  }
}
