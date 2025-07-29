import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/core/widgets/grid_or_list.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shopify/features/category/presentation/cubit/caterories_products_cubit/category_products_cubit.dart';
import 'package:shopify/features/category/presentation/widgets/pop_up_menu.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/core/widgets/product_card.dart';
import 'package:shopify/features/home/presentation/widgets/product_details.dart';
import 'package:shopify/features/wishlist/presentation/cubit/cubit/wishlist_cubit.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({super.key, required this.categoryName});
  final String categoryName;
  static String routeName = Constants.kCategoryProducts;

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  void initState() {
    log(widget.categoryName);
    fetchProducts();
    super.initState();
  }

  void fetchProducts() async {
    final fetched = await context
        .read<CategoryProductsCubit>()
        .fetchCategoryProducts(widget.categoryName, products);
    setState(() {
      products = fetched;
    });
    log(products.length.toString());
  }

  List<Product> products = [];

  bool isGridView = true;
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
              child: Row(
                children: [
                  Text(
                    "${products.length} products found",
                    style: TextStyles.greymini.copyWith(fontSize: 18),
                  ),
                  Spacer(),
                  CustomPopUpMenu(
                    title: context.read<CategoryProductsCubit>().sortMethod,
                    items: [
                      PopupMenuItem(value: 'name', child: Text('Sort by Name')),
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
                      context.read<CategoryProductsCubit>().sortMethod = value;
                      context
                          .read<CategoryProductsCubit>()
                          .fetchCategoryProducts(widget.categoryName, products);
                      setState(() {});
                    },
                    image: "assets/imgs/svgs/sort.svg",
                  ),
                  Gap(20),
                  CustomPopUpMenu(
                    title: context.read<CategoryProductsCubit>().order,
                    items: [
                      PopupMenuItem(value: 'asc', child: Text('Ascending')),
                      PopupMenuItem(value: 'desc', child: Text('Descending')),
                    ],
                    onSelected: (value) {
                      context.read<CategoryProductsCubit>().order = value;
                      context
                          .read<CategoryProductsCubit>()
                          .fetchCategoryProducts(widget.categoryName, products);
                      setState(() {});
                    },
                    image: "assets/imgs/svgs/filter.svg",
                  ),
                ],
              ),
            ),
            Gap(20),
            BlocConsumer<CategoryProductsCubit, CategoryProductsState>(
              listener: (context, state) {
                if (state is CategoryProductsError) {
                  log(state.message);
                  context.pop();
                }
                if (state is CategoryProductsLoaded) {
                  products = state.products;
                }
              },
              builder: (context, state) {
                return state is CategoryProductsLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
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
                                            screenWidth / (screenHeight / 1.21),
                                      ),
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    return ProductCard(
                                      product: products[index],
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
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap:
                                          () => context.push(
                                            ProductDetails.routeName,
                                            arguments: products[index],
                                          ),
                                      child: ProductListTile(
                                        product: products[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: Image.network(product.image ?? Constants.holderImage),
          title: Text(
            product.name,
            style: TextStyles.blackBold.copyWith(fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.details,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    "\$${product.price}",
                    style: TextStyle(color: const Color(0xFF22C55E)),
                  ),
                  Spacer(),
                  BlocBuilder<WishlistCubit, WishlistState>(
                    builder: (context, state) {
                      return IconButton(
                        icon: Icon(
                          context.read<WishlistCubit>().isInWishlist(product.id)
                              ? Iconsax.heart5
                              : Iconsax.heart,
                          color:
                              context.read<WishlistCubit>().isInWishlist(
                                    product.id,
                                  )
                                  ? Colors.red
                                  : Colors.grey,
                        ),
                        onPressed: () {
                          context
                              .read<WishlistCubit>()
                              .toggleWishlistOptimistically(product);
                        },
                      );
                    },
                  ),

                  BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {
                      // if (state is CartAddingState) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: const Text("Adding product to cart..."),
                      //       behavior: SnackBarBehavior.floating,
                      //       backgroundColor: Colors.green,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12),
                      //       ),
                      //       duration: Duration(milliseconds: 500),
                      //     ),
                      //   );
                      // } else if (state is CartRemovingState) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: const Text(
                      //         "Removing product from cart...",
                      //       ),
                      //       duration: Duration(seconds: 1),
                      //       behavior: SnackBarBehavior.floating,
                      //       backgroundColor: Colors.red,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12),
                      //       ),
                      //     ),
                      //   );
                      // }
                    },
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          context.read<CartCubit>().toggleCartOptimistically(
                            product,
                          );
                        },
                        child:
                            !context.read<CartCubit>().isInCart(product.id)
                                ? SvgPicture.asset(
                                  "assets/imgs/svgs/cart.svg",
                                  colorFilter: ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.srcIn,
                                  ),
                                )
                                : SvgPicture.asset(
                                  "assets/imgs/svgs/trash.svg",
                                  colorFilter: ColorFilter.mode(
                                    Colors.red,
                                    BlendMode.srcIn,
                                  ),
                                ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
