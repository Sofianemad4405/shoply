import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GridOrList extends StatelessWidget {
  const GridOrList({super.key, required this.isGridView, required this.image});

  final bool isGridView;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: 34,
      decoration: BoxDecoration(
        color: isGridView ? Colors.white : Color(0xffEFF0F1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: SizedBox(
        height: 24,
        width: 24,
        child: Center(child: SvgPicture.asset(image)),
      ),
    );
  }
}
