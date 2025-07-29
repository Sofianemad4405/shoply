import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopify/core/utils/text_styles.dart';

class CustomPopUpMenu extends StatefulWidget {
  const CustomPopUpMenu({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
    required this.image,
  });
  final String title;
  final List<PopupMenuItem<String>> items;
  final Function(String) onSelected;
  final String image;

  @override
  State<CustomPopUpMenu> createState() => _CustomPopUpMenuState();
}

class _CustomPopUpMenuState extends State<CustomPopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      itemBuilder: (context) => widget.items,
      onSelected: (value) {
        widget.onSelected(value);
      },
      child: Container(
        width: 74.22.w,
        height: 29.69.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(widget.image, height: 24),
              Text(
                widget.title,
                style: TextStyles.blackMedium.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
