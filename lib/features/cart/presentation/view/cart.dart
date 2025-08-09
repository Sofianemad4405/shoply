import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shopify/features/cart/presentation/view/widgets/cart_view_body.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});
  // static String routeName = Constants.kCart;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return CartViewBody();
  }
}
