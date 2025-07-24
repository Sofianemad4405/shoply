import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/features/search/domain/repos/isearch_service.dart';

class SearchImplementation implements IsearchService {
  @override
  Future<List<Product>> searchProduct(String productName) async {
    final url = Uri.parse(
      '${Constants.baseUrl}/products/search?q=$productName',
    );
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
}
