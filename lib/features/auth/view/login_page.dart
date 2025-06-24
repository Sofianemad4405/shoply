import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shopify/features/auth/cubit/auth_cubit.dart';
import 'package:shopify/features/auth/view/sign_up_page.dart';
import 'package:shopify/features/auth/view/widgets/custom_button.dart';
import 'package:shopify/features/auth/view/widgets/custom_text_field.dart';
import 'package:shopify/root.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.userData});

  final Map<String, dynamic> userData;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/imgs/logo.png",
                        height: height * 0.25,
                        width: width,
                      ),
                      //email
                      CustomTextField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        controller: email,
                        hintText: "E-mail",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "E-mail is required";
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      Gap(20),
                      //password
                      CustomTextField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        controller: password,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is SignInError) {
                    if (mounted) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                            content: Text(state.message),
                          ),
                        );
                      });
                      log(state.message);
                    }
                  }
                  if (state is SignInSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => Root(
                              userData: widget.userData,
                              userCredential: state.userCredential,
                            ),
                      ),
                    );
                  }
                },
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is SignInLoading) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: CustomButton(
                          text: "Sign In",
                          isLoading: true,
                          onPressed: null,
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomButton(
                        text: "Sign In",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().signIn(
                              email.text,
                              password.text,
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              Gap(20),

              ///dont have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 6),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.padded,
                      visualDensity: VisualDensity.comfortable,
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
