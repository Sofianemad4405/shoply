part of 'likes_cubit.dart';

abstract class LikesState {}

class NoLikedProducts extends LikesState {
  NoLikedProducts({required this.message});
  final String message;
}

class LikesLoading extends LikesState {}

class LikesLoaded extends LikesState {
  LikesLoaded({required this.products});
  final List<Product> products;
}

class LikesError extends LikesState {
  LikesError({required this.message});
  final String message;
}
