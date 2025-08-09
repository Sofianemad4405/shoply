import 'package:shopify/features/wishlist/domain/wishlist_repo.dart';

class GetWishlistProducts {
  final WishlistRepo wishlistRepo;

  GetWishlistProducts({required this.wishlistRepo});

  Future<void> call() async {
    await wishlistRepo.getWishListProducts();
  }
}
