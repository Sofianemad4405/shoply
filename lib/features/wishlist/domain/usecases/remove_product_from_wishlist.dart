import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/wishlist/domain/wishlist_repo.dart';

class RemoveProductFromWishlist {
  final WishlistRepo wishlistRepo;

  RemoveProductFromWishlist({required this.wishlistRepo});
  Future<void> call(ProductEntity product) async {
    await wishlistRepo.removeProductFromWishList(product);
  }
}
