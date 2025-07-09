// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shopify/features/Likes/cubit/likes_cubit.dart';
// import 'package:shopify/features/cart/cubits/cart_cubit.dart';
// import 'package:shopify/features/home/model/product_model.dart';
// import 'package:shopify/features/home/service/home_service.dart';
// import 'package:shopify/features/home/view/widgets/product_card.dart';
// import 'package:shopify/features/home/view/widgets/product_details.dart';

// class SearchViewPage extends StatefulWidget {
//   const SearchViewPage({
//     super.key,
//     required this.products,
//     required this.query,
//   });

//   final List<Product> products;
//   final String query;

//   @override
//   State<SearchViewPage> createState() => _SearchViewPageState();
// }

// class _SearchViewPageState extends State<SearchViewPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.query,
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 24,
//           ),
//         ),
//       ),
//       body: FutureBuilder<List<Product>>(
//         future: HomeService().searchProduct(widget.query),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               final products = snapshot.data!;
//               return widget.products.isEmpty
//                   ? Center(
//                     child: Text(
//                       "No result found for '${widget.query}'",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 24,
//                       ),
//                     ),
//                   )
//                   : GridView.builder(
//                     itemCount: products.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                       childAspectRatio:
//                           MediaQuery.of(context).size.width /
//                           (MediaQuery.of(context).size.height * 0.6),
//                     ),
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder:
//                                   (context) =>
//                                       ProductDetails(product: products[index]),
//                             ),
//                           );
//                         },
//                         child: ProductCard(
//                           product: products[index],
//                           onAddToCart: (product) {
//                             context.read<CartCubit>().addProduct(
//                               product,
//                               products,
//                             );
//                           },
//                           onRemoveFromCart: (product) {
//                             context.read<CartCubit>().removeProduct(
//                               product,
//                               products,
//                             );
//                           },
//                           onAddToLikes: (product) {
//                             context.read<LikesCubit>().addProductToLikes(
//                               product,
//                               products,
//                             );
//                           },
//                           onRemoveFromLikes: (product) {
//                             context.read<LikesCubit>().removeFromLiked(
//                               product,
//                               products,
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   );
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
