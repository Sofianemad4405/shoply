// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:shopify/core/helper_functions.dart';
// import 'package:shopify/features/auth/presentation/view/widgets/custom_text_field.dart';

// class SignUpTextFields extends StatelessWidget {
//   const SignUpTextFields({
//     super.key,
//     required this.name,
//     required this.location,
//     required this.email,
//     required this.password,
//     required this.confirmPassword,
//   });

//   final TextEditingController name;
//   final TextEditingController location;
//   final TextEditingController email;
//   final TextEditingController password;
//   final TextEditingController confirmPassword;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Image.asset(
//           "assets/imgs/logo.png",
//           height: MediaQuery.of(context).size.height * 0.25,
//           width: MediaQuery.of(context).size.width,
//         ),
//         CustomTextField(
//           autovalidateMode: AutovalidateMode.onUnfocus,
//           controller: name,
//           hintText: "Name",
//           validator: validateName,
//         ),
//         Gap(20),
//         CustomTextField(
//           autovalidateMode: AutovalidateMode.onUnfocus,
//           controller: location,
//           hintText: "Location",
//           validator: validateLocation,
//         ),
//         Gap(20),
//         CustomTextField(
//           autovalidateMode: AutovalidateMode.onUnfocus,
//           controller: email,
//           keyboardType: TextInputType.emailAddress,
//           hintText: "E-mail",
//           validator: validateEmail,
//         ),
//         Gap(20),
//         CustomTextField(
//           autovalidateMode: AutovalidateMode.onUnfocus,
//           controller: password,
//           obscureText: true,
//           keyboardType: TextInputType.visiblePassword,
//           hintText: "Password",
//           validator: validatePassword,
//         ),
//         Gap(20),
//         CustomTextField(
//           autovalidateMode: AutovalidateMode.onUnfocus,
//           controller: confirmPassword,
//           obscureText: true,
//           keyboardType: TextInputType.visiblePassword,
//           hintText: "Confirm Password",
//           validator: (value) => passwordConfirmValidator(password.text, value),
//         ),
//       ],
//     );
//   }
// }
