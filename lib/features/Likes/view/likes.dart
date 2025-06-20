import 'package:flutter/material.dart';
import 'package:shopify/core/constants.dart';

class Likes extends StatefulWidget {
  const Likes({super.key});

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Likes")),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final product = Constants.likedProducts[index];
          return ListTile(
            leading: Image.network(product.images?[0] ?? ""),
            title: Text(product.title ?? ""),
            subtitle: Text("${product.price} ${product.stock}"),
            trailing: GestureDetector(
              onTap: () {
                setState(() {
                  Constants.likedProducts.remove(product);
                });
              },
              child: Icon(Icons.favorite, color: Colors.red),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(thickness: 0.2);
        },
        itemCount: Constants.likedProducts.length,
      ),
    );
  }
}
