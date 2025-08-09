import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/features/wishlist/presentation/providers/wishlist_notifier.dart';
import 'package:shopify/features/wishlist/presentation/widgets/no_products_state_view.dart';
import 'package:shopify/features/wishlist/presentation/widgets/wishlist_products_list.dart';

class WishlistViewBodyBlocConsumer extends StatelessWidget {
  const WishlistViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final wishlistNotifier = ref.watch(wishlistNotifierProvider);
        if (wishlistNotifier.isEmpty) {
          return const NoProductsStateView();
        }
        return WishlistProductsList(products: wishlistNotifier.toList());
      },
    );
  }
}
