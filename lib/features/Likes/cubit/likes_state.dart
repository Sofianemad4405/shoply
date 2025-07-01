part of 'likes_cubit.dart';

abstract class LikesState {}

class LikesInitial extends LikesState {}

class LikesLoading extends LikesState {}

class LikesLoaded extends LikesState {
  final List<Product> likedProducts;
  LikesLoaded({required this.likedProducts});
}

class NoLikedProducts extends LikesState {
  final String message;
  NoLikedProducts({required this.message});
}

class LikesError extends LikesState {
  final String message;
  LikesError({required this.message});
}
