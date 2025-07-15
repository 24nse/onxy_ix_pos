part of 'invoice_cubit.dart';

abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}
class InvoiceLoading extends InvoiceState {}
class InvoiceLoaded extends InvoiceState {
  final Invoice invoice;
  InvoiceLoaded(this.invoice);
}
class InvoiceError extends InvoiceState {
  final String message;
  InvoiceError(this.message);
} 