// import 'package:flutter/material.dart';
// import 'package:shopify/core/constants.dart';
// import 'package:shopify/features/home/view/category_products.dart';
// import 'package:shopify/features/home/view/widgets/category_card.dart';

// class CategoriesList extends StatelessWidget {
//   const CategoriesList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       child: ListView.builder(
//         itemCount: 5,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: CategoryCard(
//               image: Constants.categoryImages[index],
//               title: Constants.categories[index],
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
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
