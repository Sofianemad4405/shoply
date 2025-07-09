import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/constants.dart';
import 'package:shopify/core/services/getit_service.dart' as GetItService;
import 'package:shopify/features/auth/domain/repos/auth_repo.dart';
import 'package:shopify/features/auth/presentation/cubits/signup_cubits/signup_cubit.dart';
import 'package:shopify/features/auth/presentation/view/widgets/sign_up_page_view_bloc_consumer.dart';

class SignUpPageView extends StatelessWidget {
  const SignUpPageView({super.key});

  static String routeName = Constants.kSignUp;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              SignupCubit(authRepo: GetItService.getIt.get<AuthRepo>()),
      child: Scaffold(body: SignUpPageViewBlocConsumer()),
    );
  }
}
