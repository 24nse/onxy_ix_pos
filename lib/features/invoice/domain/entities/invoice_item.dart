class InvoiceItem {
  final int number;
  final String name;
  final String unit;
  final int quantity;
  final int freeQuantity;
  final double price;
  final double vatPercent;
  final double vatValue;
  final double total;

  InvoiceItem({
    required this.number,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.freeQuantity,
    required this.price,
    required this.vatPercent,
    required this.vatValue,
    required this.total,
  });
} 