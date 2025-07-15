import 'package:onyx_ix_pos/core/domain/usecase.dart';

import '../entities/invoice.dart';
import '../repositories/invoice_repository.dart';

class GetInvoiceUseCase extends UseCase<Future<Invoice>, String> {
  final InvoiceRepository repository;

  GetInvoiceUseCase(this.repository);
  
@override
  Future<Invoice> call(String id) {
    return repository.getInvoice(id);
  }
}