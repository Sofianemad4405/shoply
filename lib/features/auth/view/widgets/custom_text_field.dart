import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final AutovalidateMode? autovalidateMode;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        errorStyle: TextStyle(height: .4, fontSize: 10),
        filled: true,
        fillColor: Color(0xFFF1F1F1),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon:
            prefixIcon != null
                ? Icon(prefixIcon, color: Colors.grey[600])
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
