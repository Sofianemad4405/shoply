import 'package:shopify/features/home/model/product_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<Product> cartProducts;
  CartLoadedState({required this.cartProducts});
}

class NoCartProductsState extends CartState {
  final String message;
  NoCartProductsState({required this.message});
}

class CartErrorState extends CartState {
  final String error;
  CartErrorState({required this.error});
}
