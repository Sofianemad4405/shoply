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
  Set<int> loadingProductIds = {};

  Set<int> cartProductIds = {};

  Future<void> init() async {
    emit(CartLoadingState());
    try {
      await getCartProducts();
      emit(CartLoadedState(cartProducts: cartProducts));
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
    emit(CartLoadingState());
    loadingProductIds.add(product.id);
    await RemoveProductFromCart(cartService).call(product);
    await getCartProducts();
    loadingProductIds.remove(product.id);
    emit(CartLoadedState(cartProducts: cartProducts));
  }

  Future<void> addProductToCart(ProductEntity product) async {
    emit(CartLoadingState());
    loadingProductIds.add(product.id);
    await AddProductToCart(cartService).call(product);
    await getCartProducts();
    loadingProductIds.remove(product.id);
    emit(CartLoadedState(cartProducts: cartProducts));
  }

  Future<void> increaseQuantity(ProductEntity product) async {
    // emit(CartLoadingState());
    if (product.quantity <= product.stock) {
      await IncreaseProductQuantity(cartService).call(product);
    }
    await getCartProducts();
    emit(CartLoadedState(cartProducts: cartProducts));
  }

  Future<void> decreaseProductQuantity(ProductEntity product) async {
    emit(CartLoadingState());
    if (product.quantity > 1) {
      await DecreaseProductQuantity(cartService).call(product);
    }
    await getCartProducts();
    emit(CartLoadedState(cartProducts: cartProducts));
  }

  Future<void> clearCart() async {
    emit(CartLoadingState());
    await ClearCartProducts(cartService).call();
    await getCartProducts();
    emit(CartLoadedState(cartProducts: []));
  }

  bool isInCart(int productId) => cartProductIds.contains(productId);
}
