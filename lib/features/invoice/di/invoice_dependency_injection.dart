import 'package:get_it/get_it.dart';
import '../../order/data/repositories/cart_repository_impl.dart';
import '../data/invoice_repository_impl.dart';
import '../presentation/view_models/cubits/invoice_cubit.dart';

final sl = GetIt.instance;

void setupInvoiceDependencyInjection() {
  sl.registerLazySingleton<InvoiceRepositoryImpl>(
    () => InvoiceRepositoryImpl(cartRepository: sl<CartRepositoryImpl>()),
  );

  sl.registerFactory<InvoiceCubit>(
    () {
      final cubit = InvoiceCubit(repository: sl<InvoiceRepositoryImpl>());
      cubit.fetchInvoice('invoice-1');
      return cubit;
    },
  );
} 