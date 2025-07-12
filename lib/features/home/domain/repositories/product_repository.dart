import '../entities/product.dart';

abstract class ProductRepository {
  List<Product> getProducts();
  List<Product> searchProducts(String query);
  List<Product> getProductsByCategory(String category);
  List<String> getCategories();
  Product? getProductById(String id);
} 