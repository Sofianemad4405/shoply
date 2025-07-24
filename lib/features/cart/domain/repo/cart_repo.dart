import 'package:shopify/core/models/product_entity.dart';

abstract class CartRepo {
  Future<List<ProductEntity>> getCartProducts();
  Future<void> addToCart(ProductEntity product);
  Future<void> removeFromCart(ProductEntity product);
  Future<void> clearCart();
  Future<void> increaseQuantity(ProductEntity product);
  Future<void> decreaseQuantity(ProductEntity product);
  Future<bool> checkIfInCart(String productId);
}
