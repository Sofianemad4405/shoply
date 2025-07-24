import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/text_styles.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/features/home/presentation/widgets/add_to_cart_button.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
    required this.product,
    this.onAddToLikes,
    this.onRemoveFromLikes,
    this.isLiked,
  });
  final Product product;
  final void Function(Product product)? onAddToLikes;
  final void Function(Product product)? onRemoveFromLikes;
  final bool? isLiked;
  static String routeName = Constants.kProductDetails;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: TextStyles.blackBold),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.product.images?[selectedIndex] ?? Constants.holderImage,
                height: 255.99.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Gap(5),

              //select viewed image
              SizedBox(
                height: 70.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.product.images!.length, (
                    index,
                  ) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                selectedIndex == index
                                    ? Border.all(color: Colors.green)
                                    : null,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Image.network(
                            widget.product.images![index],
                            height: 60.h,
                            width: 60.w,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Gap(10),

              // StreamBuilder(stream: FirebaseFirestore.instance.collection("wishlist").doc(widget.product.id.toString()).snapshots(), builder: (context, snapshot) {

              // }),
              Row(
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyles.blackBold.copyWith(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  IconButton(icon: Icon(Iconsax.heart), onPressed: () {}),
                ],
              ),
              Text(
                widget.product.brand ?? "Unknown brand",
                style: TextStyles.greyRegular.copyWith(fontSize: 20),
              ),
              Gap(10),
              Text(
                widget.product.details,
                style: TextStyles.greyRegular.copyWith(fontSize: 16),
              ),
              Gap(10),
              ProductMetaData(product: widget.product),
              Gap(10),
              Center(child: AddToCartButton(onTap: () {})),
              Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductMetaData extends StatefulWidget {
  const ProductMetaData({super.key, required this.product});

  final Product product;

  @override
  State<ProductMetaData> createState() => _ProductMetaDataState();
}

class _ProductMetaDataState extends State<ProductMetaData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: List.generate(widget.product.rating!.toInt(), (index) {
                return SvgPicture.asset(
                  "assets/imgs/svgs/Star_rating.svg",
                  height: 15,
                  width: 15,
                );
              }),
            ),
            Gap(10),
            Text(
              "${widget.product.rating.toString()} (${widget.product.reviews.length} reviews)",
              style: TextStyles.greyRegular.copyWith(fontSize: 16),
            ),
          ],
        ),
        Gap(10),
        Row(
          children: [
            Text(
              "\$${widget.product.price}",
              style: TextStyles.blackBold.copyWith(fontSize: 20),
            ),
            Gap(20),
            Text(
              "\$${widget.product.price + (widget.product.discountPercentage! / 100 * widget.product.price).round()}",
              style: TextStyle(
                color: Color(0xff6B7280),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(20),
            Container(
              height: 32.h,
              width: 80.8.w,
              decoration: BoxDecoration(
                color: Color(0xff21BD5A),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  "${widget.product.discountPercentage?.round()}% OFF",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(widget.product.tags!.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Container(
                height: 24.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 230, 231, 232),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.product.tags![index],
                      style: TextStyle(color: const Color(0xFF22C55E)),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        Gap(10),
        Row(
          children: [
            Container(
              height: 24.h,
              decoration: BoxDecoration(
                color: Color(0xffDCFCE7),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/imgs/svgs/Span.svg",
                      height: 8.h,
                      width: 8.w,
                    ),
                    Gap(5),
                    Text(
                      "${widget.product.stock} in stock",
                      style: TextStyle(
                        color: const Color(0xff16A34A),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
