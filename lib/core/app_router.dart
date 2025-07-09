import 'package:flutter/material.dart';
import 'package:shopify/features/auth/presentation/view/sign_in_page_view.dart';
import 'package:shopify/features/auth/presentation/view/sign_up_page_view.dart';
import 'package:shopify/features/on_boarding/widgets/on_boarding_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/onBoarding":
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => SigninPageView());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpPageView());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
