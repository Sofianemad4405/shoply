import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/wishlist/domain/wishlist_repo.dart';

class AddProductToWishlist {
  final WishlistRepo wishlistRepo;

  AddProductToWishlist({required this.wishlistRepo});

  Future<void> call(ProductEntity product) async {
    await wishlistRepo.addProductToWishList(product);
  }
}
