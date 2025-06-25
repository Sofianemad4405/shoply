import 'package:bloc/bloc.dart';
import 'package:shopify/features/Likes/cubit/likes_cubit.dart';
import 'package:shopify/features/cart/cubits/cart_cubit.dart';
import 'package:shopify/features/home/model/product_model.dart';
import 'package:shopify/features/home/service/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LikesCubit likesCubit;
  final CartCubit cartCubit;
  HomeCubit({required this.cartCubit, required this.likesCubit})
    : super(HomeLoading());

  bool isAsc = true;

  Future<List<Product>> fetchAllProducts() async {
    emit(HomeLoading());
    try {
      final products = await HomeService().getAllProducts();
      for (var product in products) {
        product.isLiked = likesCubit.likedProductIds.contains(product.id);
        product.isAddedToCart = cartCubit.cartProductIds.contains(product.id);
      }
      emit(HomeLoaded(products: products));
      return products;
    } catch (e) {
      emit(HomeError(message: e.toString()));
      return [];
    }
  }

  Future<List<Product>> fetchProductsSorted(String sortBy, String order) async {
    emit(HomeLoading());
    try {
      final products = await HomeService().sortProductsByPrice(sortBy, order);
      for (var product in products) {
        product.isLiked = likesCubit.likedProductIds.contains(product.id);
        product.isAddedToCart = cartCubit.cartProductIds.contains(product.id);
      }
      emit(HomeLoaded(products: products));
      return products;
    } catch (e) {
      emit(HomeError(message: e.toString()));
      return [];
    }
  }
}
