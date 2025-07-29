import 'package:bloc/bloc.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shopify/features/checkout/domain/entities/delivery_entity.dart';
import 'package:shopify/features/checkout/domain/repo/checkout_repo.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({required this.cartCubit, required this.checkoutRepo})
    : super(CheckoutInitial());

  final CartCubit cartCubit;
  final CheckoutRepo checkoutRepo;
  List<ProductEntity> checkoutProducts = [];
  DeliveryEntity? deliveryAddress;
  bool didUserAddDeliveryAddress = false;

  void init() {
    emit(CheckoutLoading());
    for (var product in cartCubit.cartProducts) {
      checkoutProducts.add(product);
    }
    emit(CheckoutSuccess(checkoutProducts));
  }

  // void getCheckoutProducts() {
  //   checkoutProducts = cartCubit.cartProducts;
  // }

  DeliveryEntity? getDeliveryAddress() => deliveryAddress;

  void addProductsToCheckout(List<ProductEntity> products) {
    checkoutProducts = products;
    emit(CheckoutSuccess(checkoutProducts));
  }

  void clearCheckout() {
    checkoutProducts.clear();
    emit(CheckoutSuccess(checkoutProducts));
  }

  void addDeliveryAddress(DeliveryEntity deliveryAddress) {
    emit(CheckoutLoading());
    checkoutRepo.addDeliveryAddress(deliveryAddress);
    this.deliveryAddress = deliveryAddress;
    didUserAddDeliveryAddress = true;
    emit(DeliveryAddressUpdated(deliveryAddress));
  }

  void updateDeliveryAddress(DeliveryEntity deliveryAddress) {
    emit(CheckoutLoading());
    checkoutRepo.updateDeliveryAddress(deliveryAddress);
    this.deliveryAddress = deliveryAddress;
    didUserAddDeliveryAddress = true;
    emit(DeliveryAddressUpdated(deliveryAddress));
  }

  // void getDeliveryAddresses() {
  //   emit(CheckoutLoading());
  //   checkoutRepo
  //       .getDeliveryAddresses()
  //       .then((value) {
  //         emit(DeliveryInfoUpdated(value));
  //       })
  //       .catchError((error) {
  //         emit(CheckoutFailure(error.toString()));
  //       });
  // }
}
