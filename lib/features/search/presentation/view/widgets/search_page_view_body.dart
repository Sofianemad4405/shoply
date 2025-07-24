import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopify/core/widgets/custom_app_bar.dart';
import 'package:shopify/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'package:shopify/features/search/presentation/cubit/cubit/search_cubit.dart';
import 'package:shopify/features/search/presentation/view/widgets/search_products_list.dart';

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
            CustomTextField(
              controller: controller,
              hintText: "Search",
              prefixIcon: Icon(Iconsax.search_normal_14),
              onChanged: (value) {
                setState(() {});
                context.read<SearchCubit>().search(value ?? '');
              },
              suffixIcon:
                  controller.text.isNotEmpty
                      ? GestureDetector(
                        onTap: () {
                          controller.clear();
                          context.read<SearchCubit>().search('');
                        },
                        child: Icon(Icons.close),
                      )
                      : null,
            ),
            Gap(20),
            BlocConsumer<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchSuccessAndThereAreProducts) {
                  return SearchProductsList(products: state.products);
                } else if (state is SearchSuccessAndThereAreNoProducts) {
                  return Center(child: Text(state.message));
                } else if (state is SearchFailure) {
                  return Center(child: Text(state.message));
                } else if (state is SearchInitial) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          "Search for something to get started.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
              listener: (context, state) {},
            ),
          ],
        ),
      ),
    );
  }
}
