import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopify/features/home/presentation/widgets/custom_banner.dart';

class Banners extends StatelessWidget {
  const Banners({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.25,
        viewportFraction: 1,
        autoPlay: true,
        reverse: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInOut,
        enlargeCenterPage: true,
        aspectRatio: 3 / 4,
        enableInfiniteScroll: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
      items: [
        CustomBanner(image: "assets/imgs/banners/banner1.jpg"),
        CustomBanner(image: "assets/imgs/banners/banner2.jpg"),
        CustomBanner(image: "assets/imgs/banners/banner3.jpg"),
      ],
    );
  }
}
