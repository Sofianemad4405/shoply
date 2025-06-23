import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopify/features/auth/view/widgets/custom_button.dart';
import 'package:shopify/features/auth/view/widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Image.asset("assets/imgs/logo.png", height: 300, width: 300),
                Gap(20),
                CustomTextField(controller: email, hintText: "E-mail"),
                Gap(20),
                CustomTextField(controller: password, hintText: "Password"),
                Gap(20),
                CustomButton(text: "Sign Up", onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
