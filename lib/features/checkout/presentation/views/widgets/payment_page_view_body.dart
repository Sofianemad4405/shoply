import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/features/cart/presentation/view/widgets/proceed_to_checkout_button.dart';
import 'package:shopify/features/checkout/presentation/views/widgets/delivery_option_card%20.dart';

class PaymentPageViewBody extends StatefulWidget {
  const PaymentPageViewBody({super.key, required this.onButtonTap});

  final VoidCallback onButtonTap;

  @override
  State<PaymentPageViewBody> createState() => _PaymentPageViewBodyState();
}

class _PaymentPageViewBodyState extends State<PaymentPageViewBody> {
  int selectedOption = 0;
  bool sameAsDelivery = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Method",
            style: TextStyles.blackBold.copyWith(fontSize: 18),
          ),
          Gap(10),
          DeliveryOptionCard(
            isDefault: true,
            isSelected: selectedOption == 0,
            title: "Credit Card",
            subtitle: "Visa, Mastercard, Discover",
            price: "Free",
            onTap: () {
              setState(() {
                // selectedOption = 0;
              });
            },
          ),
          Gap(12),
          DeliveryOptionCard(
            isDefault: false,
            isSelected: selectedOption == 1,
            title: "PayPal",
            subtitle: "PayPal",
            price: "Free",
            onTap: () {
              setState(() {
                // selectedOption = 1;
              });
            },
          ),
          Gap(20),
          GestureDetector(
            onTap: () {
              // showDialog(
              //   context: context,
              //   builder: (context) => PaymentDialog(),
              // );
            },
            child: Text(
              "+  Add payment method",
              style: TextStyles.blackBold.copyWith(color: Color(0xff22C55E)),
            ),
          ),
          Gap(20),
          ProceedToCheckOutButton(
            text: "Continue to Review",
            onTap: widget.onButtonTap,
          ),
        ],
      ),
    );
  }
}
