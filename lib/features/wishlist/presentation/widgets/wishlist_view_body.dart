import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/features/wishlist/presentation/widgets/wishlist_view_bidy_bloc_consumer.dart';

class WishlistViewBody extends StatelessWidget {
  const WishlistViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Gap(10),
          CustomAppBar(isCart: false),
          Gap(20),
          Expanded(child: const WishlistViewBodyBlocConsumer()),
        ],
      ),
    );
  }
}
