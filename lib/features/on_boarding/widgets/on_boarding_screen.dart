import 'package:flutter/material.dart';

import 'package:shopify/features/on_boarding/widgets/on_boarding_page_view_body.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: OnBoardingPageViewBody(),
        ),
      ),
    );
  }
}
