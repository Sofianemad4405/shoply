part of 'checkout_cubit.dart';

abstract class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutSuccess extends CheckoutState {
  final List<ProductEntity> checkoutProducts;
  CheckoutSuccess(this.checkoutProducts);
}

final class CheckoutFailure extends CheckoutState {
  final String error;
  CheckoutFailure(this.error);
}

final class DeliveryAddressUpdated extends CheckoutState {
  final DeliveryEntity deliveryInfo;
  DeliveryAddressUpdated(this.deliveryInfo);
}
