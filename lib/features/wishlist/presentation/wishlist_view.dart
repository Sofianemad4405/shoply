import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/features/wishlist/presentation/cubit/cubit/wishlist_cubit.dart';
import 'package:shopify/features/wishlist/presentation/widgets/wishlist_view_body.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});
  static const routeName = Constants.kWishlist;

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: WishlistViewBody()));
  }
}
