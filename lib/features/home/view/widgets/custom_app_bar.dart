import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopify/core/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Delivery address", style: TextStyles.blackMedium),
            Row(
              children: [
                Text(
                  "Salatiga City, Central Java ",
                  style: TextStyles.blackMedium,
                ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ],
        ),
        Spacer(),
        Row(
          children: [
            Icon(Ionicons.cart_outline, size: 24),
            Gap(15),
            Icon(FontAwesomeIcons.bell, size: 24),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
