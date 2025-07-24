import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({super.key, required this.product});
  final ProductEntity product;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool isAdded = false;
  @override
  void initState() {
    super.initState();
    isAdded = context.read<CartCubit>().isInCart(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isAdded) {
          context.read<CartCubit>().deleteProductFromCart(widget.product);
        } else {
          context.read<CartCubit>().addProductToCart(widget.product);
        }
        setState(() {
          isAdded = !isAdded;
        });
      },
      child: Container(
        width: 362.15,
        height: 47.98,
        decoration: ShapeDecoration(
          color: isAdded ? Color(0xffEFF0F1) : const Color(0xFF16A34A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/imgs/svgs/cart_logo.svg",
              colorFilter: ColorFilter.mode(
                isAdded ? Colors.red : Colors.white,
                BlendMode.srcIn,
              ),
            ),
            Gap(5),
            isAdded
                ? Text(
                  "Remove from Cart",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13.60,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.76,
                  ),
                )
                : Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.60,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.76,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
