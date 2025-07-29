import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/features/wishlist/presentation/cubit/cubit/wishlist_cubit.dart';

class WishListItem extends StatefulWidget {
  const WishListItem({super.key, required this.product});
  final ProductEntity product;

  @override
  State<WishListItem> createState() => _WishListItemState();
}

class _WishListItemState extends State<WishListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => context.push(
            Constants.kProductDetails,
            arguments: widget.product,
          ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image.network(widget.product.image ?? Constants.holderImage),
        title: Text(widget.product.name, style: TextStyles.blackBold),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.details,
              style: TextStyles.greyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Row(
              children: [
                Text(
                  "\$${widget.product.price.toString()}",
                  style: TextStyle(color: const Color(0xFF22C55E)),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      ...List.generate(
                        widget.product.rating!.toInt(),
                        (index) => SvgPicture.asset(
                          "assets/imgs/svgs/Star_rating.svg",
                          height: 15,
                          width: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            context.read<WishlistCubit>().toggleWishlistOptimistically(
              widget.product,
            );
          },
          child: Icon(Iconsax.heart, color: Colors.red),
        ),
      ),
    );
  }
}
