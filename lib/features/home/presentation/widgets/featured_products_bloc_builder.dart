import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/features/home/presentation/providers/home_providers.dart';
import 'package:shopify/features/home/presentation/widgets/featured_products_list.dart';

class FeaturedProducts extends ConsumerWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeProducts = ref.watch(homeProductsProvider);
    return homeProducts.when(
      data:
          (data) =>
              FeaturedProductsList(products: data, count: 8, inHome: true),
      error:
          (error, stackTrace) =>
              const Center(child: Text("Error fetching products")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
