import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shopify/core/helper_functions.dart';
import 'package:shopify/features/auth/presentation/cubits/signin_cubits/siginin_cubit.dart';
import 'package:shopify/features/auth/presentation/view/sign_up_page_view.dart';
import 'package:shopify/features/auth/presentation/view/widgets/custom_button.dart';
import 'package:shopify/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'package:shopify/features/auth/presentation/view/widgets/donot_have_an_account.dart';
import 'package:shopify/features/auth/presentation/view/widgets/sign_in_page_view_body.dart';
import 'package:shopify/root.dart';

class SignInPageViewBlocConsumer extends StatelessWidget {
  const SignInPageViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigininCubit, SigininState>(
      listener: (context, state) {
        if (state is SigininError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              duration: Duration(milliseconds: 1500),
              content: Text(state.message),
            ),
          );
        }
        if (state is SigininSuccess) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     behavior: SnackBarBehavior.floating,
          //     backgroundColor: Colors.green,
          //     duration: Duration(milliseconds: 1500),
          //     content: Text("User signed in successfully!"),
          //   ),
          // );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Root()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          color: Colors.transparent,
          inAsyncCall: state is SigininLoading,
          child: SigninPageViewBody(),
        );
      },
    );
  }
}
