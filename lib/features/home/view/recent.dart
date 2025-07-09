import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Recent extends StatelessWidget {
  const Recent({
    super.key,
    required this.sortBy,
    required this.onIconTap,
    required this.onSelected,
    this.sorted = false,
  });

  final List<String> sortBy;
  final VoidCallback onIconTap;
  final bool sorted;

  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Recent Products",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        Spacer(),
        sorted
            ? IconButton(
              onPressed: onIconTap,
              icon: Icon(Icons.change_circle_rounded, color: Colors.grey),
            )
            : SizedBox.shrink(),

        // NEW PopupMenuButton here
        PopupMenuButton<String>(
          tooltip: "Sort By",
          onSelected: onSelected,
          itemBuilder:
              (context) =>
                  sortBy
                      .map(
                        (option) => PopupMenuItem<String>(
                          value: option,
                          child: Text(option),
                        ),
                      )
                      .toList(),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.sort, color: Colors.grey, size: 16),
              SizedBox(width: 8),
              Text(
                "Sort By",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
