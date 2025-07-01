import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopify/features/home/model/product_model.dart';

part 'likes_state.dart';

class LikesCubit extends Cubit<LikesState> {
  LikesCubit() : super(NoLikedProducts(message: "No liked products"));

  final likedBox = Hive.box<bool>("likedBox");

  bool isProductLiked(int productId) {
    return likedBox.containsKey(productId);
  }

  void getLikedProducts(List<Product> allProducts) {
    emit(LikesLoading());
    try {
      final likedIds = likedBox.keys.cast<int>().toSet();

      if (likedIds.isEmpty) {
        emit(NoLikedProducts(message: "No liked products"));
      } else {
        final likedProducts =
            allProducts
                .where((product) => likedIds.contains(product.id))
                .toList();
        emit(LikesLoaded(likedProducts: likedProducts));
      }
    } catch (e) {
      emit(LikesError(message: e.toString()));
    }
  }

  void addProductToLikes(Product product, List<Product> allProducts) async {
    emit(LikesLoading());
    try {
      await likedBox.put(product.id, true);
      product.isLiked = true;

      final likedIds = likedBox.keys.cast<int>().toSet();
      final likedProducts =
          allProducts.where((p) => likedIds.contains(p.id)).toList();
      emit(LikesLoaded(likedProducts: likedProducts));
    } catch (e) {
      emit(LikesError(message: e.toString()));
    }
  }

  void removeFromLiked(Product product, List<Product> allProducts) async {
    try {
      await likedBox.delete(product.id);
      product.isLiked = false;

      final likedIds = likedBox.keys.cast<int>().toSet();

      if (likedIds.isEmpty) {
        emit(NoLikedProducts(message: "No liked products"));
      } else {
        final likedProducts =
            allProducts.where((p) => likedIds.contains(p.id)).toList();
        emit(LikesLoaded(likedProducts: likedProducts));
      }
    } catch (e) {
      emit(LikesError(message: e.toString()));
    }
  }

  void clearLikedProducts() {
    likedBox.clear();
    emit(NoLikedProducts(message: "No liked products"));
  }
}
