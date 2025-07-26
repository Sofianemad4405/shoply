import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/features/profile/presentation/widgets/custom_list_tile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Gap(10),
            CustomAppBar(isCart: false),
            Gap(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xff22C55E), width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/imgs/my_images/photo_2025-06-09_19-35-12.jpg",
                      height: 75,
                      width: 75,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sofian Emad ", style: TextStyles.blackBold),
                      Gap(3),
                      Text(
                        "sofianemad98@gmaiil.com",
                        style: TextStyles.greyMedium,
                      ),
                      Gap(3),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(color: Color(0xff22C55E)),
                        ),
                      ),
                      Gap(10),
                    ],
                  ),
                ),
              ],
            ),
            Card(
              color: Colors.white,
              elevation: 0,
              child: Column(
                children: [
                  CustomListTile(
                    leadingIcon: "assets/imgs/svgs/my_orders.svg",
                    text: "My Orders",
                    traling: "assets/imgs/svgs/arrow.svg",
                    onTap: () {},
                  ),
                  CustomListTile(
                    leadingIcon: "assets/imgs/svgs/payment_method.svg",
                    text: "Payment Method",
                    traling: "assets/imgs/svgs/arrow.svg",
                    onTap: () {},
                  ),
                  CustomListTile(
                    leadingIcon: "assets/imgs/svgs/help_support.svg",
                    text: "Help & Support",
                    traling: "assets/imgs/svgs/arrow.svg",
                    onTap: () {},
                  ),
                  CustomListTile(
                    leadingIcon: "assets/imgs/svgs/settings.svg",
                    text: "Settings",
                    traling: "assets/imgs/svgs/arrow.svg",
                    onTap: () {},
                  ),
                  CustomListTile(
                    leadingIcon: "assets/imgs/svgs/log_out.svg",
                    text: "Logout",
                    onTap: () {},
                    isLogOut: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
