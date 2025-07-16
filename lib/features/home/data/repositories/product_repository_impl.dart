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
  Future<List<Product>> getProducts() async {
    return await _fetchProducts();
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final products = await _fetchProducts();
    return products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final products = await _fetchProducts();
    return products
        .where((product) =>
            product.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  @override
  Future<List<String>> getCategories() async {
    final products = await _fetchProducts();
    return products.map((product) => product.category).toSet().toList();
  }

  @override
  Future<Product?> getProductById(String id) async {
    final products = await _fetchProducts();
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
} 