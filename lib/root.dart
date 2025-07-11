import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopify/core/constants.dart';
import 'package:shopify/core/prefs.dart';
import 'package:shopify/features/Info/view/info.dart';
import 'package:shopify/features/Likes/view/likes.dart';
import 'package:shopify/features/cart/view/cart.dart';
import 'package:shopify/features/home/cubit/home_cubit.dart';
import 'package:shopify/features/home/view/home_screen.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void initState() {
    Prefs.init();
    context.read<HomeCubit>().loadLikes();
    context.read<HomeCubit>().loadCart();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged:
            (value) => setState(() {
              currentIndex = value;
            }),
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          // Home(),
          // Likes(),
          // Cart(),
          // ProfileInfo(),
        ],
      ),
      bottomNavigationBar: GNav(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: Colors.white,
        activeColor: Colors.green,
        gap: 6,
        tabMargin: EdgeInsets.zero,
        tabs: [
          GButton(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            icon: Iconsax.home_copy,
            text: "Home",
          ),
          GButton(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            icon: Iconsax.heart_copy,
            text: "Likes",
          ),
          GButton(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            icon: Iconsax.shopping_cart_copy,
            text: "Cart",
          ),
          // GButton(
          //   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          //   icon: Iconsax.user_copy,
          //   text: "Profile",
          // ),
        ],
        onTabChange: (index) {
          setState(() {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            currentIndex = index;
          });
        },
      ),
    );
  }
}
