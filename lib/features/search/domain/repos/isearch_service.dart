import 'package:shopify/core/models/product_model.dart';

abstract class IsearchService {
  Future<List<Product>> searchProduct(String query);
}
