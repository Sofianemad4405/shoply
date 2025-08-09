import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shopify/features/auth/presentation/cubits/signup_cubits/signup_cubit.dart';
import 'package:shopify/features/auth/presentation/view/widgets/sign_up_page_view_body.dart';

class SignUpPageViewBlocConsumer extends StatelessWidget {
  const SignUpPageViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupError) {
          log("Failed");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              duration: Duration(milliseconds: 1500),
              content: Text(state.message),
            ),
          );
        }
        if (state is SignupSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 1500),
              content: Text("User created successfully!"),
            ),
          );
          log("Succeeded");
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          color: Colors.transparent,
          inAsyncCall: state is SignupLoading,
          child: SignUpPageViewBody(),
        );
      },
    );
  }
}
