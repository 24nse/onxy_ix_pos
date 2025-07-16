import '../local/mock_products.dart';
import '../../domain/entities/product.dart';

class ProductLocalDataSource {
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return mockProducts;
  }
} 