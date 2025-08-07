import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});
  static const String routeName = "help_and_support";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(isCart: false),
            Gap(20),
            Text("Help & Support", style: TextStyles.blackBold),
            Gap(20),
            Text(
              "If you have any questions or need assistance, please don't hesitate to contact us. We're here to help!",
              style: TextStyles.blackMedium,
            ),
          ],
        ),
      ),
    );
  }
}
