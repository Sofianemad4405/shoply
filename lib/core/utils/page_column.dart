import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageColumn extends StatelessWidget {
  const PageColumn({
    super.key,
    required this.currentIndex,
    required this.image,
    required this.pageName,
    required this.pageIndex,
  });

  final int currentIndex;
  final int pageIndex;
  final String image;
  final String pageName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          image,
          colorFilter: ColorFilter.mode(
            currentIndex == pageIndex ? Colors.green : Colors.grey,
            BlendMode.srcIn,
          ),
        ),
        Text(pageName),
      ],
    );
  }
}
