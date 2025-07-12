import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  // بيانات ثابتة مؤقتاً - يمكن استبدالها لاحقاً بـ API أو قاعدة بيانات
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Espresso',
      category: 'Beverages',
      price: 3.50,
      image: "https://media.istockphoto.com/id/1127245421/photo/woman-hands-praying-for-blessing-from-god-on-sunset-background.jpg?s=1024x1024&w=is&k=20&c=faoiFapQkhucuLuor9gBnblJ4KJpqvEgariqalvzRas=",
    ),
    Product(
      id: '2',
      name: 'Latte',
      category: 'Beverages',
      price: 4.50,
      image: "https://media.istockphoto.com/id/1127245421/photo/woman-hands-praying-for-blessing-from-god-on-sunset-background.jpg?s=1024x1024&w=is&k=20&c=faoiFapQkhucuLuor9gBnblJ4KJpqvEgariqalvzRas=",
    ),
    Product(
      id: '3',
      name: 'Croissant',
      category: 'Snacks',
      price: 2.75,
      image: "https://media.istockphoto.com/id/1127245421/photo/woman-hands-praying-for-blessing-from-god-on-sunset-background.jpg?s=1024x1024&w=is&k=20&c=faoiFapQkhucuLuor9gBnblJ4KJpqvEgariqalvzRas=",
    ),
    Product(
      id: '4',
      name: 'Caesar Salad',
      category: 'Meals',
      price: 8.50,
      image: "https://media.istockphoto.com/id/1127245421/photo/woman-hands-praying-for-blessing-from-god-on-sunset-background.jpg?s=1024x1024&w=is&k=20&c=faoiFapQkhucuLuor9gBnblJ4KJpqvEgariqalvzRas=",
    ),
    Product(
      id: '5',
      name: 'Cheeseburger',
      category: 'Meals',
      price: 9.00,
      image: "https://media.istockphoto.com/id/1127245421/photo/woman-hands-praying-for-blessing-from-god-on-sunset-background.jpg?s=1024x1024&w=is&k=20&c=faoiFapQkhucuLuor9gBnblJ4KJpqvEgariqalvzRas=",
    ),
    Product(
      id: '6',
      name: 'Potato Chips',
      category: 'Snacks',
      price: 1.50,
      image: "https://media.istockphoto.com/id/1127245421/photo/woman-hands-praying-for-blessing-from-god-on-sunset-background.jpg?s=1024x1024&w=is&k=20&c=faoiFapQkhucuLuor9gBnblJ4KJpqvEgariqalvzRas=",
    ),
  ];

  @override
  List<Product> getProducts() {
    return List.from(_products);
  }

  @override
  List<Product> searchProducts(String query) {
    return _products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  List<Product> getProductsByCategory(String category) {
    return _products
        .where((product) =>
            product.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  @override
  List<String> getCategories() {
    return _products
        .map((product) => product.category)
        .toSet()
        .toList();
  }

  @override
  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
} 