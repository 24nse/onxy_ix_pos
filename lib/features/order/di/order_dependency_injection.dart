import 'package:get_it/get_it.dart';
import '../domain/repositories/cart_repository.dart';
import '../data/repositories/cart_repository_impl.dart';
import '../domain/usecases/add_to_cart.dart';
import '../domain/usecases/remove_from_cart.dart';
import '../domain/usecases/increment_quantity.dart';
import '../domain/usecases/decrement_quantity.dart';
import '../domain/usecases/get_cart_items.dart';
import '../domain/usecases/calculate_total.dart';
import '../domain/usecases/add_payment.dart';
import '../domain/usecases/checkout.dart';
import '../presentation/view_models/cubits/cart_cubit.dart';

final sl = GetIt.instance;

void setupOrderDependencyInjection() {
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl());

  sl.registerLazySingleton(() => AddToCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => IncrementQuantityUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => DecrementQuantityUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => GetCartItemsUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => CalculateTotalUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => AddPaymentUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => CheckoutUseCase(sl<CartRepository>()));

  sl.registerLazySingleton(() => CartCubit(
    addToCartUseCase: sl<AddToCartUseCase>(),
    removeFromCartUseCase: sl<RemoveFromCartUseCase>(),
    incrementQuantityUseCase: sl<IncrementQuantityUseCase>(),
    decrementQuantityUseCase: sl<DecrementQuantityUseCase>(),
    getCartItemsUseCase: sl<GetCartItemsUseCase>(),
    calculateTotalUseCase: sl<CalculateTotalUseCase>(),
    addPaymentUseCase: sl<AddPaymentUseCase>(),
    checkoutUseCase: sl<CheckoutUseCase>(),
  ));
} 