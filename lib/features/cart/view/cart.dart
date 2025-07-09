// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:shopify/core/text_styles.dart';
// import 'package:shopify/features/auth/data/model/user_model.dart';
// import 'package:shopify/features/Likes/cubit/likes_cubit.dart';
// import 'package:shopify/features/cart/cubits/cart_cubit.dart';
// import 'package:shopify/features/cart/cubits/cart_states.dart';
// import 'package:shopify/features/cart/view/widgets/custom_circular_container.dart';
// import 'package:shopify/features/home/cubit/home_cubit.dart';
// import 'package:shopify/features/home/view/widgets/product_details.dart';

// class Cart extends StatefulWidget {
//   const Cart({super.key});

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   @override
//   void initState() {
//     context.read<CartCubit>().getCartProducts(
//       context.read<HomeCubit>().allProducts,
//     );
//     log("ya alby ${context.read<CartCubit>().cartBox.length.toString()}");
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Your Cart",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: BlocBuilder<CartCubit, CartState>(
//         builder: (context, state) {
//           if (state is CartErrorState) {
//             return Center(
//               child: Text(
//                 state.error,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//             );
//           } else if (state is CartLoadedState) {
//             log("ya koko ${state.cartProducts.length.toString()}");
//             final products = state.cartProducts;
//             double totalPrice = 0;
//             for (var product in products) {
//               totalPrice += (product.price ?? 0) * (product.qt ?? 1);
//             }
//             return Column(
//               children: [
//                 Divider(),
//                 Gap(10),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Delivery to", style: TextStyles.blackMedium),
//                       Row(
//                         children: [
//                           Text(
//                             widget.userData?.location ?? "Location",
//                             style: TextStyles.blackMedium,
//                           ),
//                           Icon(Icons.keyboard_arrow_down),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Gap(10),
//                 Divider(),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.55,
//                   child: ListView.builder(
//                     padding: EdgeInsets.zero,
//                     physics: const BouncingScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap:
//                             () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder:
//                                     (context) => ProductDetails(
//                                       isLiked: products[index].isLiked,
//                                       product: products[index],
//                                       onAddToLikes: (product) {
//                                         context
//                                             .read<LikesCubit>()
//                                             .addProductToLikes(
//                                               product,
//                                               products,
//                                             );
//                                       },
//                                       onRemoveFromLikes: (product) {
//                                         context
//                                             .read<LikesCubit>()
//                                             .removeFromLiked(product, products);
//                                       },
//                                     ),
//                               ),
//                             ),
//                         child: ListTile(
//                           leading: Image.network(
//                             products[index].images?[0] ?? "",
//                             errorBuilder: (context, error, stackTrace) {
//                               return Icon(Icons.error);
//                             },
//                             loadingBuilder: (context, child, loadingProgress) {
//                               if (loadingProgress == null) return child;
//                               return SizedBox(
//                                 height: 120,
//                                 child: Center(
//                                   child: CircularProgressIndicator(
//                                     value:
//                                         loadingProgress.expectedTotalBytes !=
//                                                 null
//                                             ? loadingProgress
//                                                     .cumulativeBytesLoaded /
//                                                 (loadingProgress
//                                                         .expectedTotalBytes ??
//                                                     1)
//                                             : null,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           title: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 products[index].title!,
//                                 style: TextStyles.blackMedium,
//                               ),
//                               Text(
//                                 products[index].brand ?? "Unknown Brand",
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyles.greyLight,
//                               ),
//                             ],
//                           ),
//                           subtitle: Row(
//                             children: [
//                               Text(
//                                 "\$${products[index].price!} (Total : \$${(products[index].price! * products[index].qt!).toStringAsFixed(2)})",
//                               ),
//                               Spacer(),
//                               CustomCircularContainer(
//                                 onTap:
//                                     () => setState(() {
//                                       if (products[index].qt! > 0) {
//                                         products[index].qt =
//                                             products[index].qt! - 1;
//                                         totalPrice -= products[index].price!;
//                                       }
//                                     }),
//                                 text: "-",
//                               ),
//                               Gap(5),
//                               Text(
//                                 "${products[index].qt}",
//                                 style: TextStyles.blackMedium,
//                               ),
//                               Gap(5),
//                               CustomCircularContainer(
//                                 onTap:
//                                     () => setState(() {
//                                       products[index].qt =
//                                           products[index].qt! + 1;
//                                       totalPrice += products[index].price!;
//                                     }),
//                                 text: "+",
//                               ),
//                               Gap(5),
//                               CustomCircularContainer(
//                                 onTap: () {
//                                   context.read<CartCubit>().removeProduct(
//                                     products[index],
//                                     products,
//                                   );
//                                   totalPrice -=
//                                       products[index].price! *
//                                       products[index].qt!;
//                                 },
//                                 icon: Ionicons.trash,
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           context.read<CartCubit>().clearCart();
//                         },
//                         child: Text(
//                           "Clear Cart",
//                           style: TextStyles.blackMedium,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text("Total ", style: TextStyles.blackMedium),
//                           Spacer(),
//                           Text(
//                             "\$${totalPrice.toStringAsFixed(2)}",
//                             style: TextStyles.blackMedium,
//                           ),
//                         ],
//                       ),
//                       Gap(10),
//                       Container(
//                         height: 50,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade400,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Continue for payment",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           } else if (state is NoCartProductsState) {
//             log("ya koko ${state.message}");
//             return Center(
//               child: Text(
//                 state.message,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//             );
//           } else {
//             log("ya koko");
//             return Center(
//               child: Text(
//                 "Unexpected Error , Don't worry we will solve the problem Soon",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
