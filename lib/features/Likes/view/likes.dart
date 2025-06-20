import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/constants.dart';
import 'package:shopify/features/Likes/cubit/likes_cubit.dart';

class Likes extends StatefulWidget {
  const Likes({super.key});

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
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
            return ListView.separated(
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
                  leading: Image.network(product.images?[0] ?? ""),
                  title: Text(product.title ?? ""),
                  subtitle: Text(
                    "${product.price}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      context.read<LikesCubit>().removeFromLiked(product);
                    },
                    child: Icon(Icons.favorite, color: Colors.red),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(thickness: 0.2);
              },
              itemCount: state.products.length,
            );
          } else {
            return Text("Error");
          }
        },
      ),
    );
  }
}
