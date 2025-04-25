// lib/services/product_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Product.dart';

class ProductService {
  static Future<List<Product>> fetchProducts(String maybelline) async {
    final response = await http.get(
      Uri.parse('https://makeup-api.herokuapp.com/api/v1/products.json?brand=$maybelline'),
    );

    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      return jsonData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
