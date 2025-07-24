import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 362.15,
        height: 47.98,
        decoration: ShapeDecoration(
          color: const Color(0xFF16A34A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/imgs/svgs/cart_logo.svg"),
            Gap(5),
            Text(
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
