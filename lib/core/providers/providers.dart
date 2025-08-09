import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/core/services/api_service.dart';
import 'package:shopify/core/services/fire_store_service.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';
import 'package:shopify/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:shopify/features/cart/data/data_sources/cart_data_source.dart';
import 'package:shopify/features/cart/data/repos/cart_repo_impl.dart';
import 'package:shopify/features/category/data/datasource/category_data_source.dart';
import 'package:shopify/features/category/data/repo/category_repo_impl.dart';
import 'package:shopify/features/home/data/datasources/home_data_source.dart';
import 'package:shopify/features/home/data/repos/home_repo_impl.dart';
import 'package:shopify/features/search/data/datasources/search_data_source.dart';
import 'package:shopify/features/search/data/repos/search_repo_implementation.dart';
import 'package:shopify/features/wishlist/data/data_source/wishlist_data_source.dart';
import 'package:shopify/features/wishlist/data/repo/wishlist_repo_implementation.dart';

final cartRepoProvider = Provider(
  (ref) => CartRepoImpl(
    cartDataSource: ref.read(cartDataSourceProvider),
    fireBaseAuthService: ref.read(fireBaseAuthServiceProvider),
  ),
);

final cartDataSourceProvider = Provider(
  (ref) => CartDataSourceImpl(
    fireStoreService: ref.read(fireStoreServiceProvider),
    fireBaseAuthService: ref.read(fireBaseAuthServiceProvider),
  ),
);

final fireStoreServiceProvider = Provider((ref) => FireStoreService());

final fireBaseAuthServiceProvider = Provider((ref) => FireBaseAuthService());

final homeDataSourceProvider = Provider(
  (ref) => HomeDataSourceImlp(apiService: ref.read(apiServiceProvider)),
);

final apiServiceProvider = Provider(
  (ref) => ApiServiceImpl(dio: ref.read(dioProvider)),
);

final dioProvider = Provider((ref) => Dio());

final homeRepoProvider = Provider(
  (ref) => HomeRepoImpl(ref.read(homeDataSourceProvider)),
);

final searchDataSourceProvider = Provider(
  (ref) => SearchDataSourceImpl(apiService: ref.read(apiServiceProvider)),
);

final searchRepoProvider = Provider(
  (ref) => SearchRepoImplementation(
    searchDataSource: ref.read(searchDataSourceProvider),
    apiService: ref.read(apiServiceProvider),
  ),
);

final wishlistRepoProvider = Provider(
  (ref) => WishlistRepoImpl(
    wishListDataSourceImpl: ref.read(wishlistDataSourceProvider),
    fireBaseAuthService: ref.read(fireBaseAuthServiceProvider),
  ),
);

final wishlistDataSourceProvider = Provider(
  (ref) => WishListDataSourceImpl(
    fireStoreService: ref.read(fireStoreServiceProvider),
    fireBaseAuthService: ref.read(fireBaseAuthServiceProvider),
  ),
);

final categoryRepoProvider = Provider(
  (ref) => CategoryRepoImpl(
    categoryDataSource: ref.read(categoryDataSourceProvider),
  ),
);

final categoryDataSourceProvider = Provider(
  (ref) => CategoryDataSource(apiService: ref.read(apiServiceProvider)),
);

final authRepoProvider = Provider(
  (ref) => AuthRepoImpl(
    authService: ref.read(fireBaseAuthServiceProvider),
    databaseService: ref.read(fireStoreServiceProvider),
  ),
);
