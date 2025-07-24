import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/cart/data/repos/cart_repo_impl.dart';
import 'package:shopify/features/cart/domain/use_cases/add_product_to_cart.dart';
import 'package:shopify/features/cart/domain/use_cases/clear_cart_products.dart';
import 'package:shopify/features/cart/domain/use_cases/decrease_product_quantity.dart';
import 'package:shopify/features/cart/domain/use_cases/increase_product_quantity.dart';
import 'package:shopify/features/cart/domain/use_cases/remove_product_from_cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.cartService}) : super(CartInitial());

  final CartRepoImpl cartService;
  List<ProductEntity> cartProducts = [];
  Set<int> cartProductIds = {};

  Future<void> init() async {
    emit(CartLoadingState());
    try {
      await getCartProducts();
      emit(
        cartProducts.isEmpty
            ? CartNoProductsState()
            : CartLoadedState(cartProducts: cartProducts),
      );
      log("Cart Products Loaded");
    } catch (e) {
      emit(CartErrorState(error: e.toString()));
    }
  }

  Future<void> getCartProducts() async {
    cartProducts = await cartService.getCartProducts();
    cartProductIds = cartProducts.map((e) => e.id).toSet();
  }

  double get subTotal {
    return cartProducts.fold(
      0,
      (sum, product) => sum + product.price * product.quantity,
    );
  }

  Future<void> deleteProductFromCart(ProductEntity product) async {
    final index = cartProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      cartProducts.removeAt(index);
      emit(CartLoadedState(cartProducts: cartProducts));
    }
    RemoveProductFromCart(cartService).call(product);
    await getCartProducts();
    emit(
      cartProducts.isEmpty
          ? CartNoProductsState()
          : CartLoadedState(cartProducts: cartProducts),
    );
  }

  Future<void> addProductToCart(ProductEntity product) async {
    AddProductToCart(cartService).call(product);
    await getCartProducts();
    emit(CartLoadedState(cartProducts: cartProducts));
  }

  Future<void> increaseQuantity(ProductEntity product) async {
    final index = cartProducts.indexWhere((p) => p.id == product.id);
    if (index != -1 &&
        cartProducts[index].quantity < cartProducts[index].stock) {
      cartProducts[index] = cartProducts[index].copyWith(
        quantity: cartProducts[index].quantity + 1,
      );

      emit(CartLoadedState(cartProducts: cartProducts));

      await IncreaseProductQuantity(cartService).call(product);

      await getCartProducts();
      emit(CartLoadedState(cartProducts: cartProducts));
    }
  }

  Future<void> decreaseProductQuantity(ProductEntity product) async {
    final index = cartProducts.indexWhere((p) => p.id == product.id);
    if (index != -1 && cartProducts[index].quantity > 1) {
      cartProducts[index] = cartProducts[index].copyWith(
        quantity: cartProducts[index].quantity - 1,
      );

      emit(CartLoadedState(cartProducts: List.from(cartProducts)));

      await DecreaseProductQuantity(cartService).call(product);

      await getCartProducts();
      emit(CartLoadedState(cartProducts: cartProducts));
    }
    // await getCartProducts();
    // emit(CartLoadedState(cartProducts: cartProducts));
  }

  Future<void> clearCart() async {
    await ClearCartProducts(cartService).call();
    await getCartProducts();
    emit(CartLoadedState(cartProducts: []));
  }

  bool isInCart(int productId) => cartProductIds.contains(productId);
}
