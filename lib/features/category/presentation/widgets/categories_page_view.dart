import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/features/category/presentation/cubit/home_categories_cubit/home_categories_cubit.dart';
import 'package:shopify/features/category/presentation/widgets/category_list_tile.dart';
import 'package:shopify/features/category/presentation/widgets/category_icon.dart';
import 'package:shopify/features/category/presentation/widgets/category_products.dart';

class CategoriesPageView extends StatefulWidget {
  const CategoriesPageView({super.key});
  static String routeName = Constants.kCategories;

  @override
  State<CategoriesPageView> createState() => _CategoriesPageViewState();
}

class _CategoriesPageViewState extends State<CategoriesPageView> {
  bool isGridView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFF0F1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Gap(10),
                    CustomAppBar(),
                    Gap(30),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Text(
                            "All Categories",
                            style: TextStyles.blackBold.copyWith(fontSize: 20),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isGridView = true;
                              });
                            },
                            child: GridOrList(
                              isGridView: isGridView,
                              image: "assets/imgs/svgs/grid_view.svg",
                            ),
                          ),
                          Gap(10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isGridView = false;
                              });
                            },
                            child: GridOrList(
                              isGridView: !isGridView,
                              image: "assets/imgs/svgs/list_view.svg",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(20),
                  ],
                ),
              ),
            ),
            isGridView ? Gap(10) : SizedBox.shrink(),
            Expanded(
              child:
                  isGridView
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CategoriesGridView(),
                      )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: CategoriesListView(),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.read<HomeCategoriesCubit>().categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => CategoryProducts(
                      categoryName:
                          context.read<HomeCategoriesCubit>().categories[index],
                    ),
              ),
            );
          },
          child: CategoryListTile(
            category: context.read<HomeCategoriesCubit>().categories[index],
            image: Constants.categoryImages[index],
          ),
        );
      },
    );
  }
}

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 4,
        childAspectRatio: .7,
      ),
      itemCount: context.read<HomeCategoriesCubit>().categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => CategoryProducts(
                      categoryName:
                          context.read<HomeCategoriesCubit>().categories[index],
                    ),
              ),
            );
          },
          child: CategoryIcon(
            image: Constants.categoryImages[index],
            category: context.read<HomeCategoriesCubit>().categories[index],
          ),
        );
      },
    );
  }
}

class GridOrList extends StatelessWidget {
  const GridOrList({super.key, required this.isGridView, required this.image});

  final bool isGridView;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: 34,
      decoration: BoxDecoration(
        color: !isGridView ? Colors.white : Color(0xffE9EAEC),
        borderRadius: BorderRadius.circular(6),
      ),
      child: SizedBox(
        height: 24,
        width: 24,
        child: Center(child: SvgPicture.asset(image)),
      ),
    );
  }
}
