import 'package:flutter/material.dart';

class Recent extends StatelessWidget {
  const Recent({
    super.key,
    required this.onTap,
    required this.sortBy,
    required this.onIconTap,
    this.sorted = false,
  });

  final List<String> sortBy;
  final VoidCallback onTap;
  final VoidCallback onIconTap;
  final bool sorted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Recent Products",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
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
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Icon(Icons.filter_list, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                "Sort By",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
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
