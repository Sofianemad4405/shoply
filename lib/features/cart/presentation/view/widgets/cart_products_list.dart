import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/features/cart/presentation/providers/cart_notifier.dart';

class CartProductsList extends ConsumerWidget {
  const CartProductsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final products = ref.watch(cartNotifierProvider);
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(thickness: 0.5),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products.elementAt(index);
          return GestureDetector(
            onTap:
                () =>
                    context.push(Constants.kProductDetails, arguments: product),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image.network(product.image ?? Constants.holderImage),
              title: Text(product.name, style: TextStyles.blackSemiBold),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${product.price}",
                    style: TextStyles.blackBold.copyWith(
                      color: Color(0xff22C55E),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          cartNotifier.decreaseQuantity(product);
                          log(product.quantity.toString());
                        },
                        child: SvgPicture.asset("assets/imgs/svgs/minus.svg"),
                      ),
                      Gap(10),
                      Text(
                        "${product.quantity}",
                        style: TextStyles.blackSemiBold,
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: () {
                          cartNotifier.increaseQuantity(product);
                          log(product.quantity.toString());
                        },
                        child: SvgPicture.asset("assets/imgs/svgs/plus.svg"),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          cartNotifier.removeProductFromCart(product);
                          log(product.quantity.toString());
                        },
                        child: SvgPicture.asset(
                          "assets/imgs/svgs/trash.svg",
                          colorFilter: ColorFilter.mode(
                            Colors.red,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
