import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'package:shopify/features/search/presentation/view/widgets/search_products_list.dart';
import 'package:shopify/features/search/presentation/providers/search_providers.dart';

class SearchPageViewBody extends StatefulWidget {
  const SearchPageViewBody({super.key});

  @override
  State<SearchPageViewBody> createState() => _SearchPageViewBodyState();
}

class _SearchPageViewBodyState extends State<SearchPageViewBody> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Gap(10),
            CustomAppBar(),
            Gap(20),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final search = ref.watch(searchProvider);
                return CustomTextField(
                  controller: controller,
                  hintText: "Search",
                  prefixIcon: Icon(Iconsax.search_normal_14),
                  onChanged: (value) {
                    ref.read(searchProvider.notifier).search(value ?? "");
                  },
                  suffixIcon:
                      controller.text.isNotEmpty
                          ? GestureDetector(
                            onTap: () {
                              controller.clear();
                              ref.read(searchProvider.notifier).search('');
                            },
                            child: Icon(Icons.close),
                          )
                          : null,
                );
              },
            ),
            Gap(20),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final search = ref.watch(searchProvider);
                return search.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Search for something to get started.",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                    return SearchProductsList(products: data);
                  },
                  error: (error, stackTrace) {
                    return Center(child: Text(error.toString()));
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
