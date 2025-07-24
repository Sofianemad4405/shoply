import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopify/core/utils/text_styles.dart';

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({
    super.key,
    required this.category,
    required this.image,
  });
  final String category;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.02,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        minTileHeight: 70,
        leading: SvgPicture.asset(image, height: 40, width: 40),
        title: Text(
          category,
          style: TextStyles.blackRegular.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}
