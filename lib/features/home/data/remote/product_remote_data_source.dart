import 'package:onyx_ix_pos/core/utils/api_service.dart';
import '../../domain/entities/product.dart';

class ProductRemoteDataSource {
  final ApiService apiService;

  ProductRemoteDataSource({required this.apiService});

  Future<List<Product>> fetchProducts({String? category}) async {
    try {
      final response = await apiService.get(
        '/products',
        queryParameters: category != null ? {'category': category} : null,
      );
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Remote fetch error: $e');
    }
  }
} 