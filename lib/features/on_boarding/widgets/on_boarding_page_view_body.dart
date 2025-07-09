import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/extention.dart';
import 'package:shopify/features/on_boarding/widgets/on_boarding_center.dart';
import 'package:shopify/features/on_boarding/widgets/on_boarding_end.dart';
import 'package:shopify/core/app_heading.dart';

class OnBoardingPageViewBody extends StatefulWidget {
  const OnBoardingPageViewBody({super.key});

  @override
  State<OnBoardingPageViewBody> createState() => _OnBoardingPageViewBodyState();
}

class _OnBoardingPageViewBodyState extends State<OnBoardingPageViewBody> {
  PageController controller = PageController();
  double currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        AppHeading(),
        Spacer(),
        Expanded(
          flex: 3,
          child: PageView(
            controller: controller,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page.toDouble();
              });
            },
            children: [
              OnBoardingCenter(
                image: "assets/imgs/on_boarding_1.svg",
                title: "Browse Products",
                description:
                    "Discover thousands of products with\nour intuitive browsing experience",
              ),
              OnBoardingCenter(
                image: "assets/imgs/on_boarding_2.svg",
                title: "Fast Checkout",
                description:
                    "Complete your purchase in seconds\nwith our streamlined checkout process",
              ),
              OnBoardingCenter(
                image: "assets/imgs/on_boarding_3.svg",
                title: "Secure Payments",
                description:
                    "Shop with confidence knowing your\ntransactions are always protected",
              ),
            ],
          ),
        ),
        Spacer(),
        OnBoardingEnd(
          onTap: () {
            controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
            setState(() {
              currentPage = controller.page!;
            });
            if (currentPage == 2) {
              context.pushReplacement("/signin");
            }
          },
          position: currentPage,
        ),
        Gap(20),
      ],
    );
  }
}
