import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/home/presentation/providers/categories_notifier.dart';
import 'package:shopify/features/home/presentation/providers/home_products_notifier.dart';

final categoriesProvider =
    AsyncNotifierProvider<CategoriesNotifier, List<String>>(() {
      return CategoriesNotifier();
    });

final homeProductsProvider =
    AsyncNotifierProvider<HomeNotifier, List<ProductEntity>>(() {
      return HomeNotifier();
    });
