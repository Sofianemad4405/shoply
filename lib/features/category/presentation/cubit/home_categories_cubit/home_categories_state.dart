part of 'home_categories_cubit.dart';

abstract class HomeCategoriesState {}

final class HomeCategoriesInitial extends HomeCategoriesState {}

final class HomeCategoriesLoading extends HomeCategoriesState {}

final class CategoriesLoaded extends HomeCategoriesState {
  final List<String> categories;

  CategoriesLoaded({required this.categories});
}

final class CategoriesError extends HomeCategoriesState {
  final String message;

  CategoriesError({required this.message});
}

final class KosomElbdan extends HomeCategoriesState {
  final String message;

  KosomElbdan({required this.message});
}
