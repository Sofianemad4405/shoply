import 'dart:developer';

import 'package:shopify/core/models/payment_method.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/features/checkout/data/data_sources/checkout_data_source.dart';
import 'package:shopify/features/checkout/data/models/delivery_address_model.dart';
import 'package:shopify/features/checkout/domain/entities/delivery_entity.dart';
import 'package:shopify/features/checkout/domain/repo/checkout_repo.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';

class CheckoutRepoImpl implements CheckoutRepo {
  final CheckoutDataSource checkoutDataSource;
  final FireBaseAuthService fireBaseAuthService;
  CheckoutRepoImpl({
    required this.checkoutDataSource,
    required this.fireBaseAuthService,
  });

  @override
  Future<void> addProductsToCheckout(List<ProductEntity> products) async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    try {
      for (final product in products) {
        await checkoutDataSource.addProductsToCheckout([
          Product.fromEntity(product),
        ], userId);
      }
    } catch (e) {
      log("Error while adding products to checkout");
      throw (e.toString());
    }
  }

  @override
  Future<List<ProductEntity>> getCheckoutProducts() async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    try {
      final checkoutProducts = await checkoutDataSource.getCheckoutProducts(
        userId,
      );
      return checkoutProducts.map((e) => e.toEntity()).toList();
    } catch (e) {
      log("Error while getting checkout products");
      throw (e.toString());
    }
  }

  @override
  Future<void> addPaymentMethod(PaymentMethod paymentMethod) async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    try {
      await checkoutDataSource.addPaymentMethod(paymentMethod, userId);
    } catch (e) {
      log("Error while adding payment method");
      throw (e.toString());
    }
  }

  @override
  Future<void> addDeliveryAddress(DeliveryEntity deliveryAddress) async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    try {
      await checkoutDataSource.addDeliveryAddress(
        Delivery.fromEntity(deliveryAddress),
        userId,
      );
    } catch (e) {
      log("Error while adding delivery address");
      throw (e.toString());
    }
  }

  @override
  Future<DeliveryEntity> getDeliveryAddresses() async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    try {
      final deliveryAddress = await checkoutDataSource.getDeliveryAddresses(
        userId,
      );
      return deliveryAddress.toEntity();
    } catch (e) {
      log("Error while getting delivery addresses");
      throw (e.toString());
    }
  }

  @override
  Future<void> updateDeliveryAddress(DeliveryEntity deliveryAddress) async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    try {
      await checkoutDataSource.updateDeliveryAddress(
        Delivery.fromEntity(deliveryAddress),
        userId,
      );
    } catch (e) {
      log("Error while adding delivery address");
      throw (e.toString());
    }
  }
}
