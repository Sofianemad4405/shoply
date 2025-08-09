import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/providers/providers.dart';
import 'package:shopify/features/search/presentation/providers/search_notifier.dart';

final searchProvider =
    StateNotifierProvider<SearchNotifier, AsyncValue<List<ProductEntity>>>((
      ref,
    ) {
      return SearchNotifier(
        const AsyncValue.data(<ProductEntity>[]),
        ref.read(searchRepoProvider),
      );
    });
