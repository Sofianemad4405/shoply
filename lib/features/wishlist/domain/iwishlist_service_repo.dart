import 'package:shopify/core/models/product_model.dart';

abstract class IwishlistServiceRepo {
  Future<void> addProductToWishList(Product product);
  Future<void> removeProductFromWishList(Product product);
  Future<List<Product>> getWishListProducts();
  Future<void> clearWishList();
}
