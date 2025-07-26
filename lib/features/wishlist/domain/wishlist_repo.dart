import 'package:shopify/core/models/product_entity.dart';

abstract class WishlistRepo {
  Future<void> addProductToWishList(ProductEntity product);
  Future<void> removeProductFromWishList(ProductEntity product);
  Future<List<ProductEntity>> getWishListProducts();
  Future<void> clearWishList();
  Future<bool> isInWishlist(int productId);
}
