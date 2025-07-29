import 'dart:developer';

import 'package:shopify/core/models/payment_method.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/features/checkout/data/models/delivery_address_model.dart';
import 'package:shopify/core/services/fire_store_service.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';

abstract class CheckoutDataSource {
  Future<void> addProductsToCheckout(List<Product> products, String userId);
  Future<List<Product>> getCheckoutProducts(String userId);
  Future<void> addPaymentMethod(PaymentMethod paymentMethod, String userId);
  Future<void> addDeliveryAddress(Delivery deliveryAddress, String userId);
  Future<void> updateDeliveryAddress(Delivery deliveryAddress, String userId);
  Future<Delivery> getDeliveryAddresses(String userId);
}

class CheckoutDataSourceImpl implements CheckoutDataSource {
  final FireStoreService fireStoreService;
  final FireBaseAuthService fireBaseAuthService;
  CheckoutDataSourceImpl({
    required this.fireStoreService,
    required this.fireBaseAuthService,
  });

  @override
  Future<void> addProductsToCheckout(
    List<Product> products,
    String userId,
  ) async {
    try {
      for (final product in products) {
        await fireStoreService.addData(
          path: "users/$userId/checkout",
          data: product.toJson(),
          documentId: product.name,
        );
      }
      log("Products added to checkout");
    } catch (e) {
      log("Error while adding products to checkout");
      throw (e.toString());
    }
  }

  @override
  Future<List<Product>> getCheckoutProducts(String userId) async {
    try {
      final checkoutProducts = await fireStoreService.getData(
        path: "users/$userId/checkout",
      );
      log("Checkout products retrieved");
      return checkoutProducts
          .map((doc) => Product.fromJson(doc.toJson()))
          .toList();
    } catch (e) {
      log("Error while getting checkout products");
      throw (e.toString());
    }
  }

  @override
  Future<void> addPaymentMethod(
    PaymentMethod paymentMethod,
    String userId,
  ) async {
    try {
      await fireStoreService.addData(
        path: "users/$userId/payment_methods",
        data: paymentMethod.toJson(),
        documentId: paymentMethod.type,
      );
      log("Payment method added");
    } catch (e) {
      log("Error while adding payment method");
      throw (e.toString());
    }
  }

  @override
  Future<void> addDeliveryAddress(
    Delivery deliveryAddress,
    String userId,
  ) async {
    try {
      await fireStoreService.addData(
        path: "users/$userId/delivery_addresses",
        data: deliveryAddress.toJson(),
        documentId: deliveryAddress.street,
      );
      log("Delivery address added");
    } catch (e) {
      log("Error while adding delivery address");
      throw (e.toString());
    }
  }

  @override
  Future<Delivery> getDeliveryAddresses(String userId) async {
    try {
      final deliveryAddress = await fireStoreService.getDeliveryAddresses(
        path: "users/$userId/delivery_addresses",
        documentId: userId,
      );
      log("Delivery address retrieved");
      return deliveryAddress;
    } catch (e) {
      log("Error while getting delivery address");
      throw (e.toString());
    }
  }

  @override
  Future<void> updateDeliveryAddress(
    Delivery deliveryAddress,
    String userId,
  ) async {
    try {
      await fireStoreService.updateMap(
        path: "users/$userId/delivery_addresses",
        documentId: userId,
        data: deliveryAddress.toJson(),
      );
      log("Delivery address updated");
    } catch (e) {
      log("Error while updating delivery address");
      throw (e.toString());
    }
  }
}
