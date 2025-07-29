import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shopify/features/home/presentation/widgets/add_to_cart_button.dart';
import 'package:shopify/features/home/presentation/widgets/product_meta_data.dart';
import 'package:shopify/features/wishlist/presentation/cubit/cubit/wishlist_cubit.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
    required this.product,
    this.onAddToLikes,
    this.onRemoveFromLikes,
    this.isLiked,
  });
  final ProductEntity product;
  final void Function(Product product)? onAddToLikes;
  final void Function(Product product)? onRemoveFromLikes;
  final bool? isLiked;
  static String routeName = Constants.kProductDetails;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: TextStyles.blackBold),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.product.images?[selectedIndex] ?? Constants.holderImage,
                height: 350.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Gap(5),

              //select viewed image
              SizedBox(
                height: 70.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.product.images!.length, (
                    index,
                  ) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                selectedIndex == index
                                    ? Border.all(color: Colors.green)
                                    : null,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Image.network(
                            widget.product.images![index],
                            height: 60.h,
                            width: 60.w,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Gap(10),

              Row(
                children: [
                  SizedBox(
                    width: screenWidth * .6,
                    child: Text(
                      widget.product.name,
                      style: TextStyles.blackBold.copyWith(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Spacer(),
                  BlocBuilder<WishlistCubit, WishlistState>(
                    builder: (context, state) {
                      return IconButton(
                        icon: Icon(
                          context.read<WishlistCubit>().isInWishlist(
                                widget.product.id,
                              )
                              ? Iconsax.heart5
                              : Iconsax.heart,
                          color:
                              context.read<WishlistCubit>().isInWishlist(
                                    widget.product.id,
                                  )
                                  ? Colors.red
                                  : Colors.grey,
                        ),
                        onPressed: () {
                          context
                              .read<WishlistCubit>()
                              .toggleWishlistOptimistically(widget.product);
                        },
                      );
                    },
                  ),
                ],
              ),
              Text(
                widget.product.brand ?? "Unknown brand",
                style: TextStyles.greyRegular.copyWith(fontSize: 20),
              ),
              Gap(10),
              Text(
                widget.product.details,
                style: TextStyles.greyRegular.copyWith(fontSize: 16),
              ),
              Gap(10),
              ProductMetaData(product: widget.product),
              Gap(10),
              Center(child: AddToCartButton(product: widget.product)),
              Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
