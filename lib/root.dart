import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopify/features/Info/view/info.dart';
import 'package:shopify/features/Likes/view/likes.dart';
import 'package:shopify/features/cart/view/cart.dart';
import 'package:shopify/features/home/view/home_screen.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final List<Widget> Pages = [Home(), Likes(), Cart(), Info()];
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(), // يمنع السحب
        children: Pages,
      ),
      bottomNavigationBar: GNav(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        backgroundColor: Colors.white,
        activeColor: Colors.green,
        gap: 8,
        tabs: [
          GButton(icon: Ionicons.home, text: "Home"),
          GButton(icon: Ionicons.heart, text: "Liked"),
          GButton(icon: Ionicons.cart, text: "Cart"),
          GButton(icon: Ionicons.person, text: "Profile", iconSize: 24),
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
