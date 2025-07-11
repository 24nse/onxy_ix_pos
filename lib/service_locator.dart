import 'package:get_it/get_it.dart';
import 'features/settings/presentation/cubits/theme_cubit.dart';
import 'features/settings/presentation/cubits/locale_cubit.dart';
import 'features/home/presentation/view_models/cubits/full_screen_cubit.dart';
import 'features/order/presentation/view_models/cubits/cart_cubit.dart';
import 'features/order/presentation/view_models/cubits/payment_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton<LocaleCubit>(() => LocaleCubit());
  sl.registerLazySingleton<FullScreenCubit>(() => FullScreenCubit());
  sl.registerLazySingleton<CartCubit>(() => CartCubit());
  sl.registerLazySingleton<PaymentCubit>(() => PaymentCubit());
}
