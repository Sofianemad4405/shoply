import 'package:shopify/features/home/model/product_model.dart';

abstract class CartStates {}

class NoProductsState extends CartStates {
  final String message;

  NoProductsState({required this.message});
}

class ProductsLoadedState extends CartStates {
  final List<Product> products;

  ProductsLoadedState({required this.products});
}
