import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/providers/providers.dart';
import 'package:shopify/features/cart/domain/use_cases/remove_product_from_cart.dart';
import 'package:shopify/features/wishlist/domain/usecases/add_product_to_wishlist.dart';
import 'package:shopify/features/wishlist/domain/usecases/remove_product_from_wishlist.dart';
import 'package:shopify/features/wishlist/domain/wishlist_repo.dart';

class WishlistNotifier extends Notifier<Set<ProductEntity>> {
  late WishlistRepo wishlistRepo;
  @override
  Set<ProductEntity> build() {
    wishlistRepo = ref.read(wishlistRepoProvider);
    return {};
  }

  void toggleWishlist(ProductEntity product) {
    if (state.contains(product)) {
      removeProductFromWishlist(product);
    } else {
      addProductToWishlist(product);
    }
  }

  void addProductToWishlist(ProductEntity product) {
    final addProduct = AddProductToWishlist(wishlistRepo: wishlistRepo);
    addProduct.call(product);
    state = {...state, product};
  }

  void removeProductFromWishlist(ProductEntity product) {
    final removeProduct = RemoveProductFromWishlist(wishlistRepo: wishlistRepo);
    removeProduct.call(product);
    state = state.where((p) => p.id != product.id).toSet();
  }

  bool isInWishlist(int productId) {
    return state.any((product) => product.id == productId);
  }
}

final wishlistNotifierProvider =
    NotifierProvider<WishlistNotifier, Set<ProductEntity>>(
      WishlistNotifier.new,
    );
