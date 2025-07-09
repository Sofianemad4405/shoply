import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopify/core/app_heading.dart';
import 'package:shopify/core/extention.dart';
import 'package:shopify/core/helper_functions.dart';
import 'package:shopify/core/text_styles.dart';
import 'package:shopify/features/auth/presentation/cubits/signin_cubits/siginin_cubit.dart';
import 'package:shopify/features/auth/presentation/view/widgets/custom_button.dart';
import 'package:shopify/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'package:shopify/features/auth/presentation/view/widgets/donot_have_an_account.dart';
import 'package:shopify/features/auth/presentation/view/widgets/or_row.dart';
import 'package:shopify/features/auth/presentation/view/widgets/social_auth_button.dart';

class SigninPageViewBody extends StatefulWidget {
  const SigninPageViewBody({super.key});

  @override
  State<SigninPageViewBody> createState() => _SigninPageViewBodyState();
}

class _SigninPageViewBodyState extends State<SigninPageViewBody> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Gap(10),
              AppHeading(),
              Gap(100.h),
              Text(
                "Welcome Back",
                style: TextStyles.blackBold.copyWith(fontSize: 28),
              ),
              Gap(20.h),
              Text(
                "Sign in to your account",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Gap(30.h),
              CustomTextField(
                controller: email,
                hintText: "Email",
                prefixIcon: Iconsax.sms_copy,
              ),
              Gap(20.h),
              CustomTextField(
                controller: password,
                hintText: "Password",
                prefixIcon: Iconsax.lock_copy,
              ),
              Gap(20.h),
              OrRow(text: "Or Continue with"),
              Gap(20.h),
              CustomButton(
                text: "Sign In",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<SigininCubit>().signin(
                      email: email.text,
                      password: password.text,
                    );
                  }
                },
              ),
              Gap(20.h),
              Row(
                children: [
                  SocialAuthButton(
                    image: "assets/imgs/facebook.svg",
                    authMethod: "Facebook",
                  ),
                  Spacer(),
                  SocialAuthButton(
                    image: "assets/imgs/google.svg",
                    authMethod: "Google",
                  ),
                ],
              ),
              Gap(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Color(0xff4B5563), fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push("/signup");
                    },
                    child: Text(
                      "  Sign up",
                      style: TextStyle(color: Color(0xff22C55E), fontSize: 16),
                    ),
                  ),
                ],
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
