import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shopify/features/home/presentation/widgets/product_details.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.isInWishlist,
    required this.isInCart,
  });
  final ProductEntity product;
  final bool isInWishlist;
  final bool isInCart;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: () {
          context.push(ProductDetails.routeName, arguments: widget.product);
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
                    widget.product.image ?? Constants.holderImage,
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
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      widget.isInWishlist ? Iconsax.heart : Iconsax.heart_copy,
                      size: 30,
                      color: widget.isInWishlist ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  SizedBox(width: 8),
                  Text(
                    "${widget.product.rating}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            // Product Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                widget.product.name,
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
                "\$${widget.product.price}",
                style: TextStyle(
                  color: const Color(0xFF22C55E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    final cartCubit = context.read<CartCubit>();
                    final isInCart = cartCubit.isInCart(widget.product.id);
                    return AddButton(
                      product: widget.product,
                      onTap: () {
                        if (isInCart) {
                          cartCubit.deleteProductFromCart(widget.product);
                        } else {
                          cartCubit.addProductToCart(widget.product);
                        }
                      },
                      isAdded: isInCart,
                    );
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

class AddButton extends StatefulWidget {
  const AddButton({
    super.key,
    required this.product,
    required this.isAdded,
    required this.onTap,
  });
  final bool isAdded;
  final ProductEntity product;
  final VoidCallback onTap;

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 137.62.w,
        height: 23.98.h,
        decoration: BoxDecoration(
          color: widget.isAdded ? Colors.white : const Color(0xFF22C55E),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            widget.isAdded ? 'remove from cart' : 'Add',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.isAdded ? Colors.red : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
