import 'package:get_it/get_it.dart';
import 'package:shopify/core/fire_base_auth_service.dart';
import 'package:shopify/core/services/database_service.dart';
import 'package:shopify/core/services/fire_store_service.dart';
import 'package:shopify/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:shopify/features/auth/domain/repos/auth_repo.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<FireBaseAuthService>(FireBaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireStoreService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImplementation(
      authService: getIt<FireBaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
}
