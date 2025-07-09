// import 'package:flutter/material.dart';
// import 'package:shopify/core/constants.dart';
// import 'package:shopify/features/home/view/category_products.dart';
// import 'package:shopify/features/home/view/widgets/category_customCard.dart';

// class CategoriesPage extends StatelessWidget {
//   const CategoriesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Categories",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 6,
//           mainAxisSpacing: 4,
//           childAspectRatio: 1.1,
//         ),
//         itemCount: Constants.categories.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder:
//                         (context) => CategoryProducts(
//                           categoryName: Constants.categories[index],
//                         ),
//                   ),
//                 );
//               },
//               child: CategoryCustomCard(
//                 title: Constants.categories[index],
//                 imagePath: Constants.categoryImages[index],
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) => CategoryProducts(
//                             categoryName: Constants.categories[index],
//                           ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
