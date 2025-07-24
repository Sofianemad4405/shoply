// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shopify/features/home/domain/model/product_model.dart';

// Future<void> addProductToWishlist(Product product) async {
//   final userId = FirebaseAuth.instance.currentUser?.uid;
//   await FirebaseFirestore.instance
//       .collection('users')
//       .doc(userId)
//       .collection('wishlist')
//       .doc(product.id.toString())
//       .set(product.toJson());
// }

// Future<void> removeProductFromWishlist(Product product) async {
//   final userId = FirebaseAuth.instance.currentUser?.uid;
//   await FirebaseFirestore.instance
//       .collection('users')
//       .doc(userId)
//       .collection('wishlist')
//       .doc(product.id.toString())
//       .delete();
// }

// Future<void> removeProductFromCart(Product product) async {
//   final userId = FirebaseAuth.instance.currentUser?.uid;
//   await FirebaseFirestore.instance
//       .collection('users')
//       .doc(userId)
//       .collection('cart')
//       .doc(product.id.toString())
//       .delete();
// }

// Future<void> addProductToCart(Product product) async {
//   final userId = FirebaseAuth.instance.currentUser?.uid;
//   await FirebaseFirestore.instance
//       .collection('users')
//       .doc(userId)
//       .collection('cart')
//       .doc(product.id.toString())
//       .set(product.toJson());
// }
