import 'package:flutter/material.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/widgets/custom_buttom_nav_bar.dart';
import 'package:shopify/core/utils/prefs.dart';
import 'package:shopify/features/cart/presentation/view/cart.dart';
import 'package:shopify/features/home/presentation/home.dart';
import 'package:shopify/features/profile/presentation/profile.dart';
import 'package:shopify/features/search/presentation/view/widgets/search_page_view_body.dart';
import 'package:shopify/features/wishlist/presentation/wishlist_view.dart';

class Root extends StatefulWidget {
  const Root({super.key, required this.index});
  static const routeName = Constants.kRoot;
  final int index;

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late int currentIndex;

  @override
  void initState() {
    Prefs.init();
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          Home(),
          SearchPageViewBody(),
          Cart(),
          WishlistView(),
          Profile(),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        onTabChange: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
