import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomTextInputField extends StatefulWidget {
  const CustomTextInputField({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });
  final TextEditingController controller;
  final Function(String) onSubmitted;

  @override
  State<CustomTextInputField> createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        setState(() {});
      },
      onSubmitted: widget.onSubmitted,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: 'Search here ...',
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: Icon(Ionicons.search, color: Colors.grey.shade400),
        suffixIcon:
            widget.controller.text.isEmpty
                ? null
                : GestureDetector(
                  onTap: () => widget.controller.clear(),
                  child: Icon(Ionicons.close, color: Colors.grey.shade400),
                ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }
}
