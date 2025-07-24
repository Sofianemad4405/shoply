import 'package:shopify/core/services/fire_store_service.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/features/wishlist/domain/iwishlist_service_repo.dart';

class WishlistRepoImplementation implements IwishlistServiceRepo {
  FireStoreService fireStoreService = FireStoreService();
  @override
  Future<void> addProductToWishList(Product product) async {
    try {
      await fireStoreService.addData(
        path: 'wishlist',
        data: product.toJson(),
        documentId: product.id.toString(),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> clearWishList() async {
    try {
      await fireStoreService.deleteData(
        path: 'wishlist',
        documentId: 'wishlist',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Product>> getWishListProducts() async {
    try {
      final wishListProducts = await fireStoreService.getData(
        path: 'users',
        documentId: 'wishlist',
      );
      return wishListProducts.map((e) => Product.fromJson(e.toJson())).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> removeProductFromWishList(Product product) async {
    try {
      await fireStoreService.deleteData(
        path: 'wishlist',
        documentId: product.id.toString(),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
