import 'package:flutter/material.dart';

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff16A34A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(child: Icon(Icons.next_plan)),
    );
  }
}
