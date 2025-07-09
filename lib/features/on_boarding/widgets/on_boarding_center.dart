import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/text_styles.dart';

class OnBoardingCenter extends StatelessWidget {
  const OnBoardingCenter({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(50),
        SvgPicture.asset(image, height: 65),
        Gap(40),
        Text(title, style: TextStyles.blackBold.copyWith(fontSize: 24)),
        Gap(40),
        Text(
          description,
          style: TextStyles.blackRegular.copyWith(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
