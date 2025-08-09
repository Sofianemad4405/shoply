import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/features/cart/presentation/providers/cart_notifier.dart';
import 'package:shopify/features/wishlist/presentation/providers/wishlist_notifier.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    // final wishlist = ref.watch(wishlistProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: Image.network(product.image ?? Constants.holderImage),
          title: Text(
            product.name,
            style: TextStyles.blackBold.copyWith(fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.details,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    "\$${product.price}",
                    style: TextStyle(color: const Color(0xFF22C55E)),
                  ),
                  Spacer(),
                  Consumer(
                    builder: (context, ref, child) {
                      final wishlist = ref.watch(wishlistNotifierProvider);
                      final isInWishlist = wishlist.any(
                        (p) => p.id == product.id,
                      );
                      return IconButton(
                        icon: Icon(
                          isInWishlist ? Iconsax.heart5 : Iconsax.heart,
                          color: isInWishlist ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          ref
                              .read(wishlistNotifierProvider.notifier)
                              .toggleWishlist(product);
                        },
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final cart = ref.watch(cartNotifierProvider);
                      final isInCart = cart.any((p) => p.id == product.id);
                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .toggleCartOptimistically(product);
                        },
                        child:
                            !isInCart
                                ? SvgPicture.asset(
                                  "assets/imgs/svgs/cart.svg",
                                  colorFilter: ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.srcIn,
                                  ),
                                )
                                : SvgPicture.asset(
                                  "assets/imgs/svgs/trash.svg",
                                  colorFilter: ColorFilter.mode(
                                    Colors.red,
                                    BlendMode.srcIn,
                                  ),
                                ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
