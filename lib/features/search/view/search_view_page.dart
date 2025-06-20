import 'package:flutter/material.dart';
import 'package:shopify/features/home/model/product_model.dart';
import 'package:shopify/features/home/service/home_service.dart';
import 'package:shopify/features/home/view/widgets/product_card.dart';

class SearchViewPage extends StatefulWidget {
  const SearchViewPage({
    super.key,
    required this.products,
    required this.query,
  });

  final List<Product> products;
  final String query;

  @override
  State<SearchViewPage> createState() => _SearchViewPageState();
}

class _SearchViewPageState extends State<SearchViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.query,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: HomeService().searchProduct(widget.query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final products = snapshot.data!;
              return widget.products.isEmpty
                  ? Center(
                    child: Text(
                      "No result found for '${widget.query}'",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  )
                  : GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio:
                          MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height * 0.6),
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
