import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChange;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        onTap: onTabChange,
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
        selectedItemColor: Color(0xff22C55E),
        unselectedItemColor: Color(0xff6B7280),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/imgs/svgs/home.svg",
              colorFilter: ColorFilter.mode(
                currentIndex == 0 ? Color(0xff22C55E) : Color(0xff6B7280),
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/imgs/svgs/search.svg",
              colorFilter: ColorFilter.mode(
                currentIndex == 1 ? Color(0xff22C55E) : Color(0xff6B7280),
                BlendMode.srcIn,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/imgs/svgs/cart.svg",
              colorFilter: ColorFilter.mode(
                currentIndex == 2 ? Color(0xff22C55E) : Color(0xff6B7280),
                BlendMode.srcIn,
              ),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/imgs/svgs/profile.svg",
              colorFilter: ColorFilter.mode(
                currentIndex == 3 ? Color(0xff22C55E) : Color(0xff6B7280),
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
