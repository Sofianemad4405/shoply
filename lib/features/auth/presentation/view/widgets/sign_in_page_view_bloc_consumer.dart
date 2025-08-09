// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:shopify/features/auth/presentation/cubits/signin_cubits/siginin_cubit.dart';
// import 'package:shopify/features/auth/presentation/providers/auth_notifier.dart';
// import 'package:shopify/features/auth/presentation/view/widgets/sign_in_page_view_body.dart';

// class SignInPageViewBody extends StatelessWidget {
//   const SignInPageViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, child) {
//         final login = ref.watch(authNotifierProvider);
//         return login.when(
//           data: (data) {
//             return ModalProgressHUD(
//               color: Colors.transparent,
//               inAsyncCall: login.isLoading,
//               child: SigninPageViewBody(),
//             );
//           },
//           error: (error, stackTrace) {
//             return ModalProgressHUD(
//               color: Colors.transparent,
//               inAsyncCall: login.isLoading,
//               child: SigninPageViewBody(),
//             );
//           },
//           loading: () {
//             return ModalProgressHUD(
//               color: Colors.transparent,
//               inAsyncCall: login.isLoading,
//               child: SigninPageViewBody(),
//             );
//           },
//         );
//       },
//     );
//   }
// }
