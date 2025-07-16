import '../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String category,
    required double price,
    required String image,
  }) : super(
    id: id,
    name: name,
    category: category,
    price: price,
    image: image,
  );

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