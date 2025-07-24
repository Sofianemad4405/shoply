part of 'category_products_cubit.dart';

abstract class CategoryProductsState {}

final class CategoryProductsInitial extends CategoryProductsState {}

final class CategoryProductsLoading extends CategoryProductsState {}

final class CategoryProductsError extends CategoryProductsState {
  final String message;

  CategoryProductsError({required this.message});
}

final class CategoryProductsLoaded extends CategoryProductsState {
  final List<Product> products;

  CategoryProductsLoaded({required this.products});
}
