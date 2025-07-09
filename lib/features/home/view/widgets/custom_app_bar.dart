import 'package:flutter/material.dart';
import 'package:shopify/core/text_styles.dart';
import 'package:shopify/features/auth/presentation/view/sign_in_page_view.dart';

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
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SigninPageView()),
                  (route) => false,
                );
              },
              child: Icon(Icons.logout, size: 24),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
