import 'package:bloc/bloc.dart';
import 'package:shopify/features/cart/cubits/cart_states.dart';
import 'package:hive/hive.dart';
import 'package:shopify/features/home/model/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(NoCartProductsState(message: "Cart is empty"));

  // first open box
  final cartBox = Hive.box<bool>('cartBox');

  bool isProductInCart(int productId) {
    return cartBox.containsKey(productId);
  }

  void getCartProducts(List<Product> allProducts) {
    emit(CartLoadingState());
    try {
      final cartIds = cartBox.keys.cast<int>().toSet();
      if (cartIds.isEmpty) {
        emit(NoCartProductsState(message: "Cart is empty"));
      } else {
        final cartProducts =
            allProducts
                .where((product) => cartIds.contains(product.id))
                .toList();
        emit(CartLoadedState(cartProducts: cartProducts));
      }
    } catch (e) {
      emit(CartErrorState(error: e.toString()));
    }
  }

  void addProduct(Product product, List<Product> allProducts) async {
    emit(CartLoadingState());
    try {
      await cartBox.put(product.id, true);

      product.isAddedToCart = true;
      final cartIds = cartBox.keys.cast<int>().toSet();
      final cartProducts =
          allProducts.where((p) => cartIds.contains(p.id)).toList();
      emit(CartLoadedState(cartProducts: cartProducts));
    } catch (e) {
      emit(CartErrorState(error: e.toString()));
    }
  }

  void removeProduct(Product product, List<Product> allProducts) async {
    emit(CartLoadingState());
    try {
      await cartBox.delete(product.id);
      product.isAddedToCart = false;

      final cartIds = cartBox.keys.cast<int>().toSet();
      final cartProducts =
          allProducts.where((p) => cartIds.contains(p.id)).toList();

      if (cartProducts.isEmpty) {
        emit(NoCartProductsState(message: "Cart is empty"));
      } else {
        emit(CartLoadedState(cartProducts: cartProducts));
      }
    } catch (e) {
      emit(CartErrorState(error: e.toString()));
    }
  }

  void clearCart() async {
    emit(CartLoadingState());
    try {
      await cartBox.clear();
      emit(NoCartProductsState(message: "Cart is empty"));
    } catch (e) {
      emit(CartErrorState(error: e.toString()));
    }
  }
}
