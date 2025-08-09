import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/features/cart/presentation/providers/cart_notifier.dart';
import 'package:shopify/features/cart/presentation/view/widgets/cart_products_list.dart';
import 'package:shopify/features/cart/presentation/view/widgets/proceed_to_checkout_button.dart';

class CartViewBody extends ConsumerWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProducts = ref.watch(cartNotifierProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Gap(10),
            CustomAppBar(isCart: false),
            Gap(10),
            if (cartProducts.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    "Your Shoply cart is empty",
                    style: TextStyles.blackBold.copyWith(fontSize: 24),
                  ),
                ),
              ),
            if (cartProducts.isNotEmpty) CartProductsList(),
            Gap(10),
            if (cartProducts.isNotEmpty)
              ProceedToCheckOutButton(
                text: "Proceed to Checkout",
                onTap: () => context.push(Constants.kCheckout),
              ),
          ],
        ),
      ),
    );
  }
}
