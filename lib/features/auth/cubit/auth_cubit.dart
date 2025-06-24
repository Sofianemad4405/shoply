import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signUp(
    String email,
    String password,
    Map<String, dynamic> userData,
  ) async {
    emit(SignUpLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignUpSuccess(userCredential: userCredential, userData: userData));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignInError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignInError('The account already exists for that email.'));
      } else if (e.code == 'invalid-email') {
        emit(SignInError('The email address is invalid.'));
      }
    } catch (e) {
      emit(SignInError(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(SignInLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(SignInSuccess(userCredential: userCredential));
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
