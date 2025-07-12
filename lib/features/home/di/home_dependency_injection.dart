import 'package:get_it/get_it.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/usecases/get_products.dart';
import '../domain/usecases/search_products.dart';
import '../domain/usecases/get_products_by_category.dart';
import '../presentation/view_models/cubits/search_cubit.dart';

final sl = GetIt.instance;

void setupHomeDependencyInjection() {
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(),
  );

  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => SearchProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductsByCategoryUseCase(sl()));

  sl.registerLazySingleton(() => SearchCubit(
    getProductsUseCase: sl(),
    searchProductsUseCase: sl(),
    getProductsByCategoryUseCase: sl(),
  ));
} 