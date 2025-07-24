import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/prefs.dart';
import 'package:shopify/core/utils/text_styles.dart';

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
      if (Prefs.getBool(Constants.kIsOnBoardingSeen) == true &&
          Prefs.getBool(Constants.kIsLoggedIn) == true) {
        context.pushReplacement(Constants.kRoot);
      } else if (Prefs.getBool(Constants.kIsOnBoardingSeen) == true &&
          Prefs.getBool(Constants.kIsLoggedIn) == false) {
        context.pushReplacement(Constants.kSignIn);
      } else if (Prefs.getBool(Constants.kIsOnBoardingSeen) == false) {
        context.pushReplacement(Constants.kOnBoarding);
      }
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
                  SvgPicture.asset("assets/imgs/svgs/logo.svg"),
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
            SvgPicture.asset("assets/imgs/svgs/lastinsplash.svg"),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
