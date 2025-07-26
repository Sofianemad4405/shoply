import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/wishlist/presentation/cubit/cubit/wishlist_cubit.dart';
import 'package:shopify/features/wishlist/presentation/widgets/no_products_state_view.dart';
import 'package:shopify/features/wishlist/presentation/widgets/wishlist_products_list.dart';

class WishlistViewBodyBlocConsumer extends StatelessWidget {
  const WishlistViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistCubit, WishlistState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is NoProductsInWIshlistState
            ? NoProductsStateView()
            : state is WishlistProductsLoadedState
            ? WishlistProductsList(products: state.wishlistProducts)
            : state is WishlistProductsLoadingState
            ? const Center(child: CircularProgressIndicator())
            : Center(child: Text("Enexpected Error"));
      },
    );
  }
}
