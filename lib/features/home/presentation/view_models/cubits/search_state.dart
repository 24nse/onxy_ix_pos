
import 'package:onyx_ix_pos/features/home/domain/entities/product.dart';

class SearchState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String searchTerm;
  final String selectedCategory;
  final bool isLoading;
  final String? error;

  SearchState({
    required this.allProducts,
    required this.filteredProducts,
    required this.searchTerm,
    required this.selectedCategory,
    this.isLoading = false,
    this.error,
  });

  SearchState copyWith({
    List<Product>? allProducts,
    List<Product>? filteredProducts,
    String? searchTerm,
    String? selectedCategory,
    bool? isLoading,
    String? error,
  }) {
    return SearchState(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      searchTerm: searchTerm ?? this.searchTerm,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
