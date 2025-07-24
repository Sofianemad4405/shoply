import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final AutovalidateMode? autovalidateMode;
  final bool isPassword;
  final Function(String?)? onFieldSubmitted;
  final Function(String?)? onChanged;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    required this.prefixIcon,
    this.suffixIcon,
    this.autovalidateMode,
    this.isPassword = false,
    this.onFieldSubmitted,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscure = false;
  bool showEyeIcon = false;
  @override
  void initState() {
    obscure = widget.isPassword;
    super.initState();
    widget.controller.addListener(() {
      final hasText = widget.controller.text.isNotEmpty;
      if (hasText != showEyeIcon) {
        setState(() {
          showEyeIcon = hasText;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: obscure,
      validator: widget.validator,
      onChanged: widget.onChanged,
      autovalidateMode: widget.autovalidateMode,
      decoration: InputDecoration(
        suffixIcon:
            !widget.isPassword || widget.controller.text.isEmpty
                ? widget.suffixIcon
                : GestureDetector(
                  onTap: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  child: Icon(
                    !obscure ? Iconsax.eye_slash : Iconsax.eye,
                    color: Colors.grey,
                  ),
                ),
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,

        hintStyle: TextStyle(color: Color(0xffCCCCCC)),
        // البوردر العادي
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),

        // البوردر وقت الفوكس
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(0xff16A34A), // أخضر زي اللي بتحبه
            width: 2,
          ),
        ),

        // البوردر وقت الخطأ لو عايز
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),

        // البوردر وقت الفوكس لو فيه خطأ
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
