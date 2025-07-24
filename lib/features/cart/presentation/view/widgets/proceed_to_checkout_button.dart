import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProceedToCheckOutButton extends StatelessWidget {
  const ProceedToCheckOutButton({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 362.15.w,
      height: 47.98.h,
      decoration: ShapeDecoration(
        color: const Color(0xFF22C55E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x00000000),
            blurRadius: 0,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x00000000),
            blurRadius: 0,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.60,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            height: 1.76,
          ),
        ),
      ),
    );
  }
}
