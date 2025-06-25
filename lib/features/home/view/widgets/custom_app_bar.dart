import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopify/core/text_styles.dart';
import 'package:shopify/features/home/service/home_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.location});
  final String location;

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
                Text(location, style: TextStyles.blackMedium),
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
            GestureDetector(
              onTap: () {
                HomeService().getGeminiResponse(
                  "عايز اعرف مين كسب كاس العالم 2022",
                );
              },
              child: Icon(FontAwesomeIcons.bell, size: 24),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
