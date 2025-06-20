import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopify/features/Info/view/info.dart';
import 'package:shopify/features/Likes/view/likes.dart';
import 'package:shopify/features/cart/view/cart.dart';
import 'package:shopify/features/home/model/product_model.dart';
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
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    log(fetchAllProducts().toString());
    super.initState();
  }

  Future<List<Product>> fetchAllProducts() async {
    return await HomeService().getAllProducts();
  }

  final SortBy = ["price", "rating", "title", "all"];

  String sortMethod = "Not-Determined";
  bool isAsc = true;

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
                  CustomAppBar(),

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
                    sorted: sortMethod == "Not-Determined" ? false : true,
                    onIconTap: () {
                      setState(() {
                        isAsc = !isAsc;
                      });
                    },
                    sortBy: SortBy,
                    onTap: () {
                      showSortingOptions(context);
                    },
                  ),
                  Gap(20),

                  //recent products grid
                  FutureBuilder<List<Product>>(
                    future:
                        sortMethod == "Not-Determined"
                            ? fetchAllProducts()
                            : HomeService().sortProductsByPrice(
                              sortMethod,
                              isAsc ? "asc" : "desc",
                            ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          final products = snapshot.data!;
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: products.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 4,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height *
                                          0.65),
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
                        } else if (snapshot.hasError) {
                          log(snapshot.error.toString());
                          return Center(
                            child: Text('Errorssssss: ${snapshot.error}'),
                          );
                        } else {
                          return Center(child: Text('No data'));
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
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
                        if (sortBy == "all") {
                          setState(() {
                            sortMethod = "Not-Determined";
                          });
                        } else {
                          setState(() {
                            sortMethod = sortBy;
                          });
                        }
                        Navigator.pop(context, sortBy);
                        setState(() {});
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
