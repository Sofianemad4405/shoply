import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/widgets/app_heading.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/features/category/presentation/cubit/caterories_products_cubit/category_products_cubit.dart';
import 'package:shopify/features/category/presentation/cubit/home_categories_cubit/home_categories_cubit.dart';
import 'package:shopify/features/category/presentation/widgets/categories_page_view.dart';
import 'package:shopify/features/home/presentation/cubit/home_cubit.dart';
import 'package:shopify/features/home/presentation/widgets/banners.dart';
import 'package:shopify/features/category/presentation/widgets/category_icon.dart';
import 'package:shopify/features/home/presentation/widgets/featured_products.dart';
import 'package:shopify/features/home/presentation/widgets/featured_products_bloc_builder.dart';

class HomePageViewBody extends StatelessWidget {
  const HomePageViewBody({super.key});

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
                    BlocBuilder<HomeCategoriesCubit, HomeCategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesLoaded) {
                          return CategoriesGridView();
                        } else if (state is CategoriesError) {
                          return const Center(
                            child: Text("Error fetching categories"),
                          );
                        } else if (state is CategoryProductsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const Center(child: Text("Error"));
                        }
                      },
                    ),
                    Gap(10),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return Row(
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
                                  FeaturedProducts.routeName,
                                  arguments:
                                      state is HomeLoaded ? state.products : [],
                                );
                              },
                              child: SvgPicture.asset(
                                "assets/imgs/svgs/see_all.svg",
                                height: 24,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Gap(10),
                    FeaturedProductsBlocBuilder(),
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

class CategoriesGridView extends StatefulWidget {
  const CategoriesGridView({super.key});

  @override
  State<CategoriesGridView> createState() => _CategoriesGridViewState();
}

class _CategoriesGridViewState extends State<CategoriesGridView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * .3,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: screenWidth / (screenHeight / 1.5),
        ),
        itemCount: context.read<HomeCategoriesCubit>().categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap:
                () => context.push(
                  Constants.kCategoryProducts,
                  arguments:
                      context.read<HomeCategoriesCubit>().categories[index],
                ),
            child: CategoryIcon(
              image: Constants.categoryImages[index],
              category: context.read<HomeCategoriesCubit>().categories[index],
            ),
          );
        },
      ),
    );
  }
}

// class FeaturedProductsRow extends StatelessWidget {
//   const FeaturedProductsRow({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
