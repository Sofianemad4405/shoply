part of 'home_cubit.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<Product> products;
  HomeLoaded({required this.products});
}

final class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
