import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/extention.dart';
import 'package:shopify/core/text_styles.dart';
import 'package:shopify/features/on_boarding/widgets/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.pushReplacement("/onBoarding");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/imgs/logo.svg"),
                  Gap(20),
                  Text(
                    "Shoply",
                    style: TextStyles.blackBold.copyWith(fontSize: 32),
                  ),
                  Gap(10),
                  Text(
                    "Smarter Shopping for Better Living\nDiscover More with Shoply",
                    style: TextStyle(color: Color(0xff16A34A)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SvgPicture.asset("assets/imgs/lastinsplash.svg"),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
