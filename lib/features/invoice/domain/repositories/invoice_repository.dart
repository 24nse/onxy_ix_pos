import '../entities/invoice.dart';

abstract class InvoiceRepository {
  Future<Invoice> getInvoice(String id);
}