import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/providers/providers.dart';
import 'package:shopify/features/home/domain/repos/home_repo.dart';

class HomeNotifier extends AsyncNotifier<List<ProductEntity>> {
  late final HomeRepo homeRepo;

  @override
  Future<List<ProductEntity>> build() async {
    homeRepo = ref.read(homeRepoProvider);
    return await _loadHomeProducts();
  }

  Future<List<ProductEntity>> _loadHomeProducts() async {
    final products = await homeRepo.getAllProducts();
    return products;
  }

  Future<void> refreshProducts() async {
    state = const AsyncLoading();
    state = AsyncData(await homeRepo.getAllProducts());
  }
}
