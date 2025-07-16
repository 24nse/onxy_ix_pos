class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] as num).toDouble(),
      image: json['image'] ?? '',
    );
  }

  factory Product.fromApiJson(Map<String, dynamic> json) {
    return Product(
      id: json['itemID']?.toString() ?? '',
      name: json['itemName'] ?? '',
      category: json['restaurantName'] ?? '', // or another field if you want a different mapping
      price: (json['itemPrice'] is int)
          ? (json['itemPrice'] as int).toDouble()
          : (json['itemPrice'] as num?)?.toDouble() ?? 0.0,
      image: json['imageUrl'] ?? '',
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    String? image,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Product{id: $id, name: $name, category: $category, price: $price}';
  }
}
