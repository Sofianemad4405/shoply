part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState {}

final class CartAddingState extends CartState {}

final class CartNoProductsState extends CartState {}

final class CartRemovingState extends CartState {}

final class CartQuantityUpdate extends CartState {}

class CartLoadedState extends CartState {
  final List<ProductEntity> cartProducts;

  CartLoadedState({required this.cartProducts});

  CartLoadedState copyWith({List<ProductEntity>? cartProducts}) {
    return CartLoadedState(cartProducts: cartProducts ?? this.cartProducts);
  }
}

final class CartErrorState extends CartState {
  final String error;
  CartErrorState({required this.error});
}
