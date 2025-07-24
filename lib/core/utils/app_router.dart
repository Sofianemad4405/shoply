import 'package:flutter/material.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/features/auth/presentation/view/sign_in_page_view.dart';
import 'package:shopify/features/auth/presentation/view/sign_up_page_view.dart';
import 'package:shopify/features/category/presentation/widgets/categories_page_view.dart';
import 'package:shopify/features/category/presentation/widgets/category_products.dart';
import 'package:shopify/features/on_boarding/widgets/on_boarding_screen.dart';
import 'package:shopify/features/home/presentation/widgets/product_details.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/root.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/onBoarding":
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case Constants.kSignIn:
        return MaterialPageRoute(builder: (_) => SigninPageView());
      case Constants.kSignUp:
        return MaterialPageRoute(builder: (_) => SignUpPageView());
      case Constants.kRoot:
        return MaterialPageRoute(builder: (_) => Root());
      case Constants.kCategories:
        return MaterialPageRoute(builder: (_) => CategoriesPageView());
      case Constants.kCategoryProducts:
        return MaterialPageRoute(
          builder:
              (_) =>
                  CategoryProducts(categoryName: settings.arguments as String),
        );
      case Constants.kProductDetails:
        return MaterialPageRoute(
          builder:
              (_) => ProductDetails(product: settings.arguments as Product),
        );
      case Constants.kOnBoarding:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
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
