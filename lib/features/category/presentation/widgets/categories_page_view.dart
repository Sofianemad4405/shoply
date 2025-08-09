import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/core/widgets/grid_or_list.dart';
import 'package:shopify/features/category/presentation/widgets/category_list_tile.dart';
import 'package:shopify/features/category/presentation/widgets/category_icon.dart';
import 'package:shopify/features/category/presentation/widgets/category_products.dart';
import 'package:shopify/features/home/presentation/providers/home_providers.dart';

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
            SizedBox(
              // decoration: BoxDecoration(color: Colors.white),
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
                        child: Consumer(
                          builder: (context, ref, child) {
                            final categories = ref.watch(categoriesProvider);
                            return categories.when(
                              data:
                                  (data) =>
                                      CategoriesGridView(categories: data),
                              error:
                                  (error, stackTrace) => const Center(
                                    child: Text("Error fetching categories"),
                                  ),
                              loading:
                                  () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                            );
                          },
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Consumer(
                          builder: (context, ref, child) {
                            final categories = ref.watch(categoriesProvider);
                            return categories.when(
                              data:
                                  (data) =>
                                      CategoriesListView(categories: data),
                              error:
                                  (error, stackTrace) => const Center(
                                    child: Text("Error fetching categories"),
                                  ),
                              loading:
                                  () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                            );
                          },
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key, required this.categories});
  final List<dynamic> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        CategoryProducts(categoryName: categories[index]),
              ),
            );
          },
          child: CategoryListTile(
            category: categories[index],
            image: Constants.categoryImages[index],
          ),
        );
      },
    );
  }
}

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({super.key, required this.categories});
  final List<dynamic> categories;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 4,
        childAspectRatio: .7,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        CategoryProducts(categoryName: categories[index]),
              ),
            );
          },
          child: CategoryIcon(
            image: Constants.categoryImages[index],
            category: categories[index],
          ),
        );
      },
    );
  }
}
