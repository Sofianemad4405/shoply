import 'package:get_it/get_it.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';
import 'package:shopify/core/services/fire_store_service.dart';
import 'package:shopify/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:shopify/features/auth/domain/repos/auth_repo.dart';
import 'package:shopify/features/cart/data/data_sources/cart_data_source.dart';
import 'package:shopify/features/cart/data/repos/cart_repo_impl.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shopify/features/checkout/data/data_sources/checkout_data_source.dart';
import 'package:shopify/features/checkout/data/repos/checkout_repo_impl.dart';
import 'package:shopify/features/profile/presentation/cubit/cubit/profile_cubit.dart';
import 'package:shopify/features/wishlist/data/data_source/wishlist_data_source.dart';
import 'package:shopify/features/wishlist/data/repo/wishlist_repo_implementation.dart';
import 'package:shopify/features/checkout/presentation/cubit/checkout_cubit.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<FireBaseAuthService>(FireBaseAuthService());
  getIt.registerSingleton<FireStoreService>(FireStoreService());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      authService: getIt<FireBaseAuthService>(),
      databaseService: getIt<FireStoreService>(),
    ),
  );

  getIt.registerSingleton<CartDataSourceImpl>(
    CartDataSourceImpl(
      fireStoreService: getIt<FireStoreService>(),
      fireBaseAuthService: getIt<FireBaseAuthService>(),
    ),
  );

  getIt.registerSingleton<CartRepoImpl>(
    CartRepoImpl(
      fireBaseAuthService: getIt<FireBaseAuthService>(),
      cartDataSource: getIt<CartDataSourceImpl>(),
    ),
  );

  getIt.registerSingleton<CartCubit>(
    CartCubit(cartService: getIt<CartRepoImpl>()),
  );

  getIt.registerSingleton<WishListDataSourceImpl>(
    WishListDataSourceImpl(
      fireStoreService: getIt<FireStoreService>(),
      fireBaseAuthService: getIt<FireBaseAuthService>(),
    ),
  );

  getIt.registerSingleton<WishlistRepoImpl>(
    WishlistRepoImpl(
      fireBaseAuthService: getIt<FireBaseAuthService>(),
      wishListDataSourceImpl: getIt<WishListDataSourceImpl>(),
    ),
  );

  getIt.registerSingleton<CheckoutRepoImpl>(
    CheckoutRepoImpl(
      fireBaseAuthService: getIt<FireBaseAuthService>(),
      checkoutDataSource: CheckoutDataSourceImpl(
        fireStoreService: getIt<FireStoreService>(),
        fireBaseAuthService: getIt<FireBaseAuthService>(),
      ),
    ),
  );

  getIt.registerSingleton<CheckoutCubit>(
    CheckoutCubit(
      cartCubit: getIt<CartCubit>(),
      checkoutRepo: getIt<CheckoutRepoImpl>(),
    ),
  );

  getIt.registerSingleton<ProfileCubit>(
    ProfileCubit(
      authService: getIt<FireStoreService>(),
      fireBaseAuthService: getIt<FireBaseAuthService>(),
    ),
  );
}
