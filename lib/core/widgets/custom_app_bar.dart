import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopify/core/utils/text_styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.isCart = false, this.title = "Shoply"});
  final bool? isCart;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset("assets/imgs/svgs/logo.svg", height: 32, width: 32),
        Text("  $title", style: TextStyles.blackBold.copyWith(fontSize: 20)),
      ],
    );
  }
}
