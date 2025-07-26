part of 'wishlist_cubit.dart';

abstract class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistProductsLoadingState extends WishlistState {}

final class NoProductsInWIshlistState extends WishlistState {}

final class WishlistProductsLoadedState extends WishlistState {
  final List<ProductEntity> wishlistProducts;
  WishlistProductsLoadedState({required this.wishlistProducts});
}

final class ErrorAddingProductToWishlistState extends WishlistState {
  final String errorMessage;
  ErrorAddingProductToWishlistState({required this.errorMessage});
}
