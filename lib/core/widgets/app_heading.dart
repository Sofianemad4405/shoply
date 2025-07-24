import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/text_styles.dart';

class AppHeading extends StatelessWidget {
  const AppHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset("assets/imgs/svgs/logo.svg", height: 40),
        Gap(5),
        Text("Shoply", style: TextStyles.blackBold.copyWith(fontSize: 24)),
      ],
    );
  }
}
