import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/providers/providers.dart';
import 'package:shopify/features/cart/domain/repo/cart_repo.dart';
import 'package:shopify/features/cart/domain/use_cases/add_product_to_cart.dart';
import 'package:shopify/features/cart/domain/use_cases/clear_cart_products.dart';
import 'package:shopify/features/cart/domain/use_cases/decrease_product_quantity.dart';
import 'package:shopify/features/cart/domain/use_cases/increase_product_quantity.dart';
import 'package:shopify/features/cart/domain/use_cases/remove_product_from_cart.dart';

class CartNotifier extends Notifier<Set<ProductEntity>> {
  late final CartRepo cartRepo;

  @override
  Set<ProductEntity> build() {
    cartRepo = ref.read(cartRepoProvider);
    _loadCartProducts();
    return {};
  }

  Future<void> _loadCartProducts() async {
    final products = await cartRepo.getCartProducts();
    state = products.toSet();
  }

  void toggleCartOptimistically(ProductEntity product) {
    if (state.contains(product)) {
      removeProductFromCart(product);
    } else {
      addProductToCart(product);
    }
    return;
  }

  void removeProductFromCart(ProductEntity product) {
    final removeProductFromCart = RemoveProductFromCart(cartRepo);
    removeProductFromCart.call(product);
    state = state.where((p) => p.id != product.id).toSet();
  }

  void addProductToCart(ProductEntity product) {
    final addProductToCart = AddProductToCart(cartRepo);
    addProductToCart.call(product);
    state = {...state, product};
  }

  void clearCart() {
    final clearCart = ClearCartProducts(cartRepo);
    clearCart.call();
    state = {};
  }

  void increaseQuantity(ProductEntity product) {
    final increaseQuantity = IncreaseProductQuantity(cartRepo);
    increaseQuantity.call(product);
    state = {...state};
  }

  void decreaseQuantity(ProductEntity product) {
    final decreaseQuantity = DecreaseProductQuantity(cartRepo);
    decreaseQuantity.call(product);
  }

  bool isInCart(int productId) {
    return state.any((product) => product.id == productId);
  }

  int getCartProductsCount() {
    return state.length;
  }
}

final cartNotifierProvider = NotifierProvider<CartNotifier, Set<ProductEntity>>(
  CartNotifier.new,
);
