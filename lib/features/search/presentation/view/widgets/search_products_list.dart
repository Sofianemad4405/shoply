import 'package:flutter/material.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/widgets/product_card.dart';

class SearchProductsList extends StatelessWidget {
  const SearchProductsList({super.key, required this.products});
  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 4,
          childAspectRatio: screenWidth / (screenHeight / 1.35),
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.push(
                Constants.kProductDetails,
                arguments: products[index],
              );
            },
            child: ProductCard(product: products[index]),
          );
        },
      ),
    );
  }
}
