import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/extention.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:shopify/features/checkout/presentation/views/widgets/delivery_dialog.dart';
import 'package:shopify/features/checkout/presentation/views/widgets/delivery_page_view_body.dart';
import 'package:shopify/features/checkout/presentation/views/widgets/payment_page_view_body.dart';
import 'package:shopify/features/checkout/presentation/views/widgets/review_page_view_body.dart';

class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({super.key});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  int currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentPage == 0) {
                      context.pop();
                    } else {
                      pageController.animateToPage(
                        currentPage - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  "Checkout",
                  style: TextStyles.blackBold.copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
          Gap(10),
          Divider(),
          Gap(10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CheckoutItem(
                        number: "1",
                        isViewed: currentPage >= 0,
                        name: "Delivery",
                        isViewing: currentPage == 0,
                      ),
                      CheckoutItem(
                        number: "2",
                        isViewed: currentPage >= 1,
                        name: "Payment",
                        isViewing: currentPage == 1,
                      ),
                      CheckoutItem(
                        number: "3",
                        isViewed: currentPage >= 2,
                        name: "Review",
                        isViewing: currentPage == 2,
                      ),
                    ],
                  ),
                  Gap(10),
                  Divider(),
                  Gap(20),
                  Expanded(
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                      children: [
                        DeliveryPageViewBody(
                          onTap: () {
                            context.read<CheckoutCubit>().deliveryAddress !=
                                    null
                                ? pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                )
                                : showDialog(
                                  context: context,
                                  builder: (context) => DeliveryDialog(),
                                );
                          },
                        ),
                        PaymentPageViewBody(
                          onButtonTap: () {
                            pageController.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        ReviewPageViewBody(
                          onButtonTap: () {
                            context.pushAndRemoveUntil(Constants.kRoot);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutItem extends StatefulWidget {
  const CheckoutItem({
    super.key,
    required this.number,
    required this.isViewed,
    required this.name,
    required this.isViewing,
  });

  final String number;
  final bool isViewed;
  final bool isViewing;
  final String name;

  @override
  State<CheckoutItem> createState() => _CheckoutItemState();
}

class _CheckoutItemState extends State<CheckoutItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(
            color:
                widget.isViewed ? const Color(0xff22C55E) : Color(0xffE5E7EB),
            shape: BoxShape.circle,
          ),
          child: Center(
            child:
                widget.isViewed && !widget.isViewing
                    ? Icon(Icons.check, color: Colors.white)
                    : widget.isViewing
                    ? Text(
                      widget.number,
                      style: TextStyles.blackMedium.copyWith(
                        color:
                            widget.isViewed ? Colors.white : Color(0xff6B7280),
                        fontSize: 16,
                      ),
                    )
                    : Text(
                      widget.number,
                      style: TextStyles.blackMedium.copyWith(
                        color:
                            widget.isViewed ? Colors.white : Color(0xff6B7280),
                        fontSize: 16,
                      ),
                    ),
          ),
        ),
        Text(
          widget.name,
          style: TextStyles.blackMedium.copyWith(
            color:
                widget.isViewing ? const Color(0xff22C55E) : Color(0xff6B7280),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
