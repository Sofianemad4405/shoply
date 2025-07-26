import 'package:bloc/bloc.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/wishlist/data/repo/wishlist_repo_implementation.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit(this.wishlistService) : super(WishlistInitial());

  final WishlistRepoImpl wishlistService;
  List<ProductEntity> wishlistProducts = [];

  Future<void> init() async {
    if (wishlistProducts.isEmpty) {
      emit(NoProductsInWIshlistState());
    } else {
      emit(WishlistProductsLoadingState());
      await getWishlistProducts();
    }
  }

  Future<void> getWishlistProducts() async {
    try {
      wishlistProducts = await wishlistService.getWishListProducts();
      emit(WishlistProductsLoadedState(wishlistProducts: wishlistProducts));
    } catch (e) {
      emit(ErrorAddingProductToWishlistState(errorMessage: e.toString()));
    }
  }

  Future<void> addProductToWishlist(ProductEntity product) async {
    try {
      await wishlistService.addProductToWishList(product);
      getWishlistProducts();
    } catch (e) {
      emit(ErrorAddingProductToWishlistState(errorMessage: e.toString()));
    }
  }

  void toggleWishlistOptimistically(ProductEntity product) {
    if (isInWishlist(product.id)) {
      wishlistProducts.removeWhere((item) => item.id == product.id);
      emit(WishlistProductsLoadedState(wishlistProducts: wishlistProducts));
      removeProductFromWishlist(product);
    } else {
      wishlistProducts.add(product);
      emit(WishlistProductsLoadedState(wishlistProducts: wishlistProducts));
      addProductToWishlist(product);
    }
    if (wishlistProducts.isEmpty) {
      emit(NoProductsInWIshlistState());
    }
  }

  Future<void> removeProductFromWishlist(ProductEntity product) async {
    try {
      await wishlistService.removeProductFromWishList(product);
      getWishlistProducts();
    } catch (e) {
      emit(ErrorAddingProductToWishlistState(errorMessage: e.toString()));
    }
  }

  Future<void> clearWishlist() async {
    try {
      await wishlistService.clearWishList();
      getWishlistProducts();
    } catch (e) {
      emit(ErrorAddingProductToWishlistState(errorMessage: e.toString()));
    }
  }

  bool isInWishlist(int productId) {
    return wishlistProducts.any((product) => product.id == productId);
  }
}
