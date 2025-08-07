import 'package:flutter/material.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/wishlist/presentation/widgets/wishlist_item.dart';

class WishlistProductsList extends StatelessWidget {
  const WishlistProductsList({super.key, required this.products});
  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(thickness: 0.8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return WishListItem(product: products[index]);
      },
    );
  }
}
