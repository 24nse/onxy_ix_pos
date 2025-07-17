import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/product.dart';
import 'package:onyx_ix_pos/features/home/domain/usecases/get_products.dart';
import 'package:onyx_ix_pos/features/home/domain/usecases/search_products.dart';
import 'package:onyx_ix_pos/features/home/domain/usecases/get_products_by_category.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/cubits/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetProductsUseCase getProductsUseCase;
  final SearchProductsUseCase searchProductsUseCase;
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  SearchCubit({
    required this.getProductsUseCase,
    required this.searchProductsUseCase,
    required this.getProductsByCategoryUseCase,
  }) : super(SearchState(
          allProducts: [],
          filteredProducts: [],
          searchTerm: '',
          selectedCategory: 'all',
        ));

  Future<void> loadProducts() async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await getProductsUseCase(null);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.errMessage)),
      (products) => emit(state.copyWith(
        allProducts: products,
        filteredProducts: products,
        isLoading: false,
        error: null,
      )),
    );
  }

  Future<void> updateSearchTerm(String searchTerm) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final normalizedSearchTerm = searchTerm.toLowerCase().trim();
      List<Product> filteredProducts;
      if (normalizedSearchTerm.isEmpty) {
        if (state.selectedCategory == 'all') {
          filteredProducts = state.allProducts;
        } else {
          filteredProducts = state.allProducts.where((product) =>
              product.category.toLowerCase() == state.selectedCategory.toLowerCase()
          ).toList();
        }
      } else {
        filteredProducts = state.allProducts.where((product) {
          final nameMatches = product.name.toLowerCase().contains(normalizedSearchTerm);
          final categoryMatches = product.category.toLowerCase().contains(normalizedSearchTerm);
          final priceMatches = product.price.toString().contains(normalizedSearchTerm);
          return nameMatches || categoryMatches || priceMatches;
        }).toList();
      }
      emit(state.copyWith(
        searchTerm: normalizedSearchTerm,
        filteredProducts: filteredProducts,
        isLoading: false,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> updateSelectedCategory(String category) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      List<Product> filteredProducts;
      if (state.searchTerm.isEmpty) {
        if (category == 'all') {
          filteredProducts = state.allProducts;
        } else {
          filteredProducts = state.allProducts.where((product) =>
              product.category.toLowerCase() == category.toLowerCase()
          ).toList();
        }
      } else {
        filteredProducts = state.allProducts.where((product) {
          final nameMatches = product.name.toLowerCase().contains(state.searchTerm);
          final categoryMatches = product.category.toLowerCase().contains(state.searchTerm);
          final priceMatches = product.price.toString().contains(state.searchTerm);
          final categoryFilter = category == 'all' || 
                               product.category.toLowerCase() == category.toLowerCase();
          return (nameMatches || categoryMatches || priceMatches) && categoryFilter;
        }).toList();
      }
      emit(state.copyWith(
        selectedCategory: category,
        filteredProducts: filteredProducts,
        isLoading: false,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void clearSearch() {
    List<Product> filteredProducts;
    if (state.selectedCategory == 'all') {
      filteredProducts = state.allProducts;
    } else {
      filteredProducts = state.allProducts.where((product) =>
          product.category.toLowerCase() == state.selectedCategory.toLowerCase()
      ).toList();
    }
    emit(state.copyWith(
      searchTerm: '',
      filteredProducts: filteredProducts,
      error: null,
    ));
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }
} 