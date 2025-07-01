import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/Likes/cubit/likes_cubit.dart';
import 'package:shopify/features/home/cubit/home_cubit.dart';

class Likes extends StatefulWidget {
  const Likes({super.key});

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  void initState() {
    context.read<LikesCubit>().getLikedProducts(
      context.read<HomeCubit>().allProducts,
    );
    log("ya alby ${context.read<LikesCubit>().likedBox.length}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Likes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<LikesCubit, LikesState>(
        builder: (context, state) {
          if (state is NoLikedProducts) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          if (state is LikesLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is LikesError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          if (state is LikesLoaded) {
            final likedProducts = state.likedProducts;
            return ListView.separated(
              itemBuilder: (context, index) {
                // final product = products[index];
                return ListTile(
                  leading: Image.network(likedProducts[index].images?[0] ?? ""),
                  title: Text(likedProducts[index].title ?? ""),
                  subtitle: Text(
                    "${likedProducts[index].price}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      context.read<LikesCubit>().removeFromLiked(
                        likedProducts[index],
                        likedProducts,
                      );
                    },
                    child: Icon(Icons.favorite, color: Colors.red),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(thickness: 0.2);
              },
              itemCount: likedProducts.length,
            );
          } else {
            return Text("Error");
          }
        },
      ),
    );
  }
}
