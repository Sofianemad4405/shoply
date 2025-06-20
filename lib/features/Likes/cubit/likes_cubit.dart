import 'package:bloc/bloc.dart';
import 'package:shopify/features/home/model/product_model.dart';

part 'likes_state.dart';

class LikesCubit extends Cubit<LikesState> {
  LikesCubit() : super(NoLikedProducts(message: "No liked products"));

  List<Product> likedProducts = [];
  Set<int> likedProductIds = {};

  void addToLiked(Product product) {
    likedProducts.add(product);
    likedProductIds.add(product.id);
    product.isLiked = true;
    emit(LikesLoaded(products: likedProducts));
  }

  void removeFromLiked(Product product) {
    likedProducts.remove(product);
    likedProductIds.remove(product.id);
    product.isLiked = false;
    if (likedProducts.isEmpty) {
      emit(NoLikedProducts(message: "No liked products"));
    } else {
      emit(LikesLoaded(products: likedProducts));
    }
  }

  void clearLikedProducts() {
    likedProducts.clear();
    likedProductIds.clear();
    emit(NoLikedProducts(message: "No liked products"));
  }
}
