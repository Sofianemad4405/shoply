import 'package:flutter/material.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/widgets/product_card.dart';

class FeaturedProductsList extends StatelessWidget {
  const FeaturedProductsList({
    super.key,
    required this.products,
    required this.count,
    required this.inHome,
  });
  final List<ProductEntity> products;
  final int count;
  final bool inHome;
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
      itemCount: count,
      physics:
          inHome ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
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
