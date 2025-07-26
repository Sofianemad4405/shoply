import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/utils/text_styles.dart';

class ProductMetaData extends StatefulWidget {
  const ProductMetaData({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductMetaData> createState() => _ProductMetaDataState();
}

class _ProductMetaDataState extends State<ProductMetaData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: List.generate(widget.product.rating!.toInt(), (index) {
                return SvgPicture.asset(
                  "assets/imgs/svgs/Star_rating.svg",
                  height: 15,
                  width: 15,
                );
              }),
            ),
            Gap(10),
            Text(
              "${widget.product.rating.toString()} (${widget.product.reviews.length} reviews)",
              style: TextStyles.greyRegular.copyWith(fontSize: 16),
            ),
          ],
        ),
        Gap(10),
        Row(
          children: [
            Text(
              "\$${widget.product.price}",
              style: TextStyles.blackBold.copyWith(fontSize: 20),
            ),
            Gap(20),
            Text(
              "\$${widget.product.price + (widget.product.discountPercentage! / 100 * widget.product.price).round()}",
              style: TextStyle(
                color: Color(0xff6B7280),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(20),
            Container(
              height: 32.h,
              width: 80.8.w,
              decoration: BoxDecoration(
                color: Color(0xff21BD5A),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  "${widget.product.discountPercentage?.round()}% OFF",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(widget.product.tags!.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Container(
                height: 24.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 230, 231, 232),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.product.tags![index],
                      style: TextStyle(color: const Color(0xFF22C55E)),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        Gap(10),
        Row(
          children: [
            Container(
              height: 24.h,
              decoration: BoxDecoration(
                color: Color(0xffDCFCE7),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/imgs/svgs/Span.svg",
                      height: 8.h,
                      width: 8.w,
                    ),
                    Gap(5),
                    Text(
                      "${widget.product.stock} in stock",
                      style: TextStyle(
                        color: const Color(0xff16A34A),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
