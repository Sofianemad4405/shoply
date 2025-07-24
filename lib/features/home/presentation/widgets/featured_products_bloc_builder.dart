import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/home/presentation/cubit/home_cubit.dart';
import 'package:shopify/features/home/presentation/widgets/featured_products_list.dart';

class FeaturedProductsBlocBuilder extends StatelessWidget {
  const FeaturedProductsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is HomeError) {
          return Center(child: Text(state.message));
        }
        if (state is HomeLoaded) {
          return FeaturedProductsList(
            products: state.products,
            count: 8,
            inHome: true,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
