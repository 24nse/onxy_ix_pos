import 'package:onyx_ix_pos/core/domain/usecase.dart';
import '../repositories/product_repository.dart';

class GetCategoriesUseCase extends UseCase<List<String>, void> {
  final ProductRepository repository;

  GetCategoriesUseCase(this.repository);

  @override
  List<String> call(void params) {
    return repository.getCategories();
  }
} 