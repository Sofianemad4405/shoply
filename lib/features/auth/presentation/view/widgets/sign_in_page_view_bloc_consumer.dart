import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shopify/features/auth/presentation/cubits/signin_cubits/siginin_cubit.dart';
import 'package:shopify/features/auth/presentation/view/widgets/sign_in_page_view_body.dart';
import 'package:shopify/root.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/prefs.dart';

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
          Prefs.setBool(Constants.kIsLoggedIn, true);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Root(index: 0)),
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
