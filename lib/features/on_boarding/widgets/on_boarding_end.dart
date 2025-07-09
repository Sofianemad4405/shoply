import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingEnd extends StatelessWidget {
  const OnBoardingEnd({super.key, required this.onTap, required this.position});

  final void Function()? onTap;
  final double position;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DotsIndicator(
          dotsCount: 3,
          decorator: DotsDecorator(
            activeColor: Color(0xff16A34A),
            color: Color(0xffE5E7EB),
            activeSize: Size(12, 12),
            size: Size(12, 12),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          position: position,
        ),
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: SvgPicture.asset("assets/imgs/on_boarding_button.svg"),
        ),
      ],
    );
  }
}
