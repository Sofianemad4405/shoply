import 'package:flutter/material.dart';
import 'package:shopify/features/wishlist/presentation/widgets/wishlist_view_body.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: const WishlistViewBody()));
  }
}
