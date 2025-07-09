import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/text_styles.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.image,
    required this.authMethod,
  });
  final String image;
  final String authMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 150.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image, height: 25.h),
            Gap(10),
            Text(
              authMethod,
              style: TextStyles.blackRegular.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
