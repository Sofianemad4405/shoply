import 'package:flutter/material.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/features/auth/presentation/view/sign_in_page_view.dart';
import 'package:shopify/features/auth/presentation/view/sign_up_page_view.dart';
import 'package:shopify/features/category/presentation/widgets/categories_page_view.dart';
import 'package:shopify/features/category/presentation/widgets/category_products.dart';
import 'package:shopify/features/checkout/presentation/views/checkout.dart';
import 'package:shopify/features/home/presentation/widgets/featured_products.dart';
import 'package:shopify/features/on_boarding/widgets/on_boarding_screen.dart';
import 'package:shopify/features/home/presentation/widgets/product_details.dart';
import 'package:shopify/features/profile/screens/help_and_support.dart';
import 'package:shopify/features/wishlist/presentation/wishlist_view.dart';
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
        final index = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => Root(index: index is int ? index : 0),
        );
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
              (_) =>
                  ProductDetails(product: settings.arguments as ProductEntity),
        );
      case Constants.kOnBoarding:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case Constants.kFeaturedProducts:
        return MaterialPageRoute(
          builder:
              (_) => FeaturedProductsPage(
                products: settings.arguments as List<ProductEntity>,
              ),
        );
      case Constants.kWishlist:
        return MaterialPageRoute(builder: (_) => WishlistView());

      case Constants.kCheckout:
        return MaterialPageRoute(builder: (_) => Checkout());

      case Constants.kHelpAndSupport:
        return MaterialPageRoute(builder: (_) => HelpAndSupport());

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
