import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shopify/features/home/model/product_model.dart';

class HomeService {
  final String baseUrl = 'https://dummyjson.com';

  Future<List<Product>> getAllProducts() async {
    final url = Uri.parse('$baseUrl/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('products')) {
          final List<dynamic> productsJson = data['products'];
          return productsJson.map((json) => Product.fromJson(json)).toList();
        }
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<Product> getSingleProduct(int id) async {
    final url = Uri.parse('$baseUrl/products/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Product.fromJson(data);
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

  Future<List<Product>> searchProduct(String productName) async {
    final url = Uri.parse('$baseUrl/products/search?q=$productName');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('products')) {
          final List products = data['products'];
          if (products.isNotEmpty) {
            return products.map((json) => Product.fromJson(json)).toList();
          } else {
            return [];
          }
        }
      }
      throw Exception('Invalid response format');
    } catch (e) {
      log('Error searching product: $e');
      throw Exception('Error searching product: $e');
    }
  }

  Future<List<String>> getCategories() async {
    final url = Uri.parse('$baseUrl/products/categories');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          return List<String>.from(data);
        }
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final url = Uri.parse('$baseUrl/products/category/$category');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('products')) {
          final List<dynamic> productsJson = data['products'];
          return productsJson.map((json) => Product.fromJson(json)).toList();
        }
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Error fetching products by category: $e');
    }
  }

  Future<List<Product>> sortProductsByPrice(String sortBy, String order) async {
    final url = Uri.parse('$baseUrl/products?sortBy=$sortBy&order=$order');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('products')) {
          final List<dynamic> productsJson = data['products'];
          return productsJson.map((json) => Product.fromJson(json)).toList();
        }
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Error sorting products: $e');
    }
  }
}
