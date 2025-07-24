import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shopify/features/cart/presentation/view/widgets/cart_products_list.dart';
import 'package:shopify/features/cart/presentation/view/widgets/proceed_to_checkout_button.dart';

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
            BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                if (state is CartErrorState) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        state is CartLoadedState
                            ? CartProductsList(products: state.cartProducts)
                            : state is CartLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : state is CartErrorState
                            ? Center(child: Text(state.error))
                            : Center(
                              child: Text(
                                "Your Shoply cart is empty",
                                style: TextStyles.blackMedium.copyWith(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                        if (state is CartLoadedState)
                          ProceedToCheckOutButton(text: "Proceed to checkout"),
                        Gap(10),
                      ],
                    ),
                  ),
                );
              },
            ),
            Gap(10),
          ],
        ),
      ),
    );
  }
}
