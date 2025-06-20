import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopify/features/home/model/product_model.dart';
import 'package:shopify/features/home/service/home_service.dart';
import 'package:shopify/features/home/view/widgets/product_card.dart';
import 'package:shopify/features/home/view/widgets/product_details.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  Future<List<Product>> fetchCategoryProducts() async {
    return await HomeService().getProductsByCategory(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchCategoryProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final products = snapshot.data!;
              return GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 4,
                  childAspectRatio: 0.8,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ProductDetails(product: product),
                        ),
                      );
                    },
                    child: ProductCard(product: product),
                  );
                },
              );
            } else if (snapshot.hasError) {
              log(snapshot.error.toString());
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Center(child: Text('No data'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
