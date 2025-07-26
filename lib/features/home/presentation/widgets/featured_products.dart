import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/core/widgets/grid_or_list.dart';
import 'package:shopify/features/category/presentation/widgets/category_products.dart';
import 'package:shopify/features/home/presentation/widgets/featured_products_list.dart';

class FeaturedProducts extends StatefulWidget {
  const FeaturedProducts({super.key, required this.products});
  final List<ProductEntity> products;
  static String routeName = Constants.kFeaturedProducts;

  @override
  State<FeaturedProducts> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  bool isGridView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      "Featured Products",
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
                        isGridView: !isGridView,
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
                        isGridView: isGridView,
                        image: "assets/imgs/svgs/list_view.svg",
                      ),
                    ),
                  ],
                ),
              ),
              Gap(10),
              Expanded(
                child:
                    isGridView
                        ? FeaturedProductsList(
                          products: widget.products,
                          count: widget.products.length,
                          inHome: false,
                        )
                        : ListView.builder(
                          itemCount: widget.products.length,
                          itemBuilder: (context, index) {
                            return ProductListTile(
                              product: widget.products[index],
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
