import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopify/features/Likes/cubit/likes_cubit.dart';
import 'package:shopify/features/cart/cubits/cart_cubit.dart';
import 'package:shopify/features/home/model/product_model.dart';
import 'package:shopify/features/home/view/widgets/product_details.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProductDetails(product: widget.product);
              },
            ),
          ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 253, 253, 253),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                  child: Image.network(
                    widget.product.images?[0] ?? "",
                    height: 120,
                    width: MediaQuery.of(context).size.width * .5,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: 120,
                        child: Center(
                          child: CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.product.isLiked = !widget.product.isLiked;
                      });
                      widget.product.isLiked
                          ? context.read<LikesCubit>().addToLiked(
                            widget.product,
                          )
                          : context.read<LikesCubit>().removeFromLiked(
                            widget.product,
                          );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 239, 239, 239),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.product.isLiked
                            ? Ionicons.heart
                            : Ionicons.heart_outline,
                        color:
                            widget.product.isLiked
                                ? Colors.red
                                : Colors.black38,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "\$${widget.product.price.toString()}",
                        style: TextStyle(
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          for (
                            int i = 0;
                            i < widget.product.rating!.toInt();
                            i++
                          )
                            Icon(Ionicons.star, color: Colors.amber, size: 8),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.product.isAddedToCart =
                        !widget.product.isAddedToCart;
                  });
                  if (widget.product.isAddedToCart) {
                    context.read<CartCubit>().addProduct(widget.product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,
                        duration: Duration(milliseconds: 800),
                        content: Text("Product added to cart Seccessfully!"),
                      ),
                    );
                  } else {
                    context.read<CartCubit>().removeProduct(widget.product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        duration: Duration(milliseconds: 800),
                        content: Text("Product removed from cart"),
                      ),
                    );
                  }
                },
                child:
                    !widget.product.isAddedToCart
                        ? Container(
                          width: double.infinity,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xff64BEA2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        )
                        : Container(
                          width: double.infinity,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Remove from Cart",
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
