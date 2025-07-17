import '../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.category,
    required super.price,
    required super.image,
  });

  factory ProductModel.fromApiJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['itemID']?.toString() ?? '',
      name: json['itemName'] ?? '',
      category: json['restaurantName'] ?? '',
      price: (json['itemPrice'] is int)
          ? (json['itemPrice'] as int).toDouble()
          : (json['itemPrice'] as num?)?.toDouble() ?? 0.0,
      image: json['imageUrl'] ?? '',
    );
  }

  Product toEntity() => this;
} 