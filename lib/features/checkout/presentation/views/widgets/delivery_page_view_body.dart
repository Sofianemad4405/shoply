import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/features/cart/presentation/view/widgets/proceed_to_checkout_button.dart';
import 'package:shopify/features/checkout/domain/entities/delivery_entity.dart';
import 'package:shopify/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:shopify/features/checkout/presentation/views/checkout.dart';
import 'package:shopify/features/checkout/presentation/views/widgets/delivery_option_card%20.dart';
import 'package:shopify/features/checkout/presentation/views/widgets/delivery_dialog.dart';

class DeliveryPageViewBody extends StatefulWidget {
  const DeliveryPageViewBody({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  State<DeliveryPageViewBody> createState() => _DeliveryPageViewBodyState();
}

class _DeliveryPageViewBodyState extends State<DeliveryPageViewBody> {
  int selectedOption = 0;

  @override
  void initState() {
    super.initState();
    // selectedOption = context.read<CheckoutCubit>().getDeliveryMethod() ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Address",
            style: TextStyles.blackBold.copyWith(fontSize: 18),
          ),
          Gap(10),
          BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
              if (state is DeliveryAddressUpdated) {
                return AddressDetails(deliveryInfo: state.deliveryInfo);
              }
              return Container(
                height: 158.91.h,
                width: 361.59.w,
                decoration: BoxDecoration(
                  color: Color(0xffE5E7EB),
                  border: Border.all(width: 0.5, color: Color(0xffE5E7EB)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap:
                        () => showDialog(
                          context: context,
                          builder: (context) => DeliveryDialog(),
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/imgs/svgs/location.svg"),
                        Gap(10),
                        Text(
                          "Tap to add your address",
                          style: TextStyles.blackBold.copyWith(
                            fontSize: 16,
                            color: Color(0xff22C55E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Gap(20),
          Text(
            "Delivery Method",
            style: TextStyles.blackBold.copyWith(fontSize: 18),
          ),
          Gap(10),
          DeliveryOptionCard(
            isDefault: true,
            isSelected: selectedOption == 0,
            title: "Standard Delivery",
            subtitle: "3-5 business days",
            price: "Free",
            onTap: () {
              setState(() {
                selectedOption = 0;
              });
            },
          ),
          SizedBox(height: 12),
          DeliveryOptionCard(
            isDefault: false,
            isSelected: selectedOption == 1,
            title: "Express Delivery",
            subtitle: "1-2 business days",
            price: "\$9.99",
            onTap: () {
              setState(() {
                selectedOption = 1;
              });
            },
          ),
          Gap(20),
          ProceedToCheckOutButton(
            text: "Continue to Payment",
            onTap: () {
              widget.onTap();
              // selectedOption==1?
              // if (selectedOption == 1) {
              //   context.read<CheckoutCubit>().toggleDeliveryMethod(false);
              // }
            },
          ),
        ],
      ),
    );
  }
}

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key, required this.deliveryInfo});

  final DeliveryEntity deliveryInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 400.w,
      decoration: BoxDecoration(
        color: Color(0xffE5E7EB),
        border: Border.all(width: 0.5, color: Color(0xffE5E7EB)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/imgs/svgs/location.svg"),
                Gap(10),
                Text(
                  "Home",
                  style: TextStyles.blackBold.copyWith(fontSize: 16),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deliveryInfo.street,
                    style: TextStyles.blackRegular.copyWith(
                      fontSize: 16,
                      color: Color(0xff4B5563),
                    ),
                  ),
                  Gap(10),
                  Text(
                    deliveryInfo.apartment,
                    style: TextStyles.blackRegular.copyWith(
                      fontSize: 16,
                      color: Color(0xff4B5563),
                    ),
                  ),
                  Gap(10),
                  Text(
                    "${deliveryInfo.city}, ${deliveryInfo.governate} ${deliveryInfo.zipCode}",
                    style: TextStyles.blackRegular.copyWith(
                      fontSize: 16,
                      color: Color(0xff4B5563),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => DeliveryDialog(),
                );
              },
              child: Text(
                "Change",
                style: TextStyles.blackMedium.copyWith(
                  fontSize: 16,
                  color: Color(0xff22C55E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
