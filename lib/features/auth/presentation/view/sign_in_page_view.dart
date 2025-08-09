import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/services/getit_service.dart' as GetItService;
import 'package:shopify/features/auth/domain/repos/auth_repo.dart';
import 'package:shopify/features/auth/presentation/view/widgets/sign_in_page_view_bloc_consumer.dart';
import 'package:shopify/features/auth/presentation/view/widgets/sign_in_page_view_body.dart';

class SigninPageView extends StatelessWidget {
  const SigninPageView({super.key});

  static String routeName = Constants.kSignIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SigninPageViewBody()));
  }
}
