import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/widgets/app_heading.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/features/category/presentation/widgets/categories_page_view.dart';
import 'package:shopify/features/category/presentation/widgets/category_products.dart';
import 'package:shopify/features/home/presentation/providers/categories_notifier.dart';
import 'package:shopify/features/home/presentation/providers/home_products_notifier.dart';
import 'package:shopify/features/home/presentation/providers/home_providers.dart';
import 'package:shopify/features/home/presentation/widgets/banners.dart';
import 'package:shopify/features/category/presentation/widgets/category_icon.dart';
import 'package:shopify/features/home/presentation/widgets/featured_products_bloc_builder.dart';

class HomePageViewBody extends StatelessWidget {
  const HomePageViewBody({
    super.key,
    required this.categoriesNotifier,
    required this.homeProductsNotifier,
  });
  final AsyncNotifierProvider<CategoriesNotifier, List<String>>
  categoriesNotifier;
  final AsyncNotifierProvider<HomeNotifier, List<ProductEntity>>
  homeProductsNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Gap(10),
                    CustomAppBar(),
                    Gap(10),
                    Banners(),
                    Gap(10),
                    CategoriesRow(),
                    Gap(10),
                    SizedBox(
                      height: 250,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final categories = ref.watch(categoriesNotifier);
                          return categories.when(
                            data: (data) => CategoriesGridView(),
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
                    Gap(10),
                    Consumer(
                      builder: (context, ref, child) {
                        final homeProducts = ref.watch(homeProductsNotifier);
                        return homeProducts.when(
                          data:
                              (data) => Row(
                                children: [
                                  Text(
                                    "Featured Products",
                                    style: TextStyles.blackBold.copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      context.push(
                                        Constants.kFeaturedProducts,
                                        arguments: data,
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      "assets/imgs/svgs/see_all.svg",
                                      height: 24,
                                    ),
                                  ),
                                ],
                              ),
                          error:
                              (error, stackTrace) => const Center(
                                child: Text("Error fetching products"),
                              ),
                          loading:
                              () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                        );
                      },
                    ),
                    Gap(10),
                    FeaturedProducts(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeBar extends StatelessWidget {
  const HomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppHeading(),
        Spacer(),
        SvgPicture.asset(
          "assets/imgs/svgs/cart.svg",
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
      ],
    );
  }
}

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Categories", style: TextStyles.blackBold.copyWith(fontSize: 20)),
        Spacer(),
        GestureDetector(
          onTap: () {
            context.push(CategoriesPageView.routeName);
          },
          child: SvgPicture.asset("assets/imgs/svgs/see_all.svg", height: 24),
        ),
      ],
    );
  }
}

class CategoriesGridView extends ConsumerWidget {
  const CategoriesGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.read(categoriesProvider);
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 4,
        childAspectRatio: .7,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => CategoryProducts(
                      categoryName: categories.when(
                        data: (data) => data[index],
                        loading: () => "",
                        error: (_, __) => "",
                      ),
                    ),
              ),
            );
          },
          child: CategoryIcon(
            image: Constants.categoryImages[index],
            category: categories.when(
              data: (data) => data[index],
              loading: () => "",
              error: (_, __) => "",
            ),
          ),
        );
      },
    );
  }
}
