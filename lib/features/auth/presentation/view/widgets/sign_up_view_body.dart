import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopify/core/widgets/app_heading.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/helper_functions.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/features/auth/presentation/cubits/signup_cubits/signup_cubit.dart';
import 'package:shopify/features/auth/presentation/view/widgets/custom_button.dart';
import 'package:shopify/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'package:shopify/features/auth/presentation/view/widgets/or_row.dart';
import 'package:shopify/features/auth/presentation/view/widgets/social_auth_button.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final location = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(10),
                  AppHeading(),
                  Gap(20),
                  Text(
                    "Create Account",
                    style: TextStyles.blackBold.copyWith(fontSize: 24),
                  ),
                  Gap(5),
                  Text(
                    "Join Shoply to start shopping",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gap(30),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    controller: name,
                    hintText: "Full Name",
                    validator: validateName,
                    prefixIcon: Icon(Iconsax.user_copy),
                  ),
                  Gap(20),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    controller: location,
                    hintText: "Location",
                    validator: validateLocation,
                    prefixIcon: Icon(Iconsax.location_copy),
                  ),
                  Gap(20),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    controller: email,
                    hintText: "Email",
                    validator: validateEmail,
                    prefixIcon: Icon(Iconsax.sms_copy),
                  ),
                  Gap(20),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: password,
                    hintText: "Password",
                    validator: validatePassword,
                    prefixIcon: Icon(Iconsax.lock_copy),
                    isPassword: true,
                  ),
                  Gap(20),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: confirmPassword,
                    hintText: "Confirm Password",
                    validator:
                        (value) =>
                            passwordConfirmValidator(password.text, value),
                    prefixIcon: Icon(Iconsax.lock_copy),
                    isPassword: true,
                  ),
                  Gap(20),
                  CustomButton(
                    text: "Create Account",
                    onPressed: () {
                      log("message");
                      if (formKey.currentState!.validate()) {
                        context.read<SignupCubit>().signup(
                          name: name.text,
                          location: location.text,
                          email: email.text,
                          password: password.text,
                        );
                      }
                    },
                  ),
                  Gap(30),
                  OrRow(text: "Or sign up with"),
                  Gap(30),
                  Row(
                    children: [
                      SocialAuthButton(
                        image: "assets/imgs/svgs/facebook.svg",
                        authMethod: "Facebook",
                      ),
                      Spacer(),
                      SocialAuthButton(
                        image: "assets/imgs/svgs/google.svg",
                        authMethod: "Google",
                      ),
                    ],
                  ),
                  Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Color(0xff4B5563),
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Text(
                          "  Sign In",
                          style: TextStyle(
                            color: Color(0xff22C55E),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
