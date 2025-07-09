import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shopify/core/errors/fire_base_auth_failure.dart';
import 'package:shopify/core/fire_base_auth_service.dart';
import 'package:shopify/features/auth/domain/repos/auth_repo.dart';
import 'package:shopify/features/auth/domain/models/user_entity.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required this.authRepo}) : super(SignupInitial());
  final AuthRepo authRepo;

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String location,
  }) async {
    try {
      emit(SignupLoading());
      log("⏳ calling authRepo...");
      final result = await authRepo.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        location: location,
      );
      log("✅ authRepo returned");
      result.fold(
        (failure) => emit(SignupError(message: failure.errorMessage)),
        (user) => emit(SignupSuccess(user: user)),
      );
    } on FireBaseAuthFailure catch (e) {
      log("❌ FirebaseAuthFailure: ${e.code}");
      emit(SignupError(message: e.code));
    }
  }
}
