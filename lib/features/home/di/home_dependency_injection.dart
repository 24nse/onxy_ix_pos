import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:onyx_ix_pos/core/utils/api_service.dart';
import '../data/repositories/product_repository_impl.dart';
import '../data/remote/product_remote_data_source.dart';
import '../data/local/product_local_data_source.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/usecases/get_products.dart';
import '../domain/usecases/search_products.dart';
import '../domain/usecases/get_products_by_category.dart';
import '../presentation/view_models/cubits/search_cubit.dart';

final sl = GetIt.instance;

void setupHomeDependencyInjection() {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiService>(
    () => ApiService(dio: sl(), baseUrl: 'https://fakerestaurantapi.runasp.net/api/Restaurant/5/menu'),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(apiService: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSource(),
  );
  sl.registerLazySingleton<ProductRepositoryImpl>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ProductRepository>(() => sl<ProductRepositoryImpl>());

  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => SearchProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductsByCategoryUseCase(sl()));

  sl.registerLazySingleton(() => SearchCubit(
    getProductsUseCase: sl(),
    searchProductsUseCase: sl(),
    getProductsByCategoryUseCase: sl(),
  ));
} 