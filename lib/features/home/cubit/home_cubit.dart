import 'package:bloc/bloc.dart';
import 'package:shopify/features/Likes/cubit/likes_cubit.dart';
import 'package:shopify/features/home/model/product_model.dart';
import 'package:shopify/features/home/service/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

  bool isAsc = true;

  Future<List<Product>> fetchAllProducts() async {
    emit(HomeLoading());
    try {
      final products = await HomeService().getAllProducts();
      for (var product in products) {
        product.isLiked = LikesCubit().likedProductIds.contains(product.id);
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
        product.isLiked = LikesCubit().likedProductIds.contains(product.id);
      }
      emit(HomeLoaded(products: products));
      return products;
    } catch (e) {
      emit(HomeError(message: e.toString()));
      return [];
    }
  }
}
