import 'package:shopify/core/models/product_entity.dart';

abstract class SearchRepo {
  Future<List<ProductEntity>> searchProduct(String query);
}
