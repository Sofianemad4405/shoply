import 'package:shopify/core/models/product_model.dart';

abstract class CategoryRepo {
  Future<List<Product>> fetchCategoryProducts(String categoryName);
  Future<List<Product>> getCategoryProductsSorted(
    String sortMethod,
    String order,
    String category,
  );
}
