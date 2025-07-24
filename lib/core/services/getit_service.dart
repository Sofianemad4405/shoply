import 'package:get_it/get_it.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';
import 'package:shopify/core/services/fire_store_service.dart';
import 'package:shopify/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:shopify/features/auth/domain/repos/auth_repo.dart';
import 'package:shopify/features/cart/data/data_sources/cart_data_source.dart';
import 'package:shopify/features/cart/data/repos/cart_repo_impl.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<FireBaseAuthService>(FireBaseAuthService());
  getIt.registerSingleton<FireStoreService>(FireStoreService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImplementation(
      authService: getIt<FireBaseAuthService>(),
      databaseService: getIt<FireStoreService>(),
    ),
  );
  getIt.registerSingleton<CartRepoImpl>(
    CartRepoImpl(
      fireBaseAuthService: getIt<FireBaseAuthService>(),
      cartDataSource: CartDataSourceImpl(
        fireStoreService: getIt<FireStoreService>(),
        fireBaseAuthService: getIt<FireBaseAuthService>(),
      ),
    ),
  );
}
