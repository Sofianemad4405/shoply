import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/providers/providers.dart';
import 'package:shopify/features/category/domain/category_repo.dart';
import 'package:shopify/features/category/domain/usecases/fetch_category_products.dart';
import 'package:shopify/features/category/domain/usecases/fetch_category_products_sorted.dart';

class CategoryNotifier extends Notifier<AsyncValue<List<ProductEntity>>> {
  late final CategoryRepo categoryRepo;
  String sortMethod = 'name';
  String order = 'asc';
  @override
  AsyncValue<List<ProductEntity>> build() {
    categoryRepo = ref.read(categoryRepoProvider);
    return const AsyncValue.data([]);
  }

  Future<void> fetchCategoryProducts(String categoryName) async {
    state = const AsyncValue.loading();
    try {
      final fetchCategoryProducts = FetchCategoryProducts(
        categoryRepo: categoryRepo,
      );
      final products = await fetchCategoryProducts.call(categoryName);
      state = AsyncValue.data(products);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchCategoryProductsSorted({
    required String sortMethod,
    required String order,
    required String categoryName,
  }) async {
    state = const AsyncValue.loading();
    try {
      final fetchCategoryProductsSorted = FetchCategoryProductsSorted(
        categoryRepo: categoryRepo,
      );
      final products = await fetchCategoryProductsSorted.call(
        sortMethod,
        order,
        categoryName,
      );
      state = AsyncValue.data(products);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final categoryNotifierProvider =
    NotifierProvider<CategoryNotifier, AsyncValue<List<ProductEntity>>>(
      CategoryNotifier.new,
    );
