import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/features/cart/presentation/providers/cart_notifier.dart';
import 'package:shopify/features/home/presentation/widgets/product_details.dart';
import 'package:shopify/features/wishlist/presentation/providers/wishlist_notifier.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: () {
          context.push(ProductDetails.routeName, arguments: product);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Image.network(
                    product.image ?? Constants.holderImage,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      return loadingProgress == null
                          ? child
                          : const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.error));
                    },
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final wishlistNotifier = ref.watch(
                        wishlistNotifierProvider,
                      );
                      final isInWishlist = wishlistNotifier.contains(product);
                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(wishlistNotifierProvider.notifier)
                              .toggleWishlist(product);
                        },
                        child: Icon(
                          isInWishlist ? Iconsax.heart : Iconsax.heart_copy,
                          size: 30,
                          color: isInWishlist ? Colors.red : Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  ...List.generate(
                    product.rating!.toInt(),
                    (index) => SvgPicture.asset(
                      "assets/imgs/svgs/Star_rating.svg",
                      height: 15,
                      width: 15,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "${product.rating}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            // Product Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                product.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Product Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                "\$${product.price}",
                style: TextStyle(
                  color: const Color(0xFF22C55E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Consumer(
                  builder: (context, ref, child) {
                    return AddButton(product: product);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddButton extends ConsumerWidget {
  const AddButton({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final isInCart = cartState.any((p) => p.id == product.id);

    return GestureDetector(
      onTap: () {
        ref
            .read(cartNotifierProvider.notifier)
            .toggleCartOptimistically(product);
      },
      child: Container(
        width: 137.62.w,
        height: 23.98.h,
        decoration: BoxDecoration(
          color: isInCart ? Colors.white : const Color(0xFF22C55E),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            isInCart ? 'remove from cart' : 'Add',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isInCart ? Colors.red : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
