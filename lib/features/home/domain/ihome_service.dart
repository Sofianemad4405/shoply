import 'package:shopify/core/models/product_model.dart';

abstract class IHomeService {
  Future<List<Product>> getAllProducts();
  Future<Product> getSingleProduct(int id);
  Future<List<Product>> sortProductsByPrice(String sortBy, String order);
  Future<String> getGeminiResponse(String prompt);
  Future<void> saveDataToDatabase();
}
