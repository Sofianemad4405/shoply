import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shopify/features/Info/model/user_model.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  UserModel userData = UserModel(name: name, location: location);

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String location,
  }) async {
    emit(SignUpLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        this.userData = userData;
        saveUserData(user);
        emit(SignUpSuccess(userCredential: userCredential));
      } else {
        emit(SignUpError("User is null"));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpError('The account already exists for that email.'));
      } else if (e.code == 'invalid-email') {
        emit(SignUpError('The email address is invalid.'));
      }
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  ///hive storage
  void saveUserData(User user) async {
    var userBox = Hive.box('userBox');
    final userCredential = FirebaseAuth.instance.currentUser;

    await userBox.put('email', user.email);
    await userBox.put('name', user.displayName);
    await userBox.put('phone', user.phoneNumber);
    await userBox.put('location', user.email);
    await userBox.put('isLoggedIn', true);
    await userBox.put('userData', userData);
    await userBox.put('userCredential', userCredential);

    log("✅ User data saved to Hive.");
  }

  ///sign in
  Future<void> signIn(String email, String password) async {
    emit(SignInLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        saveUserData(user);
        emit(SignInSuccess(userCredential: userCredential));
      } else {
        emit(SignInError("User is null"));
      }
    } on FirebaseAuthException catch (e) {
      final errorMap = {
        'user-not-found': 'No user found for that email.',
        'wrong-password': 'Wrong password provided for that user.',
        'invalid-email': 'The email address is invalid.',
        'user-disabled': 'This account has been disabled.',
        'too-many-requests': 'Too many attempts. Please try again later.',
        'operation-not-allowed': 'Email/password accounts are not enabled.',
      };

      final errorMessage =
          errorMap[e.code] ?? 'An error occurred during login.';
      log('Authentication error: ${e.code} - $errorMessage');
      emit(SignInError(errorMessage));
    } catch (e) {
      log('Unexpected error: $e');
      emit(SignInError('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
