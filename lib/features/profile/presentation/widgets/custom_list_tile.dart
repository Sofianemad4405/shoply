import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.leadingIcon,
    required this.text,
    this.traling,
    required this.onTap,
    this.isLogOut = false,
  });
  final String leadingIcon;
  final String text;
  final String? traling;
  final VoidCallback onTap;
  final bool isLogOut;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(leadingIcon),
      title: Text(
        text,
        style: TextStyle(color: isLogOut ? Color(0xffEF4444) : Colors.black),
      ),
      trailing: traling == null ? null : SvgPicture.asset(traling!),
      onTap: onTap,
    );
  }
}
