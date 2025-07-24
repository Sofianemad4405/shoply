import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/features/search/data/repos/search_implementation.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  final searchService = SearchImplementation();

  Future<void> search(String query) async {
    emit(SearchLoading());
    try {
      log("fetching search products");
      final products = await searchService.searchProduct(query);
      if (products.isEmpty) {
        emit(
          SearchSuccessAndThereAreNoProducts(
            message: "No result found for '$query'",
          ),
        );
      } else {
        emit(SearchSuccessAndThereAreProducts(products: products));
      }
    } catch (e) {
      emit(SearchFailure(message: "Error searching product: $e"));
    }
  }
}
