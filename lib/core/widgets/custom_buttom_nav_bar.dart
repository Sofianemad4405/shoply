import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';

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
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cartItemsCount = context.read<CartCubit>().cartProducts.length;
          return BottomNavigationBar(
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
                icon: Stack(
                  clipBehavior:
                      Clip.none, // 👈 مهم علشان يسمح للدائرة بالخروج من حدود الأيقونة
                  children: [
                    SvgPicture.asset(
                      "assets/imgs/svgs/cart.svg",
                      colorFilter: ColorFilter.mode(
                        currentIndex == 2
                            ? const Color(0xff22C55E)
                            : const Color(0xff6B7280),
                        BlendMode.srcIn,
                      ),
                    ),
                    cartItemsCount != 0
                        ? Positioned(
                          right: -6,
                          top: -4,
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 244, 16, 0),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              cartItemsCount.toString(),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                        : SizedBox.shrink(),
                  ],
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
          );
        },
      ),
    );
  }
}
