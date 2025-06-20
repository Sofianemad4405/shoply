import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    super.key,
    required this.image,
    required this.isStartOrEnd,
  });

  final String image;
  final bool isStartOrEnd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isStartOrEnd ? 0 : 8,
        right: isStartOrEnd ? 8 : 0,
      ),
      child: Container(
        height: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(image),
        ),
      ),
    );
  }
}
