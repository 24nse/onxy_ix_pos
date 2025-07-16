import 'package:onyx_ix_pos/core/domain/usecase.dart';
import '../repositories/product_repository.dart';

class GetCategoriesUseCase extends UseCase<Future<List<String>>, void> {
  final ProductRepository repository;

  GetCategoriesUseCase(this.repository);

  @override
  Future<List<String>> call(void params) async {
    return await repository.getCategories();
  }
} 