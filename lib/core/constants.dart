import 'package:shopify/features/home/model/product_model.dart';

class Constants {
  static List<String> categories = [
    "Beauty",
    "Fragrances",
    "Furniture",
    "Groceries",
    "Laptops",
    "Sunglasses",
    "Tablets",
    "Home-decoration",
    "Kitchen-accessories",
    "Mens-shirts",
    "Mens-shoes",
    "Mens-watches",
    "Mobile-accessories",
    "Motorcycle",
    "Skin-care",
    "Smartphones",
    "Sports-accessories",
    "Tops",
    "Vehicle",
    "Womens-bags",
    "Womens-dresses",
    "Womens-jewellery",
    "Womens-shoes",
    "Womens-watches",
  ];

  static List<String> categoryImages = [
    "assets/imgs/beauty.png", // beauty
    "assets/imgs/fragrances.jpeg", // fragrances
    "assets/imgs/furniture.png", // furniture
    "assets/imgs/groceries.png", // groceries
    "assets/imgs/laptops.png", // laptops
    "assets/imgs/sunglasses.png", // sunglasses
    "assets/imgs/tablets.png", // tablets
    "assets/imgs/home-decoration.png", // home-decoration
    "assets/imgs/kitchen-accessories.png", // kitchen-accessories
    "assets/imgs/mens-shirts.png", // mens-shirts
    "assets/imgs/mens-shoes.png", // mens-shoes
    "assets/imgs/mens-watches.png", // mens-watches
    "assets/imgs/mobile-accessories.png", // mobile-accessories
    "assets/imgs/motorcycle.png", // motorcycle
    "assets/imgs/skin-care.png", // skin-care
    "assets/imgs/smartphones.png", // smartphones
    "assets/imgs/sports-accessories.png", // sports-accessories
    "assets/imgs/tops.png", // tops
    "assets/imgs/vehicle.png", // vehicle
    "assets/imgs/womens-bags.png", // womens-bags
    "assets/imgs/womens-dresses.png", // womens-dresses
    "assets/imgs/womens-jewellery.png", // womens-jewellery
    "assets/imgs/womens-shoes.png", // womens-shoes
    "assets/imgs/womens-watches.png", // womens-watches
  ];

  static List<String> myImages = [
    'assets/imgs/photo_2025-06-09_19-34-56.jpg',
    'assets/imgs/photo_2025-06-09_19-35-12.jpg',
    'assets/imgs/photo_2025-06-09_19-35-16.jpg',
    'assets/imgs/photo_2025-06-09_19-35-19.jpg',
    'assets/imgs/photo_2025-06-09_19-35-21.jpg',
    'assets/imgs/photo_2025-06-09_19-35-24.jpg',
    'assets/imgs/photo_2025-06-09_19-35-27.jpg',
    'assets/imgs/photo_2025-06-09_19-35-30.jpg',
    'assets/imgs/photo_2025-06-09_19-35-33.jpg',
  ];

  static List<Product> likedProducts = [];
  static String holderImage =
      "https://as2.ftcdn.net/v2/jpg/05/27/29/95/1000_F_527299569_vYLOucMAr1oz52CRaQbZNC3tIjtiEwaY.jpg";
  static List<Product> cartProducts = [];
  static String kisLoggedIn = "isLoggedIn";
  static String kUser = "user";
  static String kSignUp = "signup";
  static String kSignIn = "signin";
  static String kRoot = "root";

  static String kAlreadyHaveAnAccount = "already have an account?";
}
