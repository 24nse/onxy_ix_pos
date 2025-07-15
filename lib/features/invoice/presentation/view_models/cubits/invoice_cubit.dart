import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/invoice_repository_impl.dart';
import '../../../domain/entities/invoice.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final InvoiceRepositoryImpl repository;

  InvoiceCubit({required this.repository}) : super(InvoiceInitial());

  Future<void> fetchInvoice(String id) async {
    emit(InvoiceLoading());
    try {
      final invoice = await repository.getInvoice(id);
      emit(InvoiceLoaded(invoice));
    } catch (e) {
      emit(InvoiceError(e.toString()));
    }
  }
} 