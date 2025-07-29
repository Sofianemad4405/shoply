import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/models/payment_method.dart';
import 'package:shopify/features/checkout/data/models/delivery_address_model.dart';
import 'package:shopify/features/checkout/domain/entities/delivery_entity.dart';

abstract class CheckoutRepo {
  Future<void> addProductsToCheckout(List<ProductEntity> products);
  Future<List<ProductEntity>> getCheckoutProducts();
  Future<void> addPaymentMethod(PaymentMethod paymentMethod);
  Future<void> addDeliveryAddress(DeliveryEntity deliveryAddress);
  Future<void> updateDeliveryAddress(DeliveryEntity deliveryAddress);
  Future<DeliveryEntity> getDeliveryAddresses();
}
