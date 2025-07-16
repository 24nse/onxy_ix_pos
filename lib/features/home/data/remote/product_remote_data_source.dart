import 'package:onyx_ix_pos/core/utils/api_service.dart';
import '../../domain/entities/product.dart';
import '../product_model.dart';

class ProductRemoteDataSource {
  final ApiService apiService;

  ProductRemoteDataSource({required this.apiService});

  Future<List<Product>> fetchProducts({String? category}) async {
    try {
      final response = await apiService.dio.get(
        'https://cors-anywhere.herokuapp.com/https://fakerestaurantapi.runasp.net/api/Restaurant/items',
      );
      if (response.statusCode == 200 && response.data is List) {
        final List data = response.data as List;
        if (data.isEmpty) throw Exception('No data from API');
        return data.map((json) => ProductModel.fromApiJson(json).toEntity()).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Remote fetch error: $e');
    }
  }
} 