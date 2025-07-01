import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
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
  final box = Hive.box<Product>('productsBox');

  List<Product> allProducts = [];

  Future<void> init() async {
    emit(HomeLoading());
    allProducts = await fetchAllProducts();
    emit(HomeLoaded(products: box.toMap()));
  }

  void loadLikes() {
    likesCubit.getLikedProducts(allProducts);
  }

  void loadCart() {
    log("ya alby ${cartCubit.cartBox.length.toString()}");
    cartCubit.getCartProducts(allProducts);
  }

  Future<List<Product>> fetchAllProducts() async {
    emit(HomeLoading());
    try {
      final products = await HomeService().getAllProducts();
      await saveProducts(products);
      allProducts = box.values.toList();
      emit(HomeLoaded(products: box.toMap()));
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
      await saveProducts(products);
      emit(HomeLoaded(products: box.toMap()));
      return products;
    } catch (e) {
      emit(HomeError(message: e.toString()));
      return [];
    }
  }

  Future<void> saveProducts(List<Product> products) async {
    for (var product in products) {
      await box.put(product.id, product);
    }
    allProducts = box.values.toList();
  }
}
