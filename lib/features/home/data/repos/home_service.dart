import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:shopify/core/services/database_service.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/features/home/domain/ihome_service.dart';
import 'package:shopify/core/models/product_model.dart';

class HomeService implements IHomeService {
  final DatabaseService databaseService;

  HomeService({required this.databaseService});

  @override
  Future<List<Product>> getAllProducts() async {
    final url = Uri.parse('${Constants.baseUrl}/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('products')) {
          final List<dynamic> productsJson = data['products'];
          saveDataToDatabase();
          return productsJson.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected response structure');
        }
      } else {
        throw Exception(
          'Failed to fetch products. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  @override
  Future<Product> getSingleProduct(int id) async {
    final url = Uri.parse('${Constants.baseUrl}/products/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Product.fromJson(data);
      } else {
        throw Exception(
          'Failed to fetch product. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

  @override
  Future<List<Product>> sortProductsByPrice(String sortBy, String order) async {
    final url = Uri.parse(
      '${Constants.baseUrl}/products?sortBy=$sortBy&order=$order',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('products')) {
          final List<dynamic> productsJson = data['products'];
          return productsJson.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected response structure');
        }
      } else {
        throw Exception(
          'Failed to sort products. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error sorting products: $e');
    }
  }

  @override
  Future<String> getGeminiResponse(String prompt) async {
    final apiKey = 'AIzaSyAnxzrtBp3kmhECxKi7mZM5xLHw9SKLJEA';
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey',
    );

    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt},
          ],
        },
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'];
        return "ana $text";
      } else {
        log("Gemini Error: ${response.statusCode}");
        log("Body: ${response.body}");
        return "حدث خطأ أثناء الاتصال بـ Gemini API.";
      }
    } catch (e) {
      log("Exception in Gemini API: $e");
      return "حدث خطأ أثناء الاتصال بـ Gemini API.";
    }
  }

  @override
  Future<void> saveDataToDatabase() async {
    final collection = FirebaseFirestore.instance.collection('products');

    final existing = await collection.limit(1).get();
    if (existing.docs.isNotEmpty) {
      log("Products already exist in Firestore. Skipping sync.");
      return;
    }

    final products = await getAllProducts();

    for (var product in products) {
      await collection.doc(product.id.toString()).set(product.toJson());
    }

    log("All products saved to Firestore.");
  }
}
