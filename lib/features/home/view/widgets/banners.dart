import 'package:flutter/material.dart';
import 'package:shopify/features/home/view/widgets/custom_banner.dart';

class Banners extends StatelessWidget {
  const Banners({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CustomBanner(image: "assets/imgs/banner1.jpg", isStartOrEnd: true),
          CustomBanner(image: "assets/imgs/banner2.jpg", isStartOrEnd: false),
          CustomBanner(image: "assets/imgs/banner3.jpg", isStartOrEnd: false),
        ],
      ),
    );
  }
}
