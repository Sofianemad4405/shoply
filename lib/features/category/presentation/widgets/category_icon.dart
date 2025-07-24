import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopify/core/utils/text_styles.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({super.key, required this.image, required this.category});
  final String image;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(image, height: 60),
        SizedBox(height: 8.h),
        Text(
          category,
          style: TextStyles.blackRegular.copyWith(fontSize: 16),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
