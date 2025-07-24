import 'package:flutter/material.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/core/widgets/product_card.dart';
import 'package:shopify/features/home/presentation/widgets/product_details.dart';

class SearchProductsList extends StatelessWidget {
  const SearchProductsList({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 4,
          childAspectRatio: .65,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ProductDetails(product: products[index]),
                ),
              );
            },
            child: ProductCard(
              product: products[index],
              isInCart: false,
              isInWishlist: false,
            ),
          );
        },
      ),
    );
  }
}
