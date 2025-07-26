import 'dart:developer';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';
import 'package:shopify/features/wishlist/data/data_source/wishlist_data_source.dart';
import 'package:shopify/features/wishlist/domain/wishlist_repo.dart';

class WishlistRepoImpl implements WishlistRepo {
  final WishListDataSourceImpl wishListDataSourceImpl;

  final FireBaseAuthService fireBaseAuthService;

  WishlistRepoImpl({
    required this.fireBaseAuthService,
    required this.wishListDataSourceImpl,
  });

  @override
  Future<void> addProductToWishList(ProductEntity product) async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    try {
      await wishListDataSourceImpl.addToWishList(
        Product.fromEntity(product),
        userId,
      );
    } catch (e) {
      log("Error while adding Product to wishlist");
      throw (e.toString());
    }
  }

  @override
  Future<void> clearWishList() async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    try {
      await wishListDataSourceImpl.clearWishList(userId);
    } catch (e) {
      log("Error while clearing wishlist");
      throw (e.toString());
    }
  }

  @override
  Future<List<ProductEntity>> getWishListProducts() async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    try {
      return await wishListDataSourceImpl.getWishListProducts(userId);
    } catch (e) {
      log("Error while getting wishlist products");
      throw (e.toString());
    }
  }

  @override
  Future<void> removeProductFromWishList(ProductEntity product) async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    try {
      await wishListDataSourceImpl.removeFromWishList(
        Product.fromEntity(product),
        userId,
      );
    } catch (e) {
      log("Error while removing Product from wishlist");
      throw (e.toString());
    }
  }

  @override
  Future<bool> isInWishlist(int productId) async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    return wishListDataSourceImpl.checkIfInWishList(
      productId.toString(),
      userId,
    );
  }
}
