import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopify/core/text_styles.dart';
import 'package:shopify/features/cart/cubits/cart_cubit.dart';
import 'package:shopify/features/cart/cubits/cart_states.dart';
import 'package:shopify/features/cart/view/widgets/custom_circular_container.dart';
import 'package:shopify/features/home/view/widgets/product_details.dart';

class Cart extends StatefulWidget {
  const Cart({super.key, required this.userData});

  final Map<String, dynamic> userData;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    for (int i = 0; i < context.read<CartCubit>().cartProducts.length; i++) {
      context.read<CartCubit>().totalPrice +=
          context.read<CartCubit>().cartProducts[i].price! *
          context.read<CartCubit>().cartProducts[i].qt!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<CartCubit, CartStates>(
        builder: (context, state) {
          if (state is NoProductsState) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Divider(),
                  Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delivery to", style: TextStyles.blackMedium),
                        Row(
                          children: [
                            Text(
                              "${widget.userData['location']}",
                              style: TextStyles.blackMedium,
                            ),
                            Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(10),
                  Divider(),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.54,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          state is ProductsLoadedState
                              ? state.products.length
                              : 0,
                      itemBuilder: (context, index) {
                        final product =
                            context.read<CartCubit>().cartProducts[index];
                        return GestureDetector(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          ProductDetails(product: product),
                                ),
                              ),
                          child: ListTile(
                            leading: Image.network(product.images?[0] ?? ""),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title!,
                                  style: TextStyles.blackMedium,
                                ),
                                Text(
                                  product.brand!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.greyLight,
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  "\$${product.price!} (Total : \$${product.price!.ceil() * product.qt!})",
                                ),
                                Spacer(),
                                CustomCircularContainer(
                                  onTap:
                                      () => setState(() {
                                        if (product.qt! > 0) {
                                          product.qt = product.qt! - 1;
                                          context
                                              .read<CartCubit>()
                                              .totalPrice -= product.price!;
                                        }
                                      }),
                                  text: "-",
                                ),
                                Gap(5),
                                Text(
                                  "${product.qt}",
                                  style: TextStyles.blackMedium,
                                ),
                                Gap(5),
                                CustomCircularContainer(
                                  onTap:
                                      () => setState(() {
                                        product.qt = product.qt! + 1;
                                        context.read<CartCubit>().totalPrice +=
                                            product.price!;
                                      }),
                                  text: "+",
                                ),
                                Gap(5),
                                CustomCircularContainer(
                                  onTap: () {
                                    context.read<CartCubit>().removeProduct(
                                      product,
                                    );
                                    context.read<CartCubit>().totalPrice -=
                                        product.price! * product.qt!;
                                  },
                                  icon: Ionicons.trash,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.read<CartCubit>().clearCart();
                          },
                          child: Text(
                            "Clear Cart",
                            style: TextStyles.blackMedium,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(),
                  Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Total ", style: TextStyles.blackMedium),
                            Spacer(),
                            Text(
                              "\$${context.read<CartCubit>().totalPrice.ceil()}",
                              style: TextStyles.blackMedium,
                            ),
                          ],
                        ),
                        Gap(10),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "Continue for payment",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
