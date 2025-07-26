import 'package:flutter/material.dart';
import 'package:shopify/core/utils/text_styles.dart';

class NoProductsStateView extends StatelessWidget {
  const NoProductsStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: Text(
          "No Products in Wishlist",
          style: TextStyles.blackBold.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
