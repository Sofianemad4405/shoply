import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/core/providers/providers.dart';
import 'package:shopify/features/home/domain/repos/home_repo.dart';

class CategoriesNotifier extends AsyncNotifier<List<String>> {
  late final HomeRepo homeRepo;
  @override
  Future<List<String>> build() {
    homeRepo = ref.read(homeRepoProvider);
    return _loadCategories();
  }

  Future<List<String>> _loadCategories() {
    final categories = homeRepo.getCategories();
    return categories;
  }

  Future<void> refreshCategories() async {
    state = const AsyncLoading();
    state = AsyncData(await _loadCategories());
  }
}
