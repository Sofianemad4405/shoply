import 'package:shopify/core/models/product_model.dart';

abstract class CategoryService {
  Future<List<Product>> fetchCategoryProducts(String categoryName);
  Future<List<String>> getCategories();
}
