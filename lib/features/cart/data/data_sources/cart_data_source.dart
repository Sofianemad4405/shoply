import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/core/services/fire_store_service.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';

abstract class CartDataSource {
  Future<bool> checkIfInCart(String productId, String userId);
  Future<void> addToCart(Product product, String userId);
  Future<void> decreaseQuantity(Product product, String userId);
  Future<void> increaseQuantity(Product product, String userId);
  Future<void> removeFromCart(Product product, String userId);
  Future<List<Product>> getCartProducts(String userId);
  Future<void> clearCart(String userId);
}

class CartDataSourceImpl implements CartDataSource {
  final FireStoreService fireStoreService;
  final FireBaseAuthService fireBaseAuthService;

  CartDataSourceImpl({
    required this.fireStoreService,
    required this.fireBaseAuthService,
  });
  @override
  Future<void> addToCart(Product product, String userId) async {
    try {
      await fireStoreService.addData(
        path: "users/$userId/cart",
        data: product.toJson(),
        documentId: product.name,
      );
    } catch (e) {
      log("Error while adding Product");
      throw (e.toString());
    }
  }

  @override
  Future<void> removeFromCart(Product product, String userId) async {
    try {
      await fireStoreService.deleteData(
        path: "users/$userId/cart",
        documentId: product.name,
      );
    } catch (e) {
      log("Error while removing Product");
      throw (e.toString());
    }
  }

  @override
  Future<bool> checkIfInCart(String productId, String userId) async {
    return await fireStoreService.checkIfDataExists(
      path: "users/$userId/cart",
      documentId: productId,
    );
  }

  @override
  Future<List<Product>> getCartProducts(String userId) async {
    try {
      final cartProducts = await fireStoreService.getData(
        path: "users/$userId/cart",
      );
      return cartProducts.map((doc) => Product.fromJson(doc.toJson())).toList();
    } catch (e) {
      log("Error while getting cart products");
      throw (e.toString());
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    try {
      await fireStoreService.clearData(path: "users/$userId/cart");
    } catch (e) {
      log("Error while clearing cart");
      throw (e.toString());
    }
  }

  @override
  Future<void> decreaseQuantity(Product product, String userId) async {
    try {
      await fireStoreService.updateData(
        path: "users/$userId/cart",
        documentId: product.name,
        field: "qt",
        value: FieldValue.increment(-1),
      );
    } catch (e) {
      log("Error while decreasing quantity");
      throw (e.toString());
    }
  }

  @override
  Future<void> increaseQuantity(Product product, String userId) async {
    try {
      await fireStoreService.updateData(
        path: "users/$userId/cart",
        documentId: product.name,
        field: "qt",
        value: FieldValue.increment(1),
      );
    } catch (e) {
      log("Error while increasing quantity");
      throw (e.toString());
    }
  }
}
