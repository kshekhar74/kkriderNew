// lib/models/product.dart
class Product {
  final int id;
  final String name;
  final String brand;
  final String price;
  final String imageLink;
  final String description;
  final double? rating;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageLink,
    required this.description,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      price: json['price'] ?? '0',
      imageLink: json['image_link'] ?? '',
      description: json['description'] ?? '',
      rating: json['rating'] != null ? double.tryParse(json['rating'].toString()) : null,
    );
  }
}
