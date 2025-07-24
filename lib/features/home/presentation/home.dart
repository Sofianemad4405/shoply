import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/category/presentation/cubit/home_categories_cubit/home_categories_cubit.dart';
import 'package:shopify/features/home/presentation/cubit/home_cubit.dart';
import 'package:shopify/features/home/presentation/widgets/home_page_view_body.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().init();
    context.read<HomeCategoriesCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeLoaded) {
          return RefreshIndicator(
            onRefresh: () => context.read<HomeCubit>().init(),
            child: HomePageViewBody(),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
