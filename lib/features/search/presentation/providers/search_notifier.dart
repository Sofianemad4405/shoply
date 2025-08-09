import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/search/data/repos/search_repo_implementation.dart';

class SearchNotifier extends StateNotifier<AsyncValue<List<ProductEntity>>> {
  SearchNotifier(super.state, this.searchService);
  final SearchRepoImplementation searchService;
  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }
    state = const AsyncValue.loading();
    try {
      final results = await searchService.searchProduct(query);
      state = AsyncValue.data(results);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
