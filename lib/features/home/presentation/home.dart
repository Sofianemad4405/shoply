import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/features/home/presentation/providers/home_providers.dart';
import 'package:shopify/features/home/presentation/widgets/home_page_view_body.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HomePageViewBody(
      categoriesNotifier: categoriesProvider,
      homeProductsNotifier: homeProductsProvider,
    );
  }
}
