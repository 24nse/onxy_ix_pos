import 'package:get_it/get_it.dart';
import '../../features/settings/presentation/cubits/theme_cubit.dart';
import '../../features/settings/presentation/cubits/locale_cubit.dart';
import '../../features/home/presentation/view_models/cubits/full_screen_cubit.dart';
import '../../features/order/presentation/view_models/cubits/payment_cubit.dart';
import '../../features/home/di/home_dependency_injection.dart';
import '../../features/order/di/order_dependency_injection.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  setupHomeDependencyInjection();
  setupOrderDependencyInjection();
  
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton<LocaleCubit>(() => LocaleCubit());
  sl.registerLazySingleton<FullScreenCubit>(() => FullScreenCubit());
  sl.registerLazySingleton<PaymentCubit>(() => PaymentCubit());
}
