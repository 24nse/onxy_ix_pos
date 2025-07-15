import 'invoice_item.dart';

class Invoice {
  final String id;
  final DateTime date;
  final DateTime dueDate;
  final String paymentMethod;
  final String customerId;
  final String sellerId;
  final List<InvoiceItem> items;
  final double subtotal;
  final double discount;
  final double totalVat;
  final double totalExempt;
  final double totalWithVat;
  final String amountInWords;

  Invoice({
    required this.id,
    required this.date,
    required this.dueDate,
    required this.paymentMethod,
    required this.customerId,
    required this.sellerId,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.totalVat,
    required this.totalExempt,
    required this.totalWithVat,
    required this.amountInWords,
  });
} 