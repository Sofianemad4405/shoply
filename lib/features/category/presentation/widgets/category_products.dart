import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/core/widgets/grid_or_list.dart';
import 'package:shopify/features/category/presentation/providers/category_notifier.dart';
import 'package:shopify/features/category/presentation/widgets/pop_up_menu.dart';
import 'package:shopify/core/widgets/product_card.dart';
import 'package:shopify/features/category/presentation/widgets/product_list_tile.dart';
import 'package:shopify/features/home/presentation/widgets/product_details.dart';

class CategoryProducts extends ConsumerStatefulWidget {
  const CategoryProducts({super.key, required this.categoryName});
  final String categoryName;
  static String routeName = Constants.kCategoryProducts;

  @override
  ConsumerState<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends ConsumerState<CategoryProducts> {
  bool isGridView = true;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(categoryNotifierProvider.notifier)
          .fetchCategoryProducts(widget.categoryName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    CustomAppBar(),
                    Gap(20),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Text(
                            widget.categoryName,
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
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Consumer(
                builder: (context, ref, child) {
                  final products = ref.watch(categoryNotifierProvider);
                  return products.when(
                    data: (data) {
                      return Row(
                        children: [
                          Text(
                            "${data.length} products found",
                            style: TextStyles.greymini.copyWith(fontSize: 18),
                          ),
                          Spacer(),
                          CustomPopUpMenu(
                            title:
                                ref
                                    .read(categoryNotifierProvider.notifier)
                                    .sortMethod,
                            items: [
                              PopupMenuItem(
                                value: 'name',
                                child: Text('Sort by Name'),
                              ),
                              PopupMenuItem(
                                value: 'price',
                                child: Text('Sort by Price'),
                              ),
                              PopupMenuItem(
                                value: 'rating',
                                child: Text('Sort by Rating'),
                              ),
                            ],
                            onSelected: (value) {
                              ref
                                  .read(categoryNotifierProvider.notifier)
                                  .sortMethod = value;
                              ref
                                  .read(categoryNotifierProvider.notifier)
                                  .fetchCategoryProductsSorted(
                                    sortMethod: value,
                                    order:
                                        ref
                                            .read(
                                              categoryNotifierProvider.notifier,
                                            )
                                            .order,
                                    categoryName: widget.categoryName,
                                  );
                              setState(() {});
                            },
                            image: "assets/imgs/svgs/sort.svg",
                          ),
                          Gap(20),
                          CustomPopUpMenu(
                            title:
                                ref
                                    .read(categoryNotifierProvider.notifier)
                                    .order,
                            items: [
                              PopupMenuItem(
                                value: 'asc',
                                child: Text('Ascending'),
                              ),
                              PopupMenuItem(
                                value: 'desc',
                                child: Text('Descending'),
                              ),
                            ],
                            onSelected: (value) {
                              ref
                                  .read(categoryNotifierProvider.notifier)
                                  .order = value;
                              ref
                                  .read(categoryNotifierProvider.notifier)
                                  .fetchCategoryProductsSorted(
                                    sortMethod:
                                        ref
                                            .read(
                                              categoryNotifierProvider.notifier,
                                            )
                                            .sortMethod,
                                    order: value,
                                    categoryName: widget.categoryName,
                                  );
                              setState(() {});
                            },
                            image: "assets/imgs/svgs/filter.svg",
                          ),
                        ],
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return Text("Error fetching data $error");
                    },
                    loading: () => const CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Gap(20),
            Consumer(
              builder: (context, ref, child) {
                final products = ref.watch(categoryNotifierProvider);
                return products.when(
                  data:
                      (data) => Expanded(
                        child:
                            isGridView
                                ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 16,
                                          mainAxisSpacing: 16,
                                          childAspectRatio:
                                              screenWidth /
                                              (screenHeight / 1.35),
                                        ),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap:
                                            () => context.push(
                                              ProductDetails.routeName,
                                              arguments: data[index],
                                            ),
                                        child: ProductCard(
                                          product: data[index],
                                        ),
                                      );
                                    },
                                  ),
                                )
                                : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap:
                                            () => context.push(
                                              ProductDetails.routeName,
                                              arguments: data[index],
                                            ),
                                        child: ProductListTile(
                                          product: data[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                      ),
                  error:
                      (error, stackTrace) =>
                          Center(child: Text("Error fetching products $error")),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
