import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopify/core/providers/providers.dart';
import 'package:shopify/features/auth/domain/entities/user_entity.dart';
import 'package:shopify/features/auth/domain/repos/auth_repo.dart';
import 'package:shopify/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:shopify/features/auth/domain/usecases/sign_up_usecase.dart';

class AuthNotifier extends Notifier<AsyncValue<UserEntity?>> {
  late final AuthRepo authRepo;

  @override
  AsyncValue<UserEntity?> build() {
    authRepo = ref.read(authRepoProvider);
    return const AsyncValue.data(null);
  }

  Future<UserEntity?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      final either = await SignInUseCase(authRepo)(email, password);
      return either.fold(
        (failure) => throw Exception("Error while login , try again .."),
        (user) => user,
      );
    });

    state = result;
    return state.value;
  }

  Future<UserEntity?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String location,
  }) async {
    state = const AsyncValue.loading();

    final result = await AsyncValue.guard(() async {
      final either = await SignUpUseCase(authRepo)(
        email: email,
        password: password,
        name: name,
        location: location,
      );
      return either.fold(
        (failure) => throw Exception("Error while signup , try again .."),
        (user) => user,
      );
    });

    state = result;
    return state.value;
  }
}

final authNotifierProvider =
    NotifierProvider<AuthNotifier, AsyncValue<UserEntity?>>(AuthNotifier.new);
