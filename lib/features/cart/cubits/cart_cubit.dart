import 'package:bloc/bloc.dart';
import 'package:shopify/features/cart/cubits/cart_states.dart';
import 'package:shopify/features/home/model/product_model.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit(NoProductsState state)
    : super(NoProductsState(message: "Your cart is empty"));

  List<Product> cartProducts = [];
  Set<int> cartProductIds = {};
  Map<String, dynamic> userData = {};
  double totalPrice = 0;

  void addProduct(Product product) {
    cartProducts.add(product);
    cartProductIds.add(product.id);
    product.isAddedToCart = true;
    emit(ProductsLoadedState(products: cartProducts));
  }

  void removeProduct(Product product) {
    cartProducts.remove(product);
    cartProductIds.remove(product.id);
    product.isAddedToCart = false;
    if (cartProducts.isEmpty) {
      totalPrice = 0;
      emit(NoProductsState(message: "Cart is empty"));
    } else {
      emit(ProductsLoadedState(products: cartProducts));
    }
  }

  void clearCart() {
    cartProducts.clear();
    cartProductIds.clear();
    totalPrice = 0;
    emit(NoProductsState(message: "Cart is empty"));
  }
}
