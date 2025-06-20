import 'package:bloc/bloc.dart';
import 'package:shopify/features/cart/cubits/cart_states.dart';
import 'package:shopify/features/home/model/product_model.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit(NoProductsState state)
    : super(NoProductsState(message: "Your cart is empty"));

  List<Product> cartProducts = [];

  void addProduct(Product product) {
    cartProducts.add(product);
    emit(ProductsLoadedState(products: cartProducts));
  }

  void removeProduct(Product product) {
    cartProducts.remove(product);
    if (cartProducts.isEmpty) {
      emit(NoProductsState(message: "Cart is empty"));
    } else {
      emit(ProductsLoadedState(products: cartProducts));
    }
  }

  void clearCart() {
    cartProducts.clear();
    emit(NoProductsState(message: "Cart is empty"));
  }
}
