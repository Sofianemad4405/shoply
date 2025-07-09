import 'package:flutter/material.dart';

class OrRow extends StatelessWidget {
  const OrRow({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
      ],
    );
  }
}
