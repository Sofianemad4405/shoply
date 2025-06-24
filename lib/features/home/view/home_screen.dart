import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shopify/features/home/cubit/home_cubit.dart';
import 'package:shopify/features/home/service/home_service.dart';
import 'package:shopify/features/home/view/categories_page.dart';
import 'package:shopify/features/home/view/recent.dart';
import 'package:shopify/features/home/view/widgets/banners.dart';
import 'package:shopify/features/home/view/widgets/categories.dart';
import 'package:shopify/features/home/view/widgets/custom_app_bar.dart';
import 'package:shopify/features/home/view/widgets/custom_text_input_field.dart';
import 'package:shopify/features/home/view/widgets/product_card.dart';
import 'package:shopify/features/home/view/widgets/product_details.dart';
import 'package:shopify/features/search/view/search_view_page.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<HomeCubit>().fetchAllProducts();
    super.initState();
  }

  final SortBy = ["price", "rating", "title"];

  String sortMethod = "Not-Determined";

  int currentIndex = 0;
  PageController controller = PageController();

  Future<void> onSubmitted(String value) async {
    final products = await HomeService().searchProduct(value);
    if (value.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => SearchViewPage(products: products, query: value),
        ),
      );
    }
    setState(() {});
  }

  Widget showAll(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoriesPage()),
        );
      },
      child: Text(
        "Show all",
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Gap(40),

                  //app bar
                  CustomAppBar(
                    location: widget.userData['location'] ?? "Zagazig city",
                  ),

                  Gap(20),

                  // search
                  CustomTextInputField(
                    controller: TextEditingController(),
                    onSubmitted: onSubmitted,
                  ),

                  Gap(20),

                  //banners
                  Banners(),

                  Gap(20),
                  //category
                  Row(
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      showAll(context),
                    ],
                  ),
                  Gap(20),

                  //categories
                  CategoriesList(),

                  //recent
                  Recent(
                    sorted: sortMethod != "Not-Determined" ? true : false,
                    onIconTap: () {
                      log(context.read<HomeCubit>().isAsc.toString());
                      context.read<HomeCubit>().isAsc =
                          !context.read<HomeCubit>().isAsc;
                    },
                    sortBy: SortBy,
                    onTap: () {
                      showSortingOptions(context);
                    },
                  ),
                  Gap(20),

                  //recent products grid
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is HomeError) {
                        return Center(child: Text(state.message));
                      }
                      if (state is HomeLoaded) {
                        final products = state.products;
                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio:
                                    (MediaQuery.of(context).size.width / 2) /
                                    (MediaQuery.of(context).size.height * 0.34),
                              ),

                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            ProductDetails(product: product),
                                  ),
                                );
                              },
                              child: ProductCard(product: product),
                            );
                          },
                        );
                      } else {
                        return Center();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showSortingOptions(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Sort By",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: SortBy.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        final sortBy = SortBy[index];
                        context.read<HomeCubit>().fetchProductsSorted(
                          sortBy,
                          context.read<HomeCubit>().isAsc ? "asc" : "desc",
                        );
                        sortMethod = sortBy;
                        Navigator.pop(context, sortBy);
                      },
                      title: Text(SortBy[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
