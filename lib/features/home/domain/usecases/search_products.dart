import 'package:onyx_ix_pos/core/domain/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class SearchProductsUseCase extends UseCase<List<Product>, String> {
  final ProductRepository repository;

  SearchProductsUseCase(this.repository);

  @override
  List<Product> call(String query) {
    if (query.trim().isEmpty) {
      return repository.getProducts();
    }

    final normalizedQuery = query.toLowerCase().trim();
    final allProducts = repository.getProducts();

    return allProducts.where((product) {
      final nameMatches = product.name.toLowerCase().contains(normalizedQuery);

      final categoryMatches = product.category.toLowerCase().contains(
        normalizedQuery,
      );

      bool priceMatches = false;
      if (normalizedQuery.contains('.') ||
          RegExp(r'^\d+$').hasMatch(normalizedQuery)) {
        try {
          final queryPrice = double.parse(normalizedQuery);
          priceMatches =
              product.price == queryPrice ||
              product.price.toString().contains(normalizedQuery);
        } catch (e) {
          return false;
        }
      }

      return nameMatches || categoryMatches || priceMatches;
    }).toList();
  }
}
