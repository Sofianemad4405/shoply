import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shopify/features/auth/cubit/auth_cubit.dart';
import 'package:shopify/features/auth/view/login_page.dart';
import 'package:shopify/features/auth/view/widgets/custom_button.dart';
import 'package:shopify/features/auth/view/widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                      CustomTextField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        controller: name,
                        hintText: "Name",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name is required";
                          }
                          if (value.length < 3) {
                            return "Name must be at least 3 characters long";
                          }
                          if (value.length > 20) {
                            return "Name must be at most 20 characters long";
                          }
                          if (!value.contains(RegExp(r"^[a-zA-Z ]+$"))) {
                            return "Name must contain only letters";
                          }
                          return null;
                        },
                      ),
                      Gap(20),
                      CustomTextField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        controller: location,
                        hintText: "Location",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Location is required";
                          }
                          return null;
                        },
                      ),
                      Gap(20),
                      CustomTextField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        hintText: "Phone",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone is required";
                          }
                          if (value.length < 11) {
                            return "Phone must be at least 11 characters long";
                          }
                          if (!value.contains(RegExp(r"^[0-9]+$"))) {
                            return "Phone must contain only numbers";
                          }
                          if (!value.startsWith("01")) {
                            return "Phone must start with 01";
                          }
                          return null;
                        },
                      ),
                      Gap(20),
                      CustomTextField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "E-mail",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "E-mail is required";
                          }
                          if (!value.contains("@")) {
                            return "Invalid E-mail";
                          }
                          if (!value.contains(".")) {
                            return "Invalid E-mail";
                          }
                          return null;
                        },
                      ),
                      Gap(20),
                      CustomTextField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        controller: password,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "Password",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }

                          return null;
                        },
                      ),
                      Gap(20),
                      CustomTextField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        controller: confirmPassword,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "Confirm Password",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          }
                          if (value != password.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is SignUpLoading) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is SignUpError) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 2),
                          content: Text(state.message),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomButton(
                        text: "Sign Up",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            log("Sofiannn");
                            final userData = {
                              'name': name.text,
                              'location': location.text,
                              'phone': phone.text,
                            };
                            context.read<AuthCubit>().signUp(
                              email.text,
                              password.text,
                              userData,
                            );
                          }
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomButton(
                        text: "Sign Up",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final userData = {
                              'name': name.text,
                              'email': email.text,
                              'location': location.text,
                              'phone': phone.text,
                            };
                            context.read<AuthCubit>().signUp(
                              email.text,
                              password.text,
                              userData,
                            );
                            log(userData['email'].toString());
                            log(userData['name'].toString());
                            log(userData['location'].toString());
                            log(userData['phone'].toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => LoginPage(userData: userData),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }
                },
              ),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 6),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginPage(userData: {}),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.padded,
                      visualDensity: VisualDensity.comfortable,
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color:
                            Colors
                                .green[800], // نفس درجة الزر الأساسي بس أغمق شوية
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
