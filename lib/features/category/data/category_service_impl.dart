import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/features/category/domain/icategory_service.dart';
import 'package:shopify/core/models/product_model.dart';

class CategoryServiceImpl implements CategoryService {
  @override
  Future<List<Product>> fetchCategoryProducts(String category) async {
    final url = Uri.parse('${Constants.baseUrl}/products/category/$category');
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

  @override
  Future<List<String>> getCategories() async {
    final url = Uri.parse('${Constants.baseUrl}/products/category-list');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          return data.whereType<String>().toList();
        }
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<List<Product>> getCategoryProductsSorted(
    String sortMethod,
    String order,
    String category,
  ) async {
    final url = Uri.parse(
      '${Constants.baseUrl}/products/category/$category?sortBy=$sortMethod&order=$order',
    );
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
