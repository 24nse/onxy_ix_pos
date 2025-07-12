class Payment {
  final String id;
  final double amount;
  final DateTime timestamp;
  final String method;

  Payment({
    required this.id,
    required this.amount,
    required this.timestamp,
    this.method = 'cash',
  });

  Payment copyWith({
    String? id,
    double? amount,
    DateTime? timestamp,
    String? method,
  }) {
    return Payment(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      timestamp: timestamp ?? this.timestamp,
      method: method ?? this.method,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Payment &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Payment{id: $id, amount: $amount, timestamp: $timestamp, method: $method}';
  }
} 