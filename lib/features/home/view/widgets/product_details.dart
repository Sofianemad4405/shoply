import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopify/core/constants.dart';
import 'package:shopify/core/text_styles.dart';
import 'package:shopify/features/home/model/product_model.dart';
import 'package:shopify/features/home/view/widgets/review_list_tile.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  bool isFollowed = false;

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: TextStyles.blackBold),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //selected Image
            Stack(
              children: [
                Image.network(
                  widget.product.images?[selectedIndex] ??
                      Constants.holderImage,
                ),
                QRCode(widget: widget),
              ],
            ),

            Gap(5),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              widget.product.title ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${widget.product.price.toString()} (${widget.product.stock} available)",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,

                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Row(
                              children: [
                                for (
                                  int i = 0;
                                  i < widget.product.rating!.toInt();
                                  i++
                                )
                                  Icon(
                                    Ionicons.star,
                                    color: Colors.amber,
                                    size: 12,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          log(widget.product.meta?.barcode ?? "");
                          setState(() {
                            Constants.likedProducts.add(widget.product);
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 239, 239, 239),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFavorite
                                ? Ionicons.heart
                                : Ionicons.heart_outline,
                            color: isFavorite ? Colors.red : Colors.black38,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Gap(20),
                  Center(
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: widget.product.images?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color:
                                      selectedIndex == index
                                          ? Colors.black
                                          : Colors.transparent,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Image.network(
                                widget.product.images?[index] ??
                                    Constants.holderImage,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Gap(10),
                  Text(
                    widget.product.description ??
                        "No Description For this Product",
                  ),

                  //brand
                  Gap(10),
                  Divider(thickness: 0.5),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //brand name
                      Text(
                        widget.product.brand ?? "Unknown Brand",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      //follow button
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFollowed = !isFollowed;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                            color:
                                !isFollowed
                                    ? const Color.fromARGB(255, 242, 242, 242)
                                    : Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              !isFollowed ? "Follow" : "Following",
                              style: TextStyle(
                                color:
                                    !isFollowed ? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Gap(10),
                  Divider(thickness: 0.5),
                  Gap(10),

                  //rating
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // stars
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.product.reviews?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ReviewListTile(
                            name: widget.product.reviews![index].reviewerName,
                            email: widget.product.reviews![index].reviewerEmail,
                            comment: widget.product.reviews![index].comment,
                            image: Constants.myImages[index],
                            rating: widget.product.reviews![index].rating,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QRCode extends StatelessWidget {
  const QRCode({super.key, required this.widget});

  final ProductDetails widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        height: 70,
        width: 70,
        child: GestureDetector(
          onTap: () {
            log("Sofian");
            showDialog(
              context: context,
              builder:
                  (context) => Dialog(
                    backgroundColor: Colors.transparent,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Center(
                        child: Image.network(
                          widget.product.meta?.qrCode ?? Constants.holderImage,
                        ),
                      ),
                    ),
                  ),
            );
          },
          child: Image.network(
            widget.product.meta?.qrCode ?? Constants.holderImage,
          ),
        ),
      ),
    );
  }
}
