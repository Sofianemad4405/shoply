// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:shopify/features/Info/cubits/cubit/profile_cubit.dart';
// import 'package:shopify/features/Likes/cubit/likes_cubit.dart';
// import 'package:shopify/features/auth/presentation/cubit/auth_cubit.dart';
// import 'package:shopify/features/cart/cubits/cart_cubit.dart';
// import 'package:shopify/features/home/cubit/home_cubit.dart';
// import 'package:shopify/features/home/service/home_service.dart';
// import 'package:shopify/features/home/view/categories_page.dart';
// import 'package:shopify/features/home/view/recent.dart';
// import 'package:shopify/features/home/view/widgets/banners.dart';
// import 'package:shopify/features/home/view/widgets/categories.dart';
// import 'package:shopify/features/home/view/widgets/custom_app_bar.dart';
// import 'package:shopify/features/home/view/widgets/custom_text_input_field.dart';
// import 'package:shopify/features/home/view/widgets/product_card.dart';
// import 'package:shopify/features/home/view/widgets/product_details.dart';
// import 'package:shopify/features/search/view/search_view_page.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   void initState() {
//     context.read<HomeCubit>().fetchAllProducts();
//     super.initState();
//   }

//   final SortBy = ["price", "rating", "title", "all"];
//   String sortMethod = "Not-Determined";
//   int currentIndex = 0;
//   PageController controller = PageController();

//   Future<void> onSubmitted(String value) async {
//     final products = await HomeService().searchProduct(value);
//     if (value.isNotEmpty) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder:
//               (context) => SearchViewPage(products: products, query: value),
//         ),
//       );
//     }
//     setState(() {});
//   }

//   Widget showAll(BuildContext context) {
//     return TextButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => CategoriesPage()),
//         );
//       },
//       child: Text(
//         "Show all",
//         style: TextStyle(
//           color: Colors.grey,
//           fontWeight: FontWeight.normal,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: false,
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: CustomScrollView(
//           physics: ClampingScrollPhysics(),
//           slivers: [
//             SliverToBoxAdapter(
//               child: Column(
//                 children: [
//                   Gap(40),

//                   //app bar
//                   CustomAppBar(
//                     location: context.read<AuthCubit>().userData.location,
//                   ),

//                   Gap(20),

//                   // search
//                   CustomTextInputField(
//                     controller: TextEditingController(),
//                     onSubmitted: onSubmitted,
//                   ),

//                   Gap(20),

//                   //banners
//                   Banners(),

//                   Gap(20),
//                   //category
//                   Row(
//                     children: [
//                       Text(
//                         "Category",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 20,
//                         ),
//                       ),
//                       Spacer(),
//                       showAll(context),
//                     ],
//                   ),
//                   Gap(20),

//                   //categories
//                   CategoriesList(),

//                   //recent
//                   Recent(
//                     sorted: sortMethod == "Not-Determined" ? false : true,
//                     onIconTap: () {
//                       log(context.read<HomeCubit>().isAsc.toString());
//                       context.read<HomeCubit>().isAsc =
//                           !context.read<HomeCubit>().isAsc;
//                       context.read<HomeCubit>().fetchProductsSorted(
//                         sortMethod,
//                         context.read<HomeCubit>().isAsc ? "asc" : "desc",
//                       );
//                       setState(() {});
//                     },
//                     sortBy: SortBy,
//                     onSelected: (selected) {
//                       if (selected == "all") {
//                         context.read<HomeCubit>().fetchAllProducts();
//                         sortMethod = "Not-Determined";
//                         setState(() {});
//                         return;
//                       }
//                       context.read<HomeCubit>().fetchProductsSorted(
//                         selected,
//                         context.read<HomeCubit>().isAsc ? "asc" : "desc",
//                       );
//                       sortMethod = selected;
//                       setState(() {});
//                     },
//                   ),

//                   Gap(20),

//                   //recent products grid
//                   BlocBuilder<HomeCubit, HomeState>(
//                     builder: (context, state) {
//                       if (state is HomeLoading) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                       if (state is HomeError) {
//                         return Center(child: Text(state.message));
//                       }
//                       if (state is HomeLoaded) {
//                         final products = state.products.values.toList();
//                         return GridView.builder(
//                           padding: EdgeInsets.zero,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: products.length,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 12,
//                                 mainAxisSpacing: 12,
//                                 childAspectRatio:
//                                     (MediaQuery.of(context).size.width / 2) /
//                                     (MediaQuery.of(context).size.height * 0.3),
//                               ),

//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             final product = products[index];
//                             return GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder:
//                                         (context) => ProductDetails(
//                                           isLiked: context
//                                               .read<LikesCubit>()
//                                               .isProductLiked(product.id),
//                                           product: product,
//                                           onAddToLikes: (product) {
//                                             context
//                                                 .read<LikesCubit>()
//                                                 .addProductToLikes(
//                                                   product,
//                                                   products,
//                                                 );
//                                           },
//                                           onRemoveFromLikes: (product) {
//                                             context
//                                                 .read<LikesCubit>()
//                                                 .removeFromLiked(
//                                                   product,
//                                                   products,
//                                                 );
//                                           },
//                                         ),
//                                   ),
//                                 );
//                               },
//                               child: ProductCard(
//                                 product: product,
//                                 onAddToCart: (product) {
//                                   context.read<CartCubit>().addProduct(
//                                     product,
//                                     products,
//                                   );
//                                 },
//                                 onRemoveFromCart: (product) {
//                                   context.read<CartCubit>().removeProduct(
//                                     product,
//                                     products,
//                                   );
//                                 },
//                                 onAddToLikes: (product) {
//                                   context.read<LikesCubit>().addProductToLikes(
//                                     product,
//                                     products,
//                                   );
//                                 },
//                                 onRemoveFromLikes: (product) {
//                                   context.read<LikesCubit>().removeFromLiked(
//                                     product,
//                                     products,
//                                   );
//                                 },
//                               ),
//                             );
//                           },
//                         );
//                       } else {
//                         return Center();
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> showSortingOptions(BuildContext context, Offset position) async {
//     final selected = await showMenu<String>(
//       context: context,
//       position: RelativeRect.fromLTRB(
//         position.dx,
//         position.dy,
//         position.dx,
//         position.dy,
//       ),
//       items:
//           SortBy.map(
//             (option) =>
//                 PopupMenuItem<String>(value: option, child: Text(option)),
//           ).toList(),
//     );

//     if (selected != null) {
//       context.read<HomeCubit>().fetchProductsSorted(
//         selected,
//         context.read<HomeCubit>().isAsc ? "asc" : "desc",
//       );
//     }
//   }
// }
