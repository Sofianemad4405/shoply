import 'package:shopify/core/models/product_entity.dart';

abstract class HomeRepo {
  Future<List<ProductEntity>> getAllProducts();
  Future<ProductEntity> getSingleProduct(int id);
  Future<List<String>> getCategories();
}
