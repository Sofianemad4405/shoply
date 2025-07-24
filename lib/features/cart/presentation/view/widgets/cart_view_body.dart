import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shopify/features/cart/presentation/view/widgets/cart_products_list.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Gap(10),
            CustomAppBar(),
            Gap(10),
            CartProductsList(products: context.read<CartCubit>().cartProducts),
          ],
        ),
      ),
    );
  }
}
