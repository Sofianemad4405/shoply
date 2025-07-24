import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shopify/features/cart/presentation/view/widgets/cart_view_body.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    context.read<CartCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return state is CartLoadingState
            ? const Center(child: CircularProgressIndicator())
            : state is CartLoadedState
            ? const CartViewBody()
            : state is CartErrorState
            ? Center(child: Text(state.error))
            : state is CartNoProductsState
            ? const Center(child: Text("No Products In Cart"))
            : const CartViewBody();
      },
    );
  }
}
