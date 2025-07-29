import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shopify/features/cart/presentation/view/widgets/proceed_to_checkout_button.dart';
import 'package:shopify/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:shopify/features/checkout/presentation/views/widgets/delivery_page_view_body.dart';

class ReviewPageViewBody extends StatelessWidget {
  const ReviewPageViewBody({super.key, required this.onButtonTap});

  final VoidCallback onButtonTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final cubit = context.read<CheckoutCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery Details",
              style: TextStyles.blackBold.copyWith(fontSize: 18),
            ),
            Gap(20),
            AddressDetails(deliveryInfo: cubit.getDeliveryAddress()!),
            Gap(20),
            Text(
              "Order Summmary",
              style: TextStyles.blackBold.copyWith(fontSize: 18),
            ),
            Container(
              height: 0.21.sh,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffE5E7EB),
                border: Border.all(width: 0.5, color: Color(0xffE5E7EB)),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: BlocBuilder<CheckoutCubit, CheckoutState>(
                  builder: (context, state) {
                    return ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: cubit.checkoutProducts.length,
                      itemBuilder: (context, index) {
                        final product = cubit.checkoutProducts[index];
                        return Row(
                          children: [
                            Text("${product.quantity} x "),
                            Gap(5.w),
                            Expanded(
                              child: Text(
                                product.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${(product.price * product.quantity).toString()}",
                              style: TextStyles.blackBold.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Gap(20),
            Spacer(),
            ProceedToCheckOutButton(
              text: "Place order",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Order placed Successfully!")),
                );
                context.read<CartCubit>().clearCart();
                context.read<CheckoutCubit>().clearCheckout();
                context.pushAndRemoveUntil(Constants.kRoot);
              },
            ),
            Gap(20),
          ],
        );
      },
    );
  }
}
