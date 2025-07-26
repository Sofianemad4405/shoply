import 'dart:developer';

import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/core/services/fire_store_service.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';

abstract class WishlistDataSource {
  Future<bool> checkIfInWishList(String productId, String userId);
  Future<void> addToWishList(Product product, String userId);
  Future<void> removeFromWishList(Product product, String userId);
  Future<List<Product>> getWishListProducts(String userId);
  Future<void> clearWishList(String userId);
}

class WishListDataSourceImpl implements WishlistDataSource {
  final FireStoreService fireStoreService;
  final FireBaseAuthService fireBaseAuthService;

  WishListDataSourceImpl({
    required this.fireStoreService,
    required this.fireBaseAuthService,
  });
  @override
  Future<void> addToWishList(Product product, String userId) async {
    try {
      await fireStoreService.addData(
        path: "users/$userId/wishlist",
        data: product.toJson(),
        documentId: product.name,
      );
    } catch (e) {
      log("Error while adding Product to wishlist");
      throw (e.toString());
    }
  }

  @override
  Future<bool> checkIfInWishList(String productId, String userId) async {
    return await fireStoreService.checkIfDataExists(
      path: "users/$userId/wishlist",
      documentId: productId,
    );
  }

  @override
  Future<void> clearWishList(String userId) async {
    try {
      await fireStoreService.clearData(path: "users/$userId/wishlist");
    } on Exception catch (e) {
      log("Error while clearing wishlist");
      throw (e.toString());
    }
  }

  @override
  Future<List<Product>> getWishListProducts(String userId) async {
    try {
      final wishListProducts = await fireStoreService.getData(
        path: "users/$userId/wishlist",
      );
      return wishListProducts
          .map((doc) => Product.fromJson(doc.toJson()))
          .toList();
    } catch (e) {
      log("Error while getting wishlist products");
      throw (e.toString());
    }
  }

  @override
  Future<void> removeFromWishList(Product product, String userId) async {
    try {
      await fireStoreService.deleteData(
        path: "users/$userId/wishlist",
        documentId: product.name,
      );
    } catch (e) {
      log("Error while removing Product from wishlist");
      throw (e.toString());
    }
  }
}
