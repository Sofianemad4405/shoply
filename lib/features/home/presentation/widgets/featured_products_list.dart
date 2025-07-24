import 'package:flutter/material.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/widgets/product_card.dart';

class FeaturedProductsList extends StatelessWidget {
  const FeaturedProductsList({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.65,
      ),
      itemCount: products.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          isInCart: false,
          isInWishlist: false,
        );
      },
    );
  }
}
