import 'package:shopify/core/models/product_model.dart';

class Constants {
  static List<String> categoryImages = [
    'assets/imgs/category_svgs/beauty.svg', // beauty
    'assets/imgs/category_svgs/fragrances.svg', // fragrances
    'assets/imgs/category_svgs/furniture.svg', // furniture
    'assets/imgs/category_svgs/groceries.svg', // groceries
    'assets/imgs/category_svgs/home_category.svg', // home-decoration
    'assets/imgs/category_svgs/kitchen.svg', // kitchen-accessories
    'assets/imgs/category_svgs/laptops.svg', // laptops
    'assets/imgs/category_svgs/men-shirts.svg', // mens-shirts
    'assets/imgs/category_svgs/men-shoes.svg', // mens-shoes
    'assets/imgs/category_svgs/men\'s-watches.svg', // mens-watches
    'assets/imgs/category_svgs/mobile-accessy.svg', // mobile-accessories (تأكد من امتداد .svg)
    'assets/imgs/category_svgs/motorcycle.svg', // motorcycle
    'assets/imgs/category_svgs/skin-care.svg', // skin-care (تأكد من spelling الصحيح "skin-care")
    'assets/imgs/category_svgs/phones.svg', // smartphones
    'assets/imgs/category_svgs/Sports.svg', // sports-accessories
    'assets/imgs/category_svgs/sun-glasses.svg', // sunglasses
    'assets/imgs/category_svgs/tablets.svg', // tablets
    'assets/imgs/category_svgs/tops.svg', // tops
    'assets/imgs/category_svgs/vehicle.svg', // vehicle
    'assets/imgs/category_svgs/womens-bags.svg', // womens-bags
    'assets/imgs/category_svgs/women\'s-dress.svg', // womens-dresses
    'assets/imgs/category_svgs/jewellery.svg', // womens-jewellery
    'assets/imgs/category_svgs/women\'s-shoes.svg', // womens-shoes
    'assets/imgs/category_svgs/women\'s-watches.svg', // womens-watches
  ];

  static String holderImage =
      "https://as2.ftcdn.net/v2/jpg/05/27/29/95/1000_F_527299569_vYLOucMAr1oz52CRaQbZNC3tIjtiEwaY.jpg";
  static List<Product> cartProducts = [];

  static const String kOnBoarding = "onBoarding";
  static const String kisLoggedIn = "isLoggedIn";
  static const String kUser = "users";
  static const String kSignUp = "signup";
  static const String kSignIn = "signin";
  static const String kRoot = "root";
  static const String kCategories = "categories";
  static const String kWishlist = "wishlist";
  static const String kCheckout = "checkout";
  static const String kCategoryProducts = "categoryProducts";
  static const String kProductDetails = "productDetails";
  static const String kFeaturedProducts = "Featured Products";
  static const String kHelpAndSupport = "help_and_support";
  static const String profileImageKey = 'profile_image';

  // static const String kCart = "Cart";

  static String kAlreadyHaveAnAccount = "already have an account?";
  static String kIsLoggedIn = "is logged in";
  static String kIsOnBoardingSeen = "is on boarding seen";
  static String baseUrl = 'https://dummyjson.com';
}
