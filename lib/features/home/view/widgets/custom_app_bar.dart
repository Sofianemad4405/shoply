import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopify/core/text_styles.dart';
import 'package:shopify/features/auth/cubit/auth_cubit.dart';
import 'package:shopify/features/auth/view/sign_up_page.dart';
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
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
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
